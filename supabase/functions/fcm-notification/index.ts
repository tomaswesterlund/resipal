import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'
import { JWT } from "npm:google-auth-library@9"

const serviceAccount = JSON.parse(Deno.env.get('FIREBASE_SERVICE_ACCOUNT') || '{}')

serve(async (req) => {
  // Initialize Supabase Client early for logging
  const supabase = createClient(
    Deno.env.get('SUPABASE_URL') ?? '',
    Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
  )

  const logToSupabase = async (level: string, message: string, metadata: any = {}, stack?: string) => {
    console.log(`[${level}] ${message}`) // Still log to console for Edge Function logs
    await supabase.from('logs').insert({
      level,
      message,
      metadata,
      stack_trace: stack,
      feature_area: 'push_notifications',
      platform: metadata?.platform || 'backend'
    })
  }

  try {
    const payload = await req.json()
    const { record } = payload
    
    await logToSupabase('INFO', `Processing notification for user: ${record.user_id}`, { notification_id: record.id })

    // 1. Fetch the FCM token
    const { data: userData, error: userError } = await supabase
      .from('users')
      .select('fcm_token')
      .eq('id', record.user_id)
      .single()

    if (userError || !userData?.fcm_token) {
      const errorMsg = `Token lookup failed for user: ${record.user_id}`
      await logToSupabase('ERROR', errorMsg, { userError, record_id: record.id })
      throw new Error(errorMsg)
    }

    // 2. Generate OAuth2 Access Token
    let authHeader;
    try {
      const client = new JWT({
        email: serviceAccount.client_email,
        key: serviceAccount.private_key,
        scopes: ['https://www.googleapis.com/auth/firebase.messaging'],
      })
      authHeader = await client.getAccessToken()
    } catch (jwtError) {
      await logToSupabase('ERROR', 'JWT Authentication with Google failed', { error: jwtError.message })
      throw jwtError
    }

    // 3. Send to FCM v1
    const fcmRes = await fetch(
      `https://fcm.googleapis.com/v1/projects/${serviceAccount.project_id}/messages:send`,
      {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${authHeader.token}`,
        },
        body: JSON.stringify({
          message: {
            token: userData.fcm_token,
            notification: { 
              title: record.title || "New Notification", 
              body: record.body || "" 
            },
            data: { notification_id: record.id.toString() }
          },
        }),
      }
    )

    const fcmResult = await fcmRes.json()

    if (!fcmRes.ok) {
      await logToSupabase('ERROR', 'FCM API returned an error', { fcmResult, user_id: record.user_id })
      return new Response(JSON.stringify(fcmResult), { status: fcmRes.status })
    }

    await logToSupabase('INFO', 'Notification sent successfully', { fcm_message_id: fcmResult.name, user_id: record.user_id })
    return new Response(JSON.stringify({ sent: true }), { status: 200 })

  } catch (error) {
    // Final catch-all for unexpected crashes
    await logToSupabase('ERROR', `Edge Function Crash: ${error.message}`, {}, error.stack)
    return new Response(JSON.stringify({ error: error.message }), { status: 500 })
  }
})
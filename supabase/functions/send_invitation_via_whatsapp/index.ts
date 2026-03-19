import { serve } from "https://deno.land/std@0.168.0/http/server.ts";

const WHATSAPP_TOKEN = Deno.env.get("WHATSAPP_TOKEN");
const PHONE_NUMBER_ID = Deno.env.get("PHONE_NUMBER_ID");

serve(async (req) => {
  try {
    const { record } = await req.json();

    const requiredFields = ["person_name", "community_name", "google_play_link", "phone_number"];
    const missingFields = [];

    // 1. Validation Logic
    for (const field of requiredFields) {
      if (!record[field] || record[field].toString().trim() === "") {
        missingFields.push(field);
      }
    }

    if (missingFields.length > 0) {
      const text = missingFields.join(", ");
      return new Response(
        JSON.stringify({
          error: "Missing or empty required parameters: " + text,
          received_record: record,
        }),
        { status: 400, headers: { "Content-Type": "application/json" } },
      );
    }

    // 2. Formatting
    const cleanPhone = record.phone_number.toString().replace(/\D/g, "");

    // 3. WhatsApp Fetch
    const res = await fetch(`https://graph.facebook.com/v22.0/${PHONE_NUMBER_ID}/messages`, {
      method: "POST",
      headers: {
        Authorization: `Bearer ${WHATSAPP_TOKEN}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        messaging_product: "whatsapp",
        to: cleanPhone,
        type: "template",
        template: {
          name: "whatsapp_invitation_template",
          language: { code: "es_MX" },
          components: [
            {
              type: "header",
              parameters: [{ type: "text", parameter_name: "person_name", text: record.person_name.trim() }],
            },
            {
              type: "body",
              parameters: [
                { type: "text", parameter_name: "community_name", text: record.community_name.trim() },
                { type: "text", parameter_name: "google_play_link", text: record.google_play_link.trim() },
              ],
            },
          ],
        },
      }),
    });

    const data = await res.json();
    return new Response(JSON.stringify(data), {
      status: res.status,
      headers: { "Content-Type": "application/json" },
    });
  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500,
      headers: { "Content-Type": "application/json" },
    });
  }
});

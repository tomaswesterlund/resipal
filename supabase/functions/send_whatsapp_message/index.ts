import { serve } from "https://deno.land/std@0.168.0/http/server.ts";

const WHATSAPP_TOKEN = Deno.env.get("WHATSAPP_TOKEN");
const PHONE_NUMBER_ID = Deno.env.get("PHONE_NUMBER_ID");

serve(async (req) => {
  try {
    const { record } = await req.json();

    const res = await fetch(`https://graph.facebook.com/v22.0/${PHONE_NUMBER_ID}/messages`, {
      method: "POST",
      headers: {
        Authorization: `Bearer ${WHATSAPP_TOKEN}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        messaging_product: "whatsapp",
        recipient_type: record.recipient_type,
        to: record.phone_number,
        type: "text",
        text: {
          // This sends a free-form message instead of a pre-approved template
          body: `Hola ${record.name}, ${record.message}`,
        },
      }),
    });

    const data = await res.json();
    return new Response(JSON.stringify(data), {
      status: res.status,
      headers: { "Content-Type": "application/json" },
    });
  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), { status: 500 });
  }
});

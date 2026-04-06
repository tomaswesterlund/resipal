import { serve } from "https://deno.land/std@0.168.0/http/server.ts";

const RESEND_API_KEY = Deno.env.get("RESEND_API_KEY");

serve(async (req) => {
  const { record } = await req.json();

  const { email, name, message } = record;

  const res = await fetch("https://api.resend.com/emails", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${RESEND_API_KEY}`,
    },
    body: JSON.stringify({
      from: "Resipal <hola@resipal.app>",
      to: [email],
      subject: "Invitación a la comunidad",
      html: `
        <div style="font-family: sans-serif; max-width: 600px; margin: auto; color: #333;">
          <h1>Hola ${name}!</h1>
          <p>Has sido invitado a unirte a nuestra comunidad en <strong>Resipal</strong>.</p>
          
          <p><strong>Mensaje del administrador:</strong></p>
          <blockquote style="padding: 15px; background: #f9f9f9; border-left: 4px solid #007bff; font-style: italic;">
            ${message}
          </blockquote>

          <p>Para comenzar, descarga la app <strong>Resipal Residente</strong>:</p>
          
          <table cellpadding="0" cellspacing="0" border="0" style="margin: 20px 0;">
            <tr>
              <td style="vertical-align: middle; padding-right: 12px;">
                <a href="https://apps.apple.com/app/resipal">
                  <img src="https://tools.applemediaservices.com/api/badges/download-on-the-app-store/black/en-us?size=250x83&amp;releaseDate=1276560000&h=7e5b682945a97d549723385e6722d7d3"
                       alt="Download on the App Store"
                       width="120" height="40"
                       style="display: block; width: 120px; height: 40px; border: 0;">
                </a>
              </td>
              <td style="vertical-align: middle;">
                <a href="https://play.google.com/store/apps/details?id=app.resipal.resident">
                  <img src="https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png"
                       alt="Get it on Google Play"
                       width="103" height="40"
                       style="display: block; width: 103px; height: 40px; border: 0;">
                </a>
              </td>
            </tr>
          </table>

          <p>O si prefieres el registro web, haz clic aquí:</p>
          <a href="https://tu-app.com/registro" style="background: #007bff; color: white; padding: 12px 25px; text-decoration: none; border-radius: 8px; display: inline-block; font-weight: bold;">
            Completar Registro
          </a>
        </div>
      `,
    }),
  });

  const data = await res.json();
  return new Response(JSON.stringify(data), { status: 200, headers: { "Content-Type": "application/json" } });
});

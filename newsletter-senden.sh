#!/bin/bash
# TITANWEISS — Newsletter manuell senden (Ausgabe No. 01)
# Ausführen mit: bash newsletter-senden.sh

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  TITANWEISS — Newsletter senden"
echo "  Ausgabe No. 01 · 06. April 2026"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

EMAIL_BODY='<!DOCTYPE html><html><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"></head><body style="margin:0;padding:0;background:#ffffff;font-family:Inter,Helvetica,sans-serif;"><table width="100%" cellpadding="0" cellspacing="0" style="max-width:560px;margin:0 auto;padding:48px 32px;"><tr><td style="padding-bottom:40px;border-bottom:1px solid #f0f0f0;"><span style="font-family:Georgia,serif;font-size:11px;font-weight:700;letter-spacing:0.35em;text-transform:uppercase;color:#111;">TITANWEISS</span></td></tr><tr><td style="padding:40px 0 24px;"><span style="font-size:11px;letter-spacing:0.2em;text-transform:uppercase;color:#aaa;">Ausgabe No. 01 &nbsp;—&nbsp; 06. April 2026</span></td></tr><tr><td style="padding-bottom:32px;"><p style="font-size:22px;font-weight:700;line-height:1.3;color:#111;margin:0;">Die neue Ausgabe ist da.</p></td></tr><tr><td style="padding-bottom:48px;"><p style="font-size:15px;color:#555;line-height:1.7;margin:0;">Zeitgeist, Künstler, Atelier Studie, Ausstellungen — alles frisch recherchiert und aufbereitet.</p></td></tr><tr><td><a href="https://dea-felix.github.io/TITANWEI-/index.html" style="font-size:11px;font-weight:700;letter-spacing:0.18em;text-transform:uppercase;color:#EDB800;text-decoration:none;">Ausgabe lesen →</a></td></tr><tr><td style="padding-top:48px;border-top:1px solid #f0f0f0;"><span style="font-size:11px;color:#ccc;letter-spacing:0.1em;text-transform:uppercase;">Was die Kunst weiß.</span></td></tr></table></body></html>'

RESPONSE=$(curl -s -o /tmp/bd_response.json -w "%{http_code}" \
    -X POST "https://api.buttondown.email/v1/emails" \
    -H "Authorization: Token dc61a8d1-582b-4d4a-a511-0918b4928e7a" \
    -H "Content-Type: application/json" \
    -H "X-Buttondown-Live-Dangerously: true" \
    -d "{
        \"subject\": \"TITANWEISS — Ausgabe No. 01\",
        \"body\": $(echo "$EMAIL_BODY" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read()))'),
        \"status\": \"about_to_send\"
    }")

if [ "$RESPONSE" = "201" ] || [ "$RESPONSE" = "200" ]; then
    echo "  ✓ Newsletter gesendet! Ausgabe No. 01"
    echo ""
    echo "  Du kannst diese Datei jetzt löschen."
else
    echo "  ✗ Fehler (HTTP $RESPONSE):"
    cat /tmp/bd_response.json
fi
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

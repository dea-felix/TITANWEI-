#!/bin/bash
cd /Users/felixweckner/Desktop/kunstmagazin

# ── Beehiiv Credentials ──
BEEHIIV_API_KEY="ko18iibsDBPPPa4ru9uU8Z8ByBPC18x7PYkBkldFWUg4RbjDGnee0aYVMl9bGy6Q"
BEEHIIV_PUB_ID="pub_527792c7-08af-42d6-8df5-453bdfc3c8e7"
SITE_URL="https://titanweissmagazin.netlify.app"

# ── Neueste Ausgabe finden ──
latest=$(find ausgaben -name "TITANWEISS_Ausgabe_*.html" | sort | tail -1)

if [ -n "$latest" ]; then
    # Ausgabe-Nummer extrahieren
    nummer=$(echo "$latest" | grep -oE 'Ausgabe_([0-9]+)' | grep -oE '[0-9]+' | sed 's/^0*//')
    datum=$(date +"%d. %B %Y")

    # Ausgabe als ausgabe-aktuell.html kopieren
    cp "$latest" ausgabe-aktuell.html

    # Nummer in index.html aktualisieren
    sed -i '' "s/No\. [0-9]*/No. $nummer/" index.html

    # ── Git Push ──
    git add .
    git commit -m "Auto: Ausgabe $nummer — $(date +%Y-%m-%d)"
    git push

    echo "✓ Git push abgeschlossen"

    # ── Newsletter via Beehiiv ──
    EMAIL_BODY="<!DOCTYPE html>
<html>
<head>
<meta charset='UTF-8'>
<meta name='viewport' content='width=device-width, initial-scale=1.0'>
</head>
<body style='margin:0;padding:0;background:#ffffff;font-family:Inter,Helvetica,sans-serif;'>
  <table width='100%' cellpadding='0' cellspacing='0' style='max-width:560px;margin:0 auto;padding:48px 32px;'>
    <tr>
      <td style='padding-bottom:40px;border-bottom:1px solid #f0f0f0;'>
        <span style='font-family:Georgia,serif;font-size:11px;font-weight:700;letter-spacing:0.35em;text-transform:uppercase;color:#111;'>TITANWEISS</span>
      </td>
    </tr>
    <tr>
      <td style='padding:40px 0 24px;'>
        <span style='font-size:11px;letter-spacing:0.2em;text-transform:uppercase;color:#aaa;'>Ausgabe No. $nummer &nbsp;—&nbsp; $datum</span>
      </td>
    </tr>
    <tr>
      <td style='padding-bottom:32px;'>
        <p style='font-size:22px;font-weight:700;line-height:1.3;color:#111;margin:0;'>Die neue Ausgabe ist da.</p>
      </td>
    </tr>
    <tr>
      <td style='padding-bottom:48px;'>
        <p style='font-size:15px;color:#555;line-height:1.7;margin:0;'>Zeitgeist, Künstler, Atelier Studie, Ausstellungen — alles frisch recherchiert und aufbereitet.</p>
      </td>
    </tr>
    <tr>
      <td>
        <a href='$SITE_URL/ausgabe-aktuell.html' style='font-size:11px;font-weight:700;letter-spacing:0.18em;text-transform:uppercase;color:#FFD700;text-decoration:none;'>Ausgabe lesen →</a>
      </td>
    </tr>
    <tr>
      <td style='padding-top:48px;border-top:1px solid #f0f0f0;margin-top:48px;'>
        <span style='font-size:11px;color:#ccc;letter-spacing:0.1em;text-transform:uppercase;'>Was die Kunst weiß.</span>
      </td>
    </tr>
  </table>
</body>
</html>"

    RESPONSE=$(curl -s -o /tmp/beehiiv_response.json -w "%{http_code}" \
        -X POST "https://api.beehiiv.com/v2/publications/${BEEHIIV_PUB_ID}/posts" \
        -H "Authorization: Bearer ${BEEHIIV_API_KEY}" \
        -H "Content-Type: application/json" \
        -d "{
            \"title\": \"TITANWEISS — Ausgabe No. $nummer\",
            \"subject\": \"TITANWEISS — Ausgabe No. $nummer\",
            \"preview_text\": \"Die neue Ausgabe ist da — Zeitgeist, Künstler, Atelier Studie, Ausstellungen.\",
            \"body\": $(echo "$EMAIL_BODY" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read()))'),
            \"status\": \"draft\"
        }")

    if [ "$RESPONSE" = "201" ] || [ "$RESPONSE" = "200" ]; then
        echo "✓ Newsletter-Entwurf erstellt — bitte in Beehiiv senden: https://app.beehiiv.com"
    else
        echo "⚠ Newsletter-Fehler (HTTP $RESPONSE)"
        cat /tmp/beehiiv_response.json
    fi
fi

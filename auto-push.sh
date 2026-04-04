#!/bin/bash
# TITANWEISS — Vollautomatischer Publish-Workflow
# Funktioniert sowohl aus der KI-Sandbox als auch manuell vom Mac aus.
# Aufruf: bash auto-push.sh

set -e
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$REPO_DIR"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  TITANWEISS — Auto-Publish"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# ── 1. HEALTH CHECK ──
echo ""
echo "[ 1 ] Health Check..."
if ! bash "$REPO_DIR/check.sh"; then
    echo ""
    echo "✗ Health Check fehlgeschlagen — Publish abgebrochen."
    exit 1
fi

# ── 2. NEUESTE AUSGABE FINDEN ──
echo ""
echo "[ 2 ] Neueste Ausgabe suchen..."
latest=$(find "$REPO_DIR/ausgaben" -name "TITANWEISS_Ausgabe_*.html" | sort | tail -1)

if [ -z "$latest" ]; then
    echo "✗ Keine Ausgabe gefunden in ausgaben/ — Publish abgebrochen."
    exit 1
fi

nummer=$(echo "$latest" | grep -oE 'Ausgabe_([0-9]+)' | grep -oE '[0-9]+' | sed 's/^0*//')
nummer_padded=$(printf "%02d" "$nummer")
datum=$(date +"%d. %B %Y")
datum_iso=$(date +"%Y-%m-%d")
echo "  ✓ Ausgabe No. $nummer gefunden: $latest"

# ── 3. AUSGABE-AKTUELL AKTUALISIEREN ──
echo ""
echo "[ 3 ] ausgabe-aktuell.html aktualisieren..."
cp "$latest" "$REPO_DIR/ausgabe-aktuell.html"
echo "  ✓ ausgabe-aktuell.html ersetzt"

# ── 4. INDEX.HTML NUMMER AKTUALISIEREN ──
echo ""
echo "[ 4 ] index.html Ausgabe-Nummer aktualisieren..."
# Unterschiedliche sed-Syntax: macOS braucht '' nach -i, Linux nicht
if sed --version 2>/dev/null | grep -q GNU; then
    sed -i "s/No\. [0-9]*/No. $nummer/" "$REPO_DIR/index.html"
else
    sed -i '' "s/No\. [0-9]*/No. $nummer/" "$REPO_DIR/index.html"
fi
echo "  ✓ index.html aktualisiert auf No. $nummer"

# ── 5. ARCHIV AKTUALISIEREN ──
echo ""
echo "[ 5 ] Archiv aktualisieren..."

# Snapshot-Ordner anlegen
archiv_dir="$REPO_DIR/archiv/no-$nummer_padded"
mkdir -p "$archiv_dir"

# Snapshot kopieren (mit korrigiertem Zurück-Pfeil)
python3 - <<PYEOF
import re

with open("$latest", "r") as f:
    content = f.read()

# Zurück-Link anpassen falls vorhanden (zeigt auf ../../archiv.html)
if '../../archiv.html' not in content:
    # Zurück-Link in Landing einfügen oder anpassen
    content = re.sub(
        r'(<div class="issue-landing"[^>]*>)',
        r'\1\n  <a href="../../archiv.html" style="position:absolute;top:28px;left:32px;font-family:Montserrat,sans-serif;font-size:0.6rem;font-weight:700;letter-spacing:0.2em;text-transform:uppercase;color:#bbbbbb;text-decoration:none;">← Archiv</a>',
        content
    )

# fonts CSS-Pfad anpassen (von root auf ../../fonts/)
content = content.replace('href="fonts/fonts.css"', 'href="../../fonts/fonts.css"')

with open("$archiv_dir/index.html", "w") as f:
    f.write(content)

print("  ✓ archiv/no-$nummer_padded/index.html erstellt")
PYEOF

# Neuen Eintrag in archiv.html einfügen (falls noch nicht vorhanden)
if ! grep -q "archiv/no-$nummer_padded/index.html" "$REPO_DIR/archiv.html"; then
    python3 - <<PYEOF
with open("$REPO_DIR/archiv.html", "r") as f:
    content = f.read()

new_entry = '      <a class="archiv-item" href="archiv/no-$nummer_padded/index.html">No. $nummer_padded</a>\n'

# Vor dem schließenden </div> der archiv-list einfügen
content = content.replace('    </div>\n  </div>', new_entry + '    </div>\n  </div>', 1)

with open("$REPO_DIR/archiv.html", "w") as f:
    f.write(content)

print("  ✓ archiv.html: Eintrag No. $nummer_padded hinzugefügt")
PYEOF
else
    echo "  ✓ archiv.html: Eintrag No. $nummer_padded bereits vorhanden"
fi

# ── 6. GIT PUSH ──
echo ""
echo "[ 6 ] Git Push..."
cd "$REPO_DIR"
git add .
git commit -m "Auto: Ausgabe No. $nummer — $datum_iso" || echo "  (Nichts zu committen — bereits aktuell)"
git push
echo "  ✓ Gepusht → GitHub Pages deployt in ~1 Minute"

# ── 7. NEWSLETTER ──
echo ""
echo "[ 7 ] Newsletter via Buttondown..."

# Newsletter-Pause prüfen
if [ -f "$REPO_DIR/newsletter-pause" ]; then
    echo "  ⏸ newsletter-pause Datei gefunden — kein Newsletter heute"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "  ✓ PUBLISH ABGESCHLOSSEN (ohne Newsletter)"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    exit 0
fi

BUTTONDOWN_API_KEY="dc61a8d1-582b-4d4a-a511-0918b4928e7a"
SITE_URL="https://dea-felix.github.io/TITANWEI-"

EMAIL_BODY="<!DOCTYPE html>
<html>
<head><meta charset='UTF-8'><meta name='viewport' content='width=device-width, initial-scale=1.0'></head>
<body style='margin:0;padding:0;background:#ffffff;font-family:Inter,Helvetica,sans-serif;'>
  <table width='100%' cellpadding='0' cellspacing='0' style='max-width:560px;margin:0 auto;padding:48px 32px;'>
    <tr>
      <td style='padding-bottom:40px;border-bottom:1px solid #f0f0f0;'>
        <span style='font-family:Georgia,serif;font-size:11px;font-weight:700;letter-spacing:0.35em;text-transform:uppercase;color:#111;'>TITANWEISS</span>
      </td>
    </tr>
    <tr>
      <td style='padding:40px 0 24px;'>
        <span style='font-size:11px;letter-spacing:0.2em;text-transform:uppercase;color:#aaa;'>Ausgabe No. ${nummer} &nbsp;—&nbsp; ${datum}</span>
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
        <a href='${SITE_URL}/ausgabe-aktuell.html' style='font-size:11px;font-weight:700;letter-spacing:0.18em;text-transform:uppercase;color:#FFD700;text-decoration:none;'>Ausgabe lesen →</a>
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

RESPONSE=$(curl -s -o /tmp/buttondown_response.json -w "%{http_code}" \
    -X POST "https://api.buttondown.email/v1/emails" \
    -H "Authorization: Token ${BUTTONDOWN_API_KEY}" \
    -H "Content-Type: application/json" \
    -H "X-Buttondown-Live-Dangerously: true" \
    -d "{
        \"subject\": \"TITANWEISS — Ausgabe No. ${nummer}\",
        \"body\": $(echo "$EMAIL_BODY" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read()))'),
        \"status\": \"about_to_send\"
    }")

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if [ "$RESPONSE" = "201" ] || [ "$RESPONSE" = "200" ]; then
    echo "  ✓ PUBLISH ABGESCHLOSSEN"
    echo "  ✓ Newsletter wird gesendet (Ausgabe No. ${nummer})"
else
    echo "  ✓ Publish OK — aber Newsletter-Fehler (HTTP $RESPONSE)"
    cat /tmp/buttondown_response.json 2>/dev/null
fi
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

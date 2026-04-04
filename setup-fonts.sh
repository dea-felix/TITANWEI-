#!/bin/bash
# Lädt Montserrat + Inter als lokale woff2-Dateien herunter
# Schritt 1: CSS von Google Fonts holen (enthält aktuelle woff2-URLs)
# Schritt 2: woff2-URLs aus CSS extrahieren und Dateien laden
cd "$(dirname "$0")/fonts"

UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"

echo "Hole aktuelle Font-URLs von Google Fonts..."
CSS=$(curl -sL -A "$UA" "https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;700;900&family=Inter:wght@300;400;500&display=swap")

if echo "$CSS" | grep -q "woff2"; then
  echo "CSS erhalten, extrahiere URLs..."
else
  echo "FEHLER: Konnte keine CSS-Daten von Google Fonts laden."
  echo "Inhalt: $CSS"
  exit 1
fi

# Montserrat Gewichte zuordnen und herunterladen
echo "Lade Montserrat herunter..."
for weight in 400 500 700 900; do
  # Suche den @font-face Block für Montserrat mit dem jeweiligen Gewicht (latin Block)
  URL=$(echo "$CSS" | tr '{' '\n' | grep -A5 "font-weight: $weight" | grep -A5 "Montserrat" | grep -oE "https://[^)]+\.woff2" | tail -1)
  if [ -z "$URL" ]; then
    # Fallback: einfach nach Reihenfolge
    URL=$(echo "$CSS" | grep -oE "https://fonts\.gstatic\.com/s/montserrat/[^)]+\.woff2" | sed -n "$((($weight/100)-3))p")
  fi
  if [ -n "$URL" ]; then
    curl -sL -A "$UA" "$URL" -o "montserrat-${weight}.woff2"
    SIZE=$(wc -c < "montserrat-${weight}.woff2" | tr -d ' ')
    echo "  montserrat-${weight}.woff2 → ${SIZE} bytes"
  else
    echo "  WARNUNG: URL für Montserrat ${weight} nicht gefunden"
  fi
done

echo "Lade Inter herunter..."
for weight in 300 400 500; do
  URL=$(echo "$CSS" | tr '{' '\n' | grep -A5 "font-weight: $weight" | grep -A5 "Inter" | grep -oE "https://[^)]+\.woff2" | tail -1)
  if [ -z "$URL" ]; then
    URL=$(echo "$CSS" | grep -oE "https://fonts\.gstatic\.com/s/inter/[^)]+\.woff2" | sed -n "$((($weight/100)-2))p")
  fi
  if [ -n "$URL" ]; then
    curl -sL -A "$UA" "$URL" -o "inter-${weight}.woff2"
    SIZE=$(wc -c < "inter-${weight}.woff2" | tr -d ' ')
    echo "  inter-${weight}.woff2 → ${SIZE} bytes"
  else
    echo "  WARNUNG: URL für Inter ${weight} nicht gefunden"
  fi
done

echo ""
echo "Fertig! Dateien in fonts/:"
ls -la *.woff2

echo ""
echo "Jetzt pushen:"
echo "cd ~/Desktop/kunstmagazin && git add fonts/ && git commit -m 'Fonts: woff2 lokal hinzugefügt' && git push"

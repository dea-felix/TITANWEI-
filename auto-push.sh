#!/bin/bash
cd /Users/felixweckner/Desktop/kunstmagazin

# Neueste Ausgabe finden
latest=$(find ausgaben -name "TITANWEISS_Ausgabe_*.html" | sort | tail -1)

if [ -n "$latest" ]; then
    # Ausgabe-Nummer extrahieren (z.B. "02" aus TITANWEISS_Ausgabe_02_...)
    nummer=$(echo "$latest" | grep -oE 'Ausgabe_([0-9]+)' | grep -oE '[0-9]+' | sed 's/^0*//')

    # Ausgabe als ausgabe-aktuell.html kopieren
    cp "$latest" ausgabe-aktuell.html

    # Nummer in index.html aktualisieren
    sed -i '' "s/No\. [0-9]*/No. $nummer/" index.html

    git add .
    git commit -m "Auto: Ausgabe $nummer — $(date +%Y-%m-%d)"
    git push
fi

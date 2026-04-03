#!/bin/bash
# TITANWEISS — Health Check Script
# Läuft vor jedem Publish. Wenn Fehler: kein Push, kein Newsletter.
# Aufruf: bash check.sh

set -e
cd /Users/felixweckner/Desktop/kunstmagazin

ERRORS=0
WARNINGS=0

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  TITANWEISS — Health Check"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# ── Neueste Ausgabe finden ──
latest=$(find ausgaben -name "TITANWEISS_Ausgabe_*.html" | sort | tail -1)
if [ -z "$latest" ]; then
    echo "✗ FEHLER: Keine Ausgabe gefunden in ausgaben/"
    exit 1
fi
echo "→ Prüfe: $latest"
echo ""

# ── 1. DATEI-BASICS ──
echo "[ 1/7 ] Datei-Größe"
size=$(wc -c < "$latest")
if [ "$size" -lt 50000 ]; then
    echo "  ✗ FEHLER: Datei zu klein ($size Bytes) — HTML wahrscheinlich unvollständig"
    ERRORS=$((ERRORS + 1))
else
    echo "  ✓ Größe OK ($size Bytes)"
fi

# ── 2. PFLICHTSTRUKTUR ──
echo "[ 2/7 ] HTML-Struktur"
for check in "TITANWEISS" "Zeitgeist" "Künstler" "Atelier" "Ausstellung" "FFD700" "<footer" "<header"; do
    if ! grep -q "$check" "$latest"; then
        echo "  ✗ FEHLER: '$check' fehlt im HTML"
        ERRORS=$((ERRORS + 1))
    fi
done

# Keine Kunsthalle Oldenburg
if grep -qi "Kunsthalle Oldenburg" "$latest"; then
    echo "  ✗ FEHLER: 'Kunsthalle Oldenburg' gefunden — die existiert nicht!"
    ERRORS=$((ERRORS + 1))
else
    echo "  ✓ Struktur OK"
fi

# ── 3. WORTANZAHL ──
echo "[ 3/7 ] Wortanzahl"
words=$(cat "$latest" | sed 's/<[^>]*>//g' | wc -w)
if [ "$words" -lt 1500 ]; then
    echo "  ✗ FEHLER: Zu wenige Wörter ($words) — Ausgabe wahrscheinlich unvollständig"
    ERRORS=$((ERRORS + 1))
elif [ "$words" -gt 12000 ]; then
    echo "  ⚠ WARNUNG: Sehr viele Wörter ($words) — Ausgabe sehr lang"
    WARNINGS=$((WARNINGS + 1))
else
    echo "  ✓ Wortanzahl OK ($words Wörter)"
fi

# ── 4. STOCKFOTOS CHECK ──
echo "[ 4/7 ] Stockfoto-Check"
for banned in "unsplash" "pexels" "pixabay" "shutterstock" "gettyimages" "istockphoto"; do
    if grep -qi "$banned" "$latest"; then
        echo "  ✗ FEHLER: Stockfoto-URL gefunden ($banned)"
        ERRORS=$((ERRORS + 1))
    fi
done
echo "  ✓ Keine Stockfotos gefunden"

# ── 5. URL-CHECK (Top 10 externe Links) ──
echo "[ 5/7 ] URL-Validierung (externe Links)"
urls=$(grep -oE 'href="https?://[^"]+"|src="https?://[^"]+"' "$latest" | grep -oE 'https?://[^"]+' | sort -u | head -10)
url_errors=0
for url in $urls; do
    status=$(curl -s -o /dev/null -w "%{http_code}" --max-time 8 --location "$url" 2>/dev/null || echo "000")
    if [ "$status" = "000" ] || [ "$status" = "404" ] || [ "$status" = "403" ]; then
        echo "  ⚠ WARNUNG: $url → HTTP $status"
        WARNINGS=$((WARNINGS + 1))
        url_errors=$((url_errors + 1))
    fi
done
if [ "$url_errors" -eq 0 ]; then
    echo "  ✓ Alle geprüften URLs erreichbar"
fi

# ── 6. KÜNSTLER-DOPPELUNGEN ──
echo "[ 6/7 ] Künstler-Archiv (Doppelungen)"
if [ -f "ausgaben/kuenstler_archiv.json" ]; then
    # Extrahiere alle Künstlernamen aus dem HTML (heuristisch: h2/h3 Tags)
    html_artists=$(grep -oE '<h[23][^>]*>[^<]{5,50}</h[23]>' "$latest" | sed 's/<[^>]*>//g' | sort)
    archive_artists=$(cat ausgaben/kuenstler_archiv.json | python3 -c "import json,sys; data=json.load(sys.stdin); print('\n'.join(data) if isinstance(data, list) else '\n'.join(str(v) for v in data.values()))" 2>/dev/null || echo "")
    duplicates=0
    while IFS= read -r artist; do
        if [ -n "$artist" ] && echo "$archive_artists" | grep -qi "$artist"; then
            echo "  ⚠ WARNUNG: '$artist' bereits in früherer Ausgabe"
            WARNINGS=$((WARNINGS + 1))
            duplicates=$((duplicates + 1))
        fi
    done <<< "$html_artists"
    if [ "$duplicates" -eq 0 ]; then
        echo "  ✓ Keine Doppelungen im Archiv"
    fi
else
    echo "  ⚠ WARNUNG: kuenstler_archiv.json nicht gefunden"
    WARNINGS=$((WARNINGS + 1))
fi

# ── 7. BUTTONDOWN API KEY ──
echo "[ 7/7 ] Buttondown API Key"
BUTTONDOWN_API_KEY="dc61a8d1-582b-4d4a-a511-0918b4928e7a"
bd_status=$(curl -s -o /dev/null -w "%{http_code}" \
    -H "Authorization: Token ${BUTTONDOWN_API_KEY}" \
    "https://api.buttondown.email/v1/subscribers?count=1" 2>/dev/null)
if [ "$bd_status" = "200" ]; then
    echo "  ✓ Buttondown API Key gültig"
else
    echo "  ✗ FEHLER: Buttondown API Key ungültig oder nicht erreichbar (HTTP $bd_status)"
    ERRORS=$((ERRORS + 1))
fi

# ── ERGEBNIS ──
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if [ "$ERRORS" -gt 0 ]; then
    echo "  ✗ CHECK FEHLGESCHLAGEN — $ERRORS Fehler, $WARNINGS Warnungen"
    echo "  → Ausgabe wird NICHT veröffentlicht"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    exit 1
elif [ "$WARNINGS" -gt 0 ]; then
    echo "  ⚠ CHECK BESTANDEN mit $WARNINGS Warnungen"
    echo "  → Ausgabe kann veröffentlicht werden"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    exit 0
else
    echo "  ✓ ALLE CHECKS BESTANDEN — bereit zum Publish"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    exit 0
fi

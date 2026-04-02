#!/bin/bash
cd /Users/felixweckner/Desktop/kunstmagazin
latest=$(find ausgaben -name "TITANWEISS_Ausgabe_*.html" | sort | tail -1)
if [ -n "$latest" ]; then
    cp "$latest" index.html
    git add .
    git commit -m "Auto: $(date +%Y-%m-%d)"
    git push
fi

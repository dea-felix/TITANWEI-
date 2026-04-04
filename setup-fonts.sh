#!/bin/bash
# Lädt Montserrat + Inter als lokale woff2-Dateien herunter
cd "$(dirname "$0")/fonts"

echo "Lade Montserrat herunter..."
curl -sL "https://fonts.gstatic.com/s/montserrat/v29/JTUHjIg1_i6t8kCHKm4532VJOt5-QNFgpCtr6Ew-.woff2" -o montserrat-400.woff2
curl -sL "https://fonts.gstatic.com/s/montserrat/v29/JTUHjIg1_i6t8kCHKm4532VJOt5-QNFgpCtZ6Ew-.woff2" -o montserrat-500.woff2
curl -sL "https://fonts.gstatic.com/s/montserrat/v29/JTUHjIg1_i6t8kCHKm4532VJOt5-QNFgpCu170w-.woff2" -o montserrat-700.woff2
curl -sL "https://fonts.gstatic.com/s/montserrat/v29/JTUHjIg1_i6t8kCHKm4532VJOt5-QNFgpCvr70w-.woff2" -o montserrat-900.woff2

echo "Lade Inter herunter..."
curl -sL "https://fonts.gstatic.com/s/inter/v18/UcCO3FwrK3iLTeHuS_nVMrMxCp50SjIw2boKoduKmMEVuOKfAZ9hjQ.woff2" -o inter-300.woff2
curl -sL "https://fonts.gstatic.com/s/inter/v18/UcCO3FwrK3iLTeHuS_nVMrMxCp50SjIw2boKoduKmMEVuI6fAZ9hjQ.woff2" -o inter-400.woff2
curl -sL "https://fonts.gstatic.com/s/inter/v18/UcCO3FwrK3iLTeHuS_nVMrMxCp50SjIw2boKoduKmMEVuBWfAZ9hjQ.woff2" -o inter-500.woff2

echo ""
echo "Fertig! Dateien in fonts/:"
ls -la *.woff2

echo ""
echo "Jetzt pushen:"
echo "cd ~/Desktop/kunstmagazin && git add fonts/ && git commit -m 'Fonts: woff2 lokal hinzugefügt' && git push"

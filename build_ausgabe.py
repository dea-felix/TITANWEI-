#!/usr/bin/env python3
"""
TITANWEISS Build-Script
=======================
Baut aus template.html + Content-Dateien die fertige Ausgabe.

Verwendung:
    python3 build_ausgabe.py <content-ordner>

Erwartet im Content-Ordner:
    metadata.json       — Ausgabe-Metadaten
    zeitgeist.html      — Nur der Inhalt (ohne section-label, ohne section-inner/footer)
    kuenstler.html      — Nur der Inhalt
    atelier.html        — Nur der Inhalt
    ausstellungen.html  — Nur der Inhalt

metadata.json Format:
    {
        "ausgabe_nr": "02",
        "monat": "April",
        "jahr": "2026",
        "datum": "2026-04-10"
    }

Ausgabe wird gespeichert in:
    ausgaben/{Monat} {Jahr}/No. {NR} - {MM}.{YYYY}/TITANWEISS_Ausgabe_{NR}_{DATUM}.html
"""

import json
import os
import sys
import glob


def find_repo_root():
    """Findet das kunstmagazin-Repo — funktioniert in Cowork und lokal."""
    # Cowork-Session
    paths = glob.glob("/sessions/*/mnt/kunstmagazin/")
    if paths:
        return paths[0]
    # Lokal: Script liegt im Repo
    script_dir = os.path.dirname(os.path.abspath(__file__))
    if os.path.exists(os.path.join(script_dir, "template.html")):
        return script_dir + "/"
    print("FEHLER: kunstmagazin-Ordner nicht gefunden.")
    sys.exit(1)


def build(content_dir):
    repo = find_repo_root()
    template_path = os.path.join(repo, "template.html")

    # Template lesen
    with open(template_path, "r", encoding="utf-8") as f:
        template = f.read()

    # Metadata lesen
    meta_path = os.path.join(content_dir, "metadata.json")
    with open(meta_path, "r", encoding="utf-8") as f:
        meta = json.load(f)

    ausgabe_nr = meta["ausgabe_nr"]
    monat = meta["monat"]
    jahr = meta["jahr"]
    datum = meta["datum"]
    monat_jahr = f"{monat} {jahr}"
    nr_jahr = f"{ausgabe_nr} / {jahr}"

    # Content-Dateien lesen
    sections = {}
    for section in ["zeitgeist", "kuenstler", "atelier", "ausstellungen"]:
        section_path = os.path.join(content_dir, f"{section}.html")
        with open(section_path, "r", encoding="utf-8") as f:
            sections[section] = f.read()

    # Platzhalter ersetzen
    html = template
    html = html.replace("{{AUSGABE_NR}}", ausgabe_nr)
    html = html.replace("{{MONAT_JAHR}}", monat_jahr)
    html = html.replace("{{NR_JAHR}}", nr_jahr)
    html = html.replace("{{ZEITGEIST_CONTENT}}", sections["zeitgeist"])
    html = html.replace("{{KUENSTLER_CONTENT}}", sections["kuenstler"])
    html = html.replace("{{ATELIER_CONTENT}}", sections["atelier"])
    html = html.replace("{{AUSSTELLUNGEN_CONTENT}}", sections["ausstellungen"])

    # Ausgabe-Ordner erstellen
    mm = datum.split("-")[1]  # "04" aus "2026-04-10"
    ausgabe_ordner = os.path.join(
        repo, "ausgaben", f"{monat} {jahr}", f"No. {ausgabe_nr} - {mm}.{jahr}"
    )
    os.makedirs(ausgabe_ordner, exist_ok=True)

    # HTML speichern
    dateiname = f"TITANWEISS_Ausgabe_{ausgabe_nr}_{datum}.html"
    ausgabe_pfad = os.path.join(ausgabe_ordner, dateiname)
    with open(ausgabe_pfad, "w", encoding="utf-8") as f:
        f.write(html)

    print(f"✓ Ausgabe gebaut: {ausgabe_pfad}")
    return ausgabe_pfad


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Verwendung: python3 build_ausgabe.py <content-ordner>")
        print("Beispiel:   python3 build_ausgabe.py /tmp/ausgabe_content/")
        sys.exit(1)

    content_dir = sys.argv[1]
    if not os.path.isdir(content_dir):
        print(f"FEHLER: Ordner nicht gefunden: {content_dir}")
        sys.exit(1)

    build(content_dir)

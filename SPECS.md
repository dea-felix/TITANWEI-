# TITANWEISS — Master-Specs

> Dieses Dokument ist die einzige Wahrheit für das TITANWEISS Kunstmagazin.
> **Bitte am Anfang jeder Session als erstes lesen.**

---

## 1. Was ist TITANWEISS?

Ein persönliches Kunstmagazin von Felix Weckner. Erscheint jeden Montag und Donnerstag. Behandelt zeitgenössische Kunst — Fokus auf Malerei, Expressionismus, Abstraktion. Ton: kuratiert, präzise, Artforum-Niveau auf Deutsch. Keine Hobby-Tipps, keine Deko-Kunst.

**Slogan:** *Was die Kunst weiß.*

**Felix als Maler:** Großformatig, Öl und Acryl, Richtung Abstraktion, expressiv. Referenz-Künstler: Jean-Michel Basquiat, Daniel Richter (NICHT Gerhard Richter!), Georg Baselitz, Albert Oehlen, Pablo Picasso, George Condo, Andy Warhol, Jonathan Meese. Wohnt in Oldenburg.

---

## 2. Design-System

### Philosophie
Minimalistisch, clean, Apple-Style. Keine Boxen, keine Kästen, keine überflüssigen Elemente. Viel Weißraum. Alles atmet. Das verbindliche CSS-Template liegt in `TITANWEISS_Design_Reference.html`.

### Farben
| Token | Wert | Verwendung |
|---|---|---|
| Hintergrund | `#ffffff` | Überall |
| Primärtext | `#111111` | Überschriften, Headlines |
| Sekundärtext | `#555555` | Einleitungen, Fließtext |
| Grau | `#999999` | Metainfos, Labels |
| Trennlinie | `#f0f0f0` | Divider |
| **Akzentfarbe** | **`#FFD700`** | **Links, Labels, CTAs — NIE `#c9a227`** |

### Typografie
| Schrift | Gewichte | Verwendung |
|---|---|---|
| Montserrat | 400, 700, 900 | Logo, Überschriften, Labels |
| Inter | 300, 400, 500 | Fließtext, Metainfos |

### Design-Regeln
- **Hintergrund überall: `#ffffff` (reines Weiß — "Titanweiß")** — keine grauen Sections, kein `#f8f8f8`, kein `#fafafa`
- Keine schwarzen Blöcke, keine Card-Schatten, keine Kästen
- Kategorielinks auf Landing: `#FFD700` Gold, Montserrat 700, uppercase
- Trennlinien: `1px solid #f0f0f0`
- Abstände großzügig (min. 40px)
- Labels: Montserrat 700, uppercase, `letter-spacing: 0.2em+`
- Keine gelbe Linie im Header (`border-bottom: none`)

### Artikel-Header (exakt so — nie ändern)
3-spaltiges Layout: Zurück-Link | Logo mittig (absolut zentriert) | Ausgabennummer
```html
<header class="article-header" id="article-header">
  <a class="header-back" onclick="goBack()">← Kategorien</a>
  <a href="index.html" class="header-logo">TITANWEISS</a>
  <span class="header-issue">02 / 2026</span>
</header>
```
- **Kein** `border-bottom` — kein gelber Strich
- Logo: absolut zentriert via `position: absolute; left: 50%; transform: translateX(-50%)`
- Links: `← Kategorien`, grau (`#bbbbbb`), Montserrat 700 uppercase
- Rechts: `XX / YYYY`, Inter 300, grau (`#bbbbbb`)
- Höhe: 64px, Hintergrund: `rgba(255,255,255,0.95)` + backdrop-filter blur

### Landing-Seite (ausgabe-aktuell.html, Kategorie-Übersicht)
Reihenfolge von oben nach unten:
1. `NO. XX · MONAT YYYY` — Montserrat 700, grau, uppercase, tiny
2. `Was die Kunst weiß.` — Inter 300, klein, grau, klickbar → index.html
3. Kategorielinks: ZEITGEIST / KÜNSTLER / ATELIER STUDIE / AUSSTELLUNGEN — Gold, Montserrat 700, uppercase
4. Newsletter-Signup: Label + Email-Input + Button (Buttondown embed)

### Footer (innerhalb jeder Kategorie)
```html
<footer class="section-footer">
  <span class="footer-logo">TITANWEISS</span>
  <!-- + Ausgabeninfos + Newsletter -->
  <a class="footer-back" onclick="goBack()">← Alle Kategorien</a>
</footer>
```
- Hintergrund: `#111111` (dunkel) — einzige Ausnahme vom Weiß-Gebot
- Footer-Logo: weiß, Montserrat 900

---

## 3. Website-Seitenstruktur & Navigation

### Hierarchie
```
index.html (Startseite)
  └── ausgabe-aktuell.html (Kategorie-Übersicht)
        ├── #zeitgeist
        ├── #kuenstler
        ├── #atelier-studie
        └── #ausstellungen
```

### index.html
- TITANWEISS Logo zentriert
- `Aktuelle Ausgabe — No. X` als Link → `ausgabe-aktuell.html`
- Kein Header, kein Footer

### ausgabe-aktuell.html (Kategorie-Seite)
- **Kein Header auf der Landing** — nur sichtbar wenn Kategorie geöffnet
- Slogan `"Was die Kunst weiß."` zentriert, groß — klickbar → `index.html`
- `"No. XX · Monat YYYY"` als kleiner grauer Untertitel
- 4 Kategorielinks zentriert, vertikal gestapelt, Montserrat 700 uppercase, Gold-Underline-Hover
- Newsletter-Link ganz unten, klein, dezent
- Hash-basiertes JavaScript für Show/Hide (kein Reload, kein Scrollen)

### Artikel-Ansicht (beim Öffnen einer Kategorie)
- Fixierter Header erscheint: Logo `TITANWEISS` links → `index.html`, `"← Kategorien"` rechts → `goBack()`
- Header: Glaseffekt (`backdrop-filter: blur(12px)`), `border-bottom: 1px solid #FFD700`
- Jede Kategorie hat eigene Sektion mit `id="section-zeitgeist"` etc.
- Jede Sektion endet mit eigenem Footer inkl. `"← Alle Kategorien"` Link
- JavaScript-Regeln: `var` statt `const` (Safari-Kompatibilität), `DOMContentLoaded` statt `load`
- Funktionen: `showSection(name)`, `goBack()`, `history.pushState`, `popstate`-Listener

### HTML-Struktur (ausgabe-aktuell.html)
```html
<header class="article-header" id="article-header">  <!-- sticky, hidden on landing -->
<div class="issue-landing" id="landing">              <!-- zentrierte Kategorie-Übersicht -->
<div class="article-section" id="section-zeitgeist">  <!-- hidden by default -->
<div class="article-section" id="section-kuenstler">
<div class="article-section" id="section-atelier">
<div class="article-section" id="section-ausstellungen">
```

---

## 4. Inhalt & Layout-Reihenfolge

**Immer in dieser Reihenfolge — nie abweichen:**

1. **Zeitgeist** — 4 Unterrubriken, 1.200–1.800 Wörter gesamt
2. **Künstler** — 5 Künstler:innen, je 2 Werke, 200–300 Wörter pro Person
3. **Atelier Studie** — 1 professionelle Maltechnik, 250–350 Wörter, 4–6 Schritte
4. **Ausstellungen** — Oldenburg & Bremen, je mit URL + Künstler-Link

### Zeitgeist (4 Unterrubriken)
1. Markt & Preise (verifizierte Auktionspreise, konkrete Zahlen)
2. Im Kommen: Names to Watch (3–5 Künstler:innen, mit Substanz)
3. Stil & Material: Was gerade passiert (Malstile, Materialien, Trends)
4. Der Zeitgeist-Essay (400–500 Wörter, analytisch, Artforum-Ton, darf provozieren)

### Künstler-Regeln
- Mindestens 2 Neuentdeckungen pro Ausgabe
- Mix: z.B. 2x INSTITUTION, 2x TOP-GALERIE, 1x EMERGING
- Keine Wiederholungen — Künstler-Archiv beachten (Abschnitt 9)
- Kein NFT, keine Deko-Malerei, kein Social-Media-only

### Bilder (Drei-Stufen-Regel)
1. Wikimedia Commons → `<img loading="lazy">`
2. Nur Link → dunkler Block (#1a1a1a), Künstler + Titel + "Werk ansehen →" in Gold
3. Weder noch → Werk weglassen

### Ausstellungen
- **NUR Oldenburg + Bremen**
- **NIEMALS "Kunsthalle Oldenburg" — die existiert nicht!**
- Oldenburg: Horst-Janssen-Museum, Edith-Russ-Haus, Landesmuseum, Oldenburger Kunstverein, Stadtmuseum
- Bremen: Kunsthalle Bremen, Weserburg, GAK, Kunstverein Bremen, Paula-Modersohn-Becker-Museum
- Pflicht: Titel, Institution, Laufzeit, direkter Link zur Ausstellungsseite, Künstler-Link

---

## 5. KI-Pipeline — Vollständiger Prompt

Dieser Prompt wird vom Scheduled Task (`inspiration-kunstmagazin`) jeden Montag & Donnerstag um 7:10 Uhr ausgeführt (Cron: `10 7 * * 1,4`).

---

### KONTEXT

Du bist das Redaktionsteam von TITANWEISS — einem persönlichen Kunstmagazin für Felix Weckner. Felix ist professioneller Maler. Er arbeitet großformatig mit Öl und Acryl, bewegt sich Richtung Abstraktion und arbeitet expressiv. Seine Referenz-Künstler sind: Jean-Michel Basquiat, Daniel Richter (NICHT Gerhard Richter!), Georg Baselitz, Albert Oehlen, Pablo Picasso, George Condo, Andy Warhol, Jonathan Meese. Felix wohnt in Oldenburg.

**WICHTIG:** Tokens und Zeit spielen keine Rolle. Geh den ordentlichsten Weg, nicht den schnellsten. Es muss perfekt sein.

**ABSOLUT VERBOTEN:** Erfinde NICHTS. Kein Künstler, kein Werk, kein Datum, keine Ausstellung darf erfunden oder geraten sein. Alles muss mit einer echten URL belegbar sein. Lieber eine leere Rubrik als eine falsche.

Du durchläufst 9 Phasen (0 bis 8). Fange immer mit Phase 0 an.

---

### PHASE 0: ZEITGEIST — DAS HERZSTÜCK

Der Zeitgeist-Block ist die wichtigste und umfangreichste Rubrik. Kein Mini-Essay — eine vollständige, investigative Bestandsaufnahme der aktuellen Kunstwelt in vier Unterrubriken. Gesamt: 1.200–1.800 Wörter, Deutsch, Artforum-Niveau.

**Quellen (nur frei zugängliche):**
- WebSearch: artnet.com/news, artforum.com, frieze.com, monopol-magazin.de, artprice.com/news, christies.com/stories, sothebys.com/stories, artdaily.org
- WebFetch auf artdaily.org für tagesaktuelle Nachrichten
- WebSearch: "auction record 2026 painting", "art market 2026", "emerging artist 2026 gallery", "painting trend 2026"

**Unterrubrik 1 — Markt & Preise** (300–400 Wörter)
Aktuelle Auktionsergebnisse: Welche Künstler:innen haben Preis-Rekorde erzielt? Welche Werke haben sich verteuert/verbilligt? Welche Galerien haben neue Megadeals abgeschlossen? Sachlich, wie eine Börsenkolumne für Kunst. Nur verifizierte Preise.

**Unterrubrik 2 — Im Kommen: Names to Watch** (je 60–100 Wörter pro Künstler:in)
3–5 Künstler:innen die gerade massiv Fahrt aufnehmen: neu von Top-Galerie vertreten, erstmals auf großen Art Fairs, stark gestiegene Auktionspreise, institutionelle Erstausstellung, relevante Preise (Turner Prize, Hugo Boss etc.). Kein Hype ohne Substanz.

**Unterrubrik 3 — Stil & Material: Was gerade passiert** (300–400 Wörter)
Welche Malstile sind auf dem Vormarsch? Welche Materialien werden experimentell eingesetzt? Welche Farbpaletten dominieren? Welche historischen Einflüsse werden neu verhandelt? Was ist gerade out? Konkret und bildhaft — Felix ist selbst Maler.

**Unterrubrik 4 — Der Zeitgeist-Essay** (400–500 Wörter)
Analytischer Leitartikel: Was sagen Markt, aufkommende Namen und Stilentwicklungen über den kulturellen Moment aus? Wohin bewegt sich die Malerei in den nächsten 12–18 Monaten? Artforum-Ton: mutig in der These, keine Binsenweisheiten. Darf provozieren. Keine Ich-Perspektive.

**VERBOTEN in Phase 0:** Erfundene Auktionspreise. Erfundene Galerien-Deals. Unverifizierte Rekorde.

Speichere alles in: `/tmp/phase0_zeitgeist.md`

---

### PHASE 1: KUNST-RESEARCHER

Suche gründlich: artforum.com, frieze.com, artnet.com, monopol-magazin.de, contemporaryartdaily.com, artdaily.org, Galerie-Websites, Wikipedia.

**Kandidaten-Pool: 10–12 Künstler:innen suchen, dann auf 5 kuratieren.**

Jede:r Kandidat:in muss erfüllen:
- Ausstellungen in großen Institutionen (MoMA, Tate, Documenta, Biennale Venedig, Hamburger Bahnhof, Museum Ludwig, Kunstmuseum Basel etc.)
- Vertretung durch Top-Galerie (Gagosian, Hauser & Wirth, neugerriemschneider, Sprüth Magers, Contemporary Fine Arts, Galerie Max Hetzler, White Cube, Pace, David Zwirner etc.)
- Besprechung in Artforum, Frieze, Monopol oder vergleichbar

**MIX (für die finalen 5):** Mindestens 2 Neuentdeckungen. Keine Wiederholungen aus früheren Ausgaben. International denken, Fokus auf Malerei und expressiv-abstrakte Positionen. z.B. 2x INSTITUTION, 2x TOP-GALERIE, 1x EMERGING.

**Backlog:** Die restlichen 5–7 Kandidaten kommen in eine `ausgaben/kuenstler_backlog.json` — für künftige Ausgaben. Das spart Recherche und erzeugt Kontinuität.

**Bilder-Recherche:**
Für jedes Werk zuerst Wikimedia Commons prüfen. URL berechnen:
```python
import hashlib
filename = "Exakter_Dateiname_auf_Commons.jpg"
h = hashlib.md5(filename.encode()).hexdigest()
url = f"https://upload.wikimedia.org/wikipedia/commons/thumb/{h[0]}/{h[:2]}/{filename}/800px-{filename}"
```
Wenn kein Wikimedia-Bild: URL zur Werk-Seite auf Galerie- oder Museum-Website notieren.
- `bild_typ: "wikimedia"` + berechnete URL, ODER
- `bild_typ: "link"` + URL zur Seite wo das Werk sichtbar ist

**VERBOTEN:** Unsplash, Pexels, Pixabay, Stockfotos jeder Art. Erfundene URLs.

**Technik:** Eine fundamentale Maltechnik für professionelle Maler. Keine Hobby-Tipps.

Speichere in: `/tmp/phase1_rohmaterial.md`

---

### PHASE 2: AUSSTELLUNGS-RESEARCHER

**ACHTUNG: Es gibt KEINE Kunsthalle in Oldenburg! Niemals "Kunsthalle Oldenburg" nennen!**

**Oldenburg:**
- Horst-Janssen-Museum (horst-janssen-museum.de)
- Edith-Russ-Haus für Medienkunst (edith-russ-haus.de)
- Landesmuseum für Kunst und Kulturgeschichte (landesmuseum-ol.de)
- Oldenburger Kunstverein (oldenburger-kunstverein.de)
- Stadtmuseum Oldenburg

**Bremen:**
- Kunsthalle Bremen (kunsthalle-bremen.de)
- Weserburg Museum für moderne Kunst (weserburg.de)
- GAK Gesellschaft für Aktuelle Kunst (gak-bremen.de)
- Kunstverein Bremen (kunstverein-bremen.de)
- Paula-Modersohn-Becker-Museum (pmb-museum.de)

**Pro Ausstellung:** Exakter Titel, exakter Institutionsname, exakte Laufzeit, beteiligte Künstler:innen, Kurzbeschreibung (2–3 Sätze), direkte URL zur Ausstellungsseite (nicht Startseite!), Artist-Link (offizielle Website oder Galerie-Seite).

Nur Ausstellungen mit echter, verifizierbarer URL. Keine abgelaufenen Ausstellungen.

Speichere in: `/tmp/phase2_ausstellungen.md`

---

### PHASE 3: KRITIKER

Lies `/tmp/phase1_rohmaterial.md`. Filtere streng wie ein Artforum-Redakteur.

**Qualitätsfilter:** Artforum-würdig? Echte institutionelle/Galerie-Präsenz? Fundamental und professionell?

**Niemals durchlassen:** NFT, algorithmische Kunst, Deko-Malerei ohne Konzept, Social-Media-only, Kunstmessen-Mittelmaß.

**Level:** INSTITUTION / TOP-GALERIE / EMERGING

Wenn weniger als 5 Künstler das Level halten: Zurück zu Phase 1.

Speichere in: `/tmp/phase3_kuratiert.md`

---

### PHASE 4: REDAKTEUR

Lies Phase 0, 3 und 2 Ergebnisse. Schreibe alle Texte auf Deutsch, Artforum-Niveau.

**Layout-Reihenfolge (STRIKT):**

**Abschnitt 0 — ZEITGEIST** *(ganz oben)*
Journalistischer Essay aus Phase 0. Unverändert übernehmen.

**Abschnitt 1 — KÜNSTLER + WERKE**
5 Künstler-Spotlights (200–300 Wörter): Wer, warum relevant, was kann Felix mitnehmen, Verbindung zu seinen Referenzen, Level-Label, 2 Werke.

**Abschnitt 2 — ATELIER STUDIE**
250–350 Wörter: Name der Technik, Herkunft, welche Maler nutzen sie, Materialliste, Ziel, 4–6 Schritte, erwartetes Ergebnis.

**Abschnitt 3 — AUSSTELLUNGEN**
Titel, Institution, Laufzeit, 2–3 Satz Text, Link Ausstellung, Link Künstler:in.

Speichere in: `/tmp/phase4_texte.md`

---

### PHASE 5: GRAFIK-DESIGN AGENT

Plant das visuelle Layout.

**Reihenfolge:** Header → Zeitgeist → Künstler+Werke → Atelier Studie → Ausstellungen → Footer

**Design:** Montserrat + Inter, #111111 Text, #FFD700 Gold für Akzente, weißer Hintergrund, extrem viel Weißraum, Apple-Website-Feeling.

**Header (exakt):** TITANWEISS all-black links — "XX / YYYY" rechts
**Footer (exakt):** TITANWEISS links — "XX / YYYY" rechts — nichts sonst

**Responsive:** Desktop 1120px+, Tablet 600–1119px, Mobile <600px

Speichere in: `/tmp/phase5_design.md`

---

### PHASE 6: REVIEW AGENT — Anti-Halluzinations-Checkliste

Arbeite jeden Punkt einzeln ab wie ein Pilot. Erst wenn ALLE bestehen: weiter zu Phase 7.

- [ ] Genau 5 Künstler:innen?
- [ ] Jede:r mit mindestens 2 Werken?
- [ ] Insgesamt mindestens 10 Werke?
- [ ] Jede:r mit WebSearch verifiziert?
- [ ] Biografische Daten korrekt?
- [ ] Jedes Werk verifiziert?
- [ ] Jedes Werk mit gültiger Bild-URL (Wikimedia oder echter Link)?
- [ ] Keine Stockfotos?
- [ ] Alle Ausstellungen mit URL verifiziert?
- [ ] Alle Ausstellungen noch laufend?
- [ ] Ausstellungs-Links spezifisch (nicht Startseite)?
- [ ] Artist-Link für jede Ausstellung vorhanden?
- [ ] Zeitgeist-Essay sachlich korrekt?
- [ ] Layout-Reihenfolge korrekt? (Zeitgeist → Künstler → Atelier Studie → Ausstellungen)
- [ ] Header-Format: "XX / YYYY"?
- [ ] Farbe: #FFD700 (kein #c9a227)?
- [ ] Footer: nur TITANWEISS + Nummer?
- [ ] Kein Werk ohne Bild und ohne Link?
- [ ] KEINE Kunsthalle Oldenburg genannt?

Für jeden nicht bestandenen Punkt: Zurück zur entsprechenden Phase.

Speichere in: `/tmp/phase6_review.md`

---

### PHASE 7: BUILD AGENT

Baut die HTML-Datei. NUR wenn Phase 6 alle 19 Punkte approved hat.

**Design-System:** Montserrat + Inter (Google Fonts), #ffffff Hintergrund, #111111 Text, #FFD700 Akzente.

**Pfad dynamisch ermitteln:**
```python
import glob
paths = glob.glob("/sessions/*/mnt/kunstmagazin/")
kunstmagazin_path = paths[0] if paths else None
```

**Bilder (Drei-Stufen-Regel):**
1. Wikimedia-Bild: `<img>` Tag mit `loading="lazy"`
2. Nur Link verfügbar: Gesamter Block als klickbarer `<a>` — dunkler Hintergrund (#1a1a1a), Künstler + Titel + "Werk ansehen →" in #FFD700, 3:2-Verhältnis
3. Weder noch: Werk komplett weglassen

**Ausstellungskarten:** Zwei Links pro Karte — "Zur Ausstellung →" + "Künstler:in →"

**Dateiname:** `TITANWEISS_Ausgabe_XX_YYYY-MM-DD.html`
**Speichern in:** `ausgaben/{Monatsname Jahr}/No. {XX} - {MM}.{YYYY}/`

---

### PHASE 8: PDF-GENERATOR

```bash
pip install weasyprint --break-system-packages
```

```python
from weasyprint import HTML
import glob
html_files = sorted(glob.glob("/sessions/*/mnt/kunstmagazin/ausgaben/**/*.html", recursive=True))
html_file = html_files[-1]
pdf_file = html_file.replace(".html", ".pdf")
HTML(filename=html_file).write_pdf(pdf_file)
```

Prüfe ob PDF erstellt wurde und mindestens 50KB groß ist.

---

## 6. Technischer Stack & Infrastruktur

| Dienst | Zweck | Details |
|---|---|---|
| GitHub | Versionskontrolle, Trigger | github.com/dea-felix/TITANWEI- |
| GitHub Pages | Hosting, Auto-Deploy | dea-felix.github.io/TITANWEI- |
| Buttondown | Newsletter | buttondown.com/titanweiss |
| GitHub Actions | Vollautomatische Pipeline | `.github/workflows/publish.yml` |
| Scheduled Task | KI-Inhaltserstellung | `inspiration-kunstmagazin`, Mo+Do 7:10 Uhr |

### Ordnerstruktur
```
kunstmagazin/
├── SPECS.md                              ← diese Datei — einzige Wahrheit
├── TITANWEISS_Design_Reference.html      ← verbindliches CSS-Template
├── index.html                            ← Startseite
├── ausgabe-aktuell.html                  ← immer aktuelle Ausgabe
├── auto-push.sh                          ← manueller Fallback
├── check.sh                              ← Health Check vor Publish
├── newsletter-pause                      ← wenn vorhanden: kein Newsletter
├── .github/
│   └── workflows/
│       └── publish.yml                   ← GitHub Actions (mit Health Check)
└── ausgaben/
    ├── kuenstler_archiv.json             ← Wiederholungsschutz
    ├── kuenstler_backlog.json            ← Kandidaten für nächste Ausgaben
    ├── ausgaben_zaehler.json             ← Ausgaben-Counter
    └── April 2026/
        └── No. 01 - 04.2026/
            ├── TITANWEISS_Ausgabe_01_2026-04-06.html
            ├── TITANWEISS_Ausgabe_01_2026-04-06.pdf
            └── INHALT.md
```

### Datei-Namenskonvention
```
TITANWEISS_Ausgabe_XX_YYYY-MM-DD.html
```

---

## 7. Publish-Workflow

### Vollautomatisch (Normalfall)
1. Scheduled Task erstellt HTML + PDF → legt sie in `ausgaben/`-Ordner
2. `git add . && git commit -m "Ausgabe X" && git push`
3. GitHub Actions übernimmt: `ausgabe-aktuell.html` aktualisieren → Netlify deployt → Newsletter via Buttondown

### Newsletter pausieren
Leere Datei `newsletter-pause` in Root-Ordner legen und pushen. Löschen → läuft wieder.

### Manueller Fallback
```bash
bash /Users/felixweckner/Desktop/kunstmagazin/auto-push.sh
```

### Sync-Problem vermeiden
Nach jedem manuellen Design-Edit an `ausgabe-aktuell.html`:
```bash
cp ausgabe-aktuell.html "ausgaben/April 2026/No. 01 - 04.2026/TITANWEISS_Ausgabe_01_2026-04-06.html"
```

---

## 8. Newsletter

- **Dienst:** Buttondown (Free Tier, vollständige API)
- **Versand:** Automatisch via GitHub Actions bei jedem Push
- **Signup-URL:** `https://buttondown.com/titanweiss/subscribe`
- **GitHub Secret:** `BUTTONDOWN_API_KEY` → Repo Settings → Secrets

---

## 9. Künstler-Archiv (gesperrt — keine Wiederholung)

| Ausgabe | Künstler:innen |
|---|---|
| No. 01 (06.04.2026) | Cecily Brown, Jadé Fadojutimi, Otis Kwame Kye Quaicoe, Neo Rauch, Henry Taylor |

---

## 10. Absolute Regeln — nie brechen

1. **ERFINDE NICHTS.** Kein Werk, kein Datum, kein Preis, keine Ausstellung ohne verifizierte URL.
2. Daniel Richter ≠ Gerhard Richter. Nie verwechseln.
3. **KEINE Kunsthalle Oldenburg** — die existiert nicht.
4. Kein NFT, keine Deko-Malerei, kein Social-Media-only.
5. **KEINE STOCKFOTOS.** Nie. Kein Unsplash, Pexels, Pixabay.
6. Ausstellungen NUR Oldenburg + Bremen. MIT spezifischen Links.
7. Sprache: Deutsch.
8. Akzentfarbe: `#FFD700`. Nicht `#c9a227`.
9. Layout-Reihenfolge: Zeitgeist → Künstler → Atelier Studie → Ausstellungen. Immer.
10. Design immer aus `TITANWEISS_Design_Reference.html` kopieren.
11. Qualität vor Geschwindigkeit. Immer.

---

## 11. Offene Aufgaben

- [ ] Buttondown-Branding einrichten (Tint-Farbe Gold, Description, Absender-Name)
- [ ] Custom Domain überlegen (z.B. titanweiss.de oder titanweiss.art)
- [ ] Echter Inhalt für Ausgabe No. 1 (aktuell Beispielinhalt auf der Website)
- [ ] Mobile-Optimierung prüfen
- [ ] Meta-Tags / SEO (og:title, og:description, og:image)
- [ ] KI-Pipeline direkt mit GitHub Actions verbinden (Scheduled Task → Auto-Push ohne Terminal)

---

*Zuletzt aktualisiert: April 2026*

# TITANWEISS — Master-Specs

> Dieses Dokument ist die einzige Wahrheit für das TITANWEISS Kunstmagazin.
> **Bitte am Anfang jeder Session als erstes lesen.**
> Der Scheduled Task (`inspiration-kunstmagazin`) lädt diese Datei automatisch von GitHub und folgt Section 5 (KI-Pipeline). Änderungen hier wirken sich beim nächsten Run automatisch aus.

> **⚠️ NULLTOLERANZ FÜR HALLUZINATIONEN:** Kein einziger Fakt darf erfunden sein. Jedes Geburtsjahr, jeder Geburtsort, jede Galerie, jede Ausstellung, jeder Preis, jede Sammlung muss per WebSearch gefunden UND per WebFetch auf der Zielseite bestätigt sein. Was nicht verifiziert ist, wird nicht verwendet. Keine Ausnahmen. Ein Magazin das unter einem echten Namen erscheint, darf keine erfundenen Informationen enthalten.

---

## 1. Was ist TITANWEISS?

Ein persönliches Kunstmagazin von Felix Weckner. Erscheint jeden Montag und Donnerstag. Behandelt zeitgenössische Kunst — Fokus auf Malerei, Expressionismus, Abstraktion. Ton: kuratiert, präzise, Artforum-Niveau auf Deutsch. Keine Hobby-Tipps, keine Deko-Kunst.

**Slogan:** *Was die Kunst weiß.*

**Felix als Maler:** Großformatig, Öl und Acryl, Richtung Abstraktion, expressiv. Referenz-Künstler: Jean-Michel Basquiat, Daniel Richter (NICHT Gerhard Richter!), Georg Baselitz, Albert Oehlen, Pablo Picasso, George Condo, Andy Warhol, Jonathan Meese. Wohnt in Oldenburg.

---

## 2. Design-System

### Philosophie
Minimalistisch, clean, Apple-Style. Keine Boxen, keine Kästen, keine überflüssigen Elemente. Viel Weißraum. Alles atmet. Alle Design-Regeln sind in dieser Datei dokumentiert.

### Farben
| Token | Wert | Verwendung |
|---|---|---|
| Hintergrund | `#ffffff` | Überall |
| Primärtext | `#111111` | Überschriften, Headlines |
| Sekundärtext | `#555555` | Einleitungen, Fließtext |
| Grau | `#999999` | Metainfos, Labels |
| Trennlinie | `#f0f0f0` | Divider |
| **Akzentfarbe** | **`#EDB800`** | **Links, Labels, CTAs — NIE `#c9a227`** |

### Typografie
| Schrift | Gewichte | Verwendung |
|---|---|---|
| Montserrat | 400, 700, 900 | Logo, Überschriften, Labels |
| Inter | 300, 400, 500 | Fließtext, Metainfos |

### Logo — verbindliche Definition
Das Logo ist immer identisch — nie abweichen:

| Eigenschaft | Wert |
|---|---|
| Text | `TITANWEISS` (immer Großbuchstaben) |
| Schrift Website | Montserrat 900 |
| Schrift Email | `'Montserrat', 'Trebuchet MS', Arial, sans-serif` (Montserrat via @import wenn möglich, sonst Fallback) |
| Farbe | `#111111` (schwarz) |
| Letter-spacing | `0.35em` |
| Text-transform | `uppercase` |
| Font-size Website | `1.1rem` (Header), größer auf Landing/Footer je nach Kontext |
| Font-size Email | `28px` |

**Slogan** (gehört immer zum Logo-Block):
- Text: `Was die Kunst weiß.` (Website) / `WAS DIE KUNST WEISS.` (Email, uppercase)
- Schrift: Inter 300 (Website) / Arial (Email)
- Farbe: `#999999` (Website) / `#bbbbbb` (Email)
- Letter-spacing: `0.08em` (Website) / `3px` (Email)

**Ausgaben-Label** (über dem Logo):
- Format: `No. XX` (Landing) oder `No. XX · Monat YYYY` (Kontext-abhängig)
- Farbe: `#EDB800` Gold
- Schrift: Montserrat 700, uppercase, winzig (`0.55rem` / `10px`)

### Design-Regeln
- **Hintergrund überall: `#ffffff` (reines Weiß — "Titanweiß")** — keine grauen Sections, kein `#f8f8f8`, kein `#fafafa`, auch Footer weiß
- **Keine Kästen, keine Cards, keine Borders** — Zeitgeist "Im Kommen" als saubere Liste mit `border-bottom: 1px solid #f0f0f0` als Trennlinie, kein Rahmen
- Keine schwarzen Blöcke, keine Card-Schatten
- Kategorielinks auf Landing: `#EDB800` Gold, Montserrat 700, uppercase
- Trennlinien: `1px solid #f0f0f0`
- Abstände großzügig (min. 40px)
- Labels: Montserrat 700, uppercase, `letter-spacing: 0.2em+`
- Keine gelbe Linie im Header (`border-bottom: none`)

### Responsive — Pflichtanforderung
- **Die Website muss auf allen Geräten funktionieren** — kein Überschneiden, kein Abschneiden, kein horizontales Scrollen
- Breakpoints: Desktop 1120px+ / Tablet 600–1119px / Mobile < 600px
- Auf Mobile: alle Grids auf 1-spaltig, Padding reduziert (mind. 20px seitlich), Schriftgrößen angepasst
- Artist-Sections: auf Tablet/Mobile einspaltiger Stack (Text oben, Werk-Links unten), kein `direction: rtl`
- Header: auf Mobile Padding 20px, Logo kleiner, Höhe 60px
- Kategorie-Menü: auf Mobile volle Breite, Abstände bleiben erhalten
- Footer: auf Mobile 1-spaltig

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
1. `NO. XX` — Montserrat 700, Gold, uppercase, winzig
2. `Was die Kunst weiß.` — Montserrat 700, grau, uppercase
3. Kategorielinks: ZEITGEIST / KÜNSTLER:INNEN / ATELIER STUDIE / AUSSTELLUNGEN — Gold, Montserrat 700, uppercase
4. `Archiv` — Gold, winzig, dezent (opacity 0.7), → archiv.html
5. Newsletter-Signup: Label + Email-Input + Button — inline, kein Redirect (versteckter iframe, Buttondown Opt-in-Mail wird ausgelöst)

### Archiv
- `archiv.html` — weiße Seite, kein Logo, kleiner `← Zurück`-Link oben links → index.html
- Ausgaben als Liste zentriert: `No. 01`, `No. 02` etc. — Gold, Montserrat 700, mit border-bottom Trennlinie
- **Unter jeder Ausgabennummer:** Kurze Zusammenfassung mit den Künstler:innen-Namen der Ausgabe — Inter 300, grau (`#aaaaaa`), zentriert (z.B. `Andreani · Mohammed Sami · Kamrooz Aram · Flora Yukhnovich`)
- Jede Ausgabe verlinkt auf `archiv/no-XX/index.html`
- **Beim Abschluss jeder Ausgabe:** `ausgabe-aktuell.html` kopieren nach `archiv/no-XX/index.html` und neuen Eintrag in `archiv.html` ergänzen (inkl. Künstler:innen-Namen aus `name-card-name`-Links)
- **ARCHIV-PFLICHT nach Kopie:** Nach dem Kopieren MUSS die Ausgabennummer in `<title>` und `<span class="header-issue">` auf die korrekte Nummer geändert werden (z.B. "01 / 2026" für No. 01). Archiv-Dateien dürfen NICHT die Nummer der aktuellen Ausgabe zeigen!
- PDFs werden nicht mehr benötigt — HTML-Snapshot im archiv/-Ordner reicht

### Footer (innerhalb jeder Kategorie)
- Hintergrund: `#ffffff` — weiß wie alles andere
- `border-top: 1px solid #f0f0f0` als dezente Trennung
- Logo: `#111111`, Montserrat 900
- Labels: `#bbbbbb` grau (nicht Gold)
- `← Alle Kategorien` Link: grau, hover → schwarz
- 3-spaltig: TITANWEISS + Tagline | Ausgabeninfo | Newsletter-Link

### "Im Kommen" — Names to Watch
- **Keine Cards, keine Boxen** — saubere vertikale Liste
- Jeder Eintrag: Name als klickbarer Extern-Link (`→`) → direkt zur Galerie/Institution des Künstlers/der Künstlerin (kein `showSection` — das führt zu Verwirrung)
- **Im Kommen enthält IMMER andere Künstler:innen als die Künstler:innen-Sektion** — keine Überschneidungen
- Trennung zwischen Einträgen: `border-bottom: 1px solid #f0f0f0`
- Name: Montserrat 700, hover → `#EDB800`

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
- Header: Glaseffekt (`backdrop-filter: blur(12px)`), `border-bottom: 1px solid #EDB800`
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
2. **Künstler:innen** — 5 Künstler:innen, je 2 Werke, 200–300 Wörter pro Person (Kategorie heißt **Künstler:innen**, nicht "Künstler")
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

### Werke — Verlinkung in Künstler:innen-Sektion
- **Keine dunklen Blöcke, keine schwarzen Kästen** (`.werk-link-block` mit `background: #1a1a1a` ist VERBOTEN)
- Jedes Werk wird als sauberer Text-Link dargestellt: Titel kursiv + Galerie/Institution als "→"-Link in Gold
- CSS-Klasse: `.werk-text-link` — weißer Hintergrund, `border-bottom: 1px solid #f0f0f0`, kein Box-Aspekt
- **Beide Links pro Künstler:in müssen unterschiedliche URLs haben** — nie zweimal dieselbe URL
- Link 1: spezifischstes Werk / Galerie-Seite
- Link 2: andere Institution / alternatives Werk / Museumseite
- **PFLICHT: Jeden externen Link mit WebFetch prüfen bevor er eingebaut wird.** Ein 404 oder Redirect auf eine falsche Seite = Link weglassen und durch funktionierenden Link ersetzen. Nicht-geprüfte Links sind VERBOTEN.
- **Galerie-Links:** Immer direkt zur Artist-Seite der Galerie verlinken (z.B. `hauserwirth.com/artists/name`), nicht zur Galerie-Startseite. Der Link muss zu Werken oder der Künstler:innen-Seite führen — keine allgemeinen Übersichtsseiten.
- **Wenn Artist-Subpage nicht erreichbar:** Andere Quelle suchen (andere Galerie, Museum, Institution) die eine funktionierende Artist-Seite hat. Notfalls weglassen — niemals einen kaputten Link einbauen.

### Ausstellungen — Design-Regeln
- **Keine Kästen, keine Cards, keine Borders** — saubere Liste mit `border-bottom: 1px solid #f0f0f0`
- **Kein "Laufend"-Status** — wird nicht angezeigt
- **Nur "Eröffnung [Datum]"** wenn die Ausstellung noch nicht begonnen hat — in grau (`#999999`), Montserrat 700 uppercase, kein Hintergrund, kein Kasten
- Jede Ausstellung: Stadt → Institution → Titel → Datum → (optional: Eröffnungshinweis) → Text → Links

### Ausstellungen — Inhalt
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

**NULL-HALLUZINATIONS-GARANTIE — Faktenblatt pro Künstler:in:**

⚠️ ABSOLUT KEINE ERFUNDENEN FAKTEN. Jeder einzelne Fakt muss durch eine echte, aufgerufene Quelle belegt sein. "Ich bin mir ziemlich sicher" zählt nicht. Nur was schwarz auf weiß per WebSearch gefunden UND per WebFetch auf der Zielseite bestätigt wurde, darf verwendet werden.

Für jede:n der 5 finalen Künstler:innen MUSS ein Faktenblatt erstellt werden BEVOR Texte geschrieben werden. Ablauf pro Künstler:in:

1. **WebSearch** nach "[Name] artist biography" / "[Name] Künstler Galerie"
2. **WebFetch** der gefundenen Galerie-Seite oder Wikipedia-Seite — tatsächlich lesen, nicht nur URL notieren
3. Fakten NUR aus dem gelesenen Inhalt extrahieren
4. Wenn ein Fakt (z.B. Geburtsjahr) auf der Seite NICHT steht → Feld leer lassen, NICHT raten

Format:
```
FAKTENBLATT: [Name]
- Geburtsjahr: [Jahr] — Quelle: [URL] — WebFetch bestätigt: JA/NEIN
- Geburtsort: [Ort] — Quelle: [URL] — WebFetch bestätigt: JA/NEIN
- Lebt in: [Stadt] — Quelle: [URL] — WebFetch bestätigt: JA/NEIN
- Galerie(n): [Namen] — Quelle: [URL] — WebFetch bestätigt: JA/NEIN
- Ausstellungen: [Liste] — je mit Quelle + WebFetch bestätigt
- Sammlungen: [Liste] — je mit Quelle + WebFetch bestätigt
- Preise: [Liste] — je mit Quelle + WebFetch bestätigt
- STATUS: ✅ KOMPLETT VERIFIZIERT / ⚠️ LÜCKEN: [welche Felder fehlen]
```

**HARTE REGELN:**
- Kein Fakt ohne WebFetch-Bestätigung → NICHT verwenden
- "WebFetch bestätigt: NEIN" → Fakt STREICHEN, nicht in Text übernehmen
- Lieber 3 verifizierte Fakten als 10 mit einer erfundenen dazwischen
- Geburtsjahre und -orte: IMMER mit offizieller Galerie-Seite oder Wikipedia abgleichen
- Sammlungen/Preise: NUR wenn auf der Künstler:in-Seite explizit genannt
- Ausstellungen: NUR wenn auf Museums-/Galerie-Website mit Datum bestätigt
- Phase 4 (Texte) darf NUR Fakten verwenden die im Faktenblatt "WebFetch bestätigt: JA" haben

Die Faktenblätter werden an `/tmp/phase1_rohmaterial.md` angehängt und sind die EINZIGE Faktenquelle für alle folgenden Phasen. Alles was nicht im Faktenblatt steht, existiert nicht.

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

**Design:** Montserrat + Inter, #111111 Text, #EDB800 Gold für Akzente, weißer Hintergrund, extrem viel Weißraum, Apple-Website-Feeling.

**Header (exakt):** TITANWEISS all-black links — "XX / YYYY" rechts
**Footer (exakt):** TITANWEISS links — "XX / YYYY" rechts — nichts sonst

**Responsive:** Desktop 1120px+, Tablet 600–1119px, Mobile <600px

Speichere in: `/tmp/phase5_design.md`

---

### PHASE 5a: LATERALDENKER — Plausibilitätscheck

Tritt einen Schritt zurück. Lies `/tmp/phase4_texte.md` UND die Faktenblätter aus `/tmp/phase1_rohmaterial.md` und prüfe:

- **Faktenblatt-Abgleich (PFLICHT):** Gehe JEDE:N Künstler:in einzeln durch. Vergleiche JEDE biografische Angabe im HTML Wort für Wort mit dem Faktenblatt. Geburtsjahr, Geburtsort, Galerie, Sammlungen, Ausstellungen, Preise — alles. Eine einzige Abweichung = KRITISCH.
- **Quellen-Check (PFLICHT):** Hat jeder Fakt "WebFetch bestätigt: JA"? Wenn NEIN → KRITISCH. Zusätzlich: ALLE Künstler-Links im HTML per WebFetch aufrufen — jeder 404 = KRITISCH.
- Stimmt die inhaltliche Struktur? (Zeitgeist → Künstler → Atelier → Ausstellungen)
- Gibt es inhaltliche Widersprüche oder Inkonsistenzen?
- Wirken Künstler:innen-Beschreibungen plausibel oder verdächtig generisch?
- Gibt es Sätze die klingen als wären sie erfunden? ("Der Künstler ist bekannt für...")
- Passen Stil-Einschätzungen zu den verlinkten Werken?
- Gibt es Überschneidungen mit dem Künstler-Archiv (Wiederholungen)?
- **Halluzinations-Muster:** Suche gezielt nach typischen KI-Erfindungen: falsche Geburtsjahre, erfundene Sammlungszugehörigkeiten, nicht existierende Ausstellungen, falsche Galerievertretungen

Schreibe alle KRITISCH-Befunde explizit auf. Ein offener KRITISCH-Befund blockiert Phase 7.

Speichere in: `/tmp/phase5a_lateral.md`

---

### PHASE 5b: EMERGENZ REVIEW AGENT — Tech & Design Check

Technischer und rechtlicher Qualitätscheck. Prüfe:

- Lokale Fonts: `<link rel="stylesheet" href="fonts/fonts.css">` vorhanden? **Kein Google Fonts CDN — auch nicht in Ausgaben-Unterordnern!** (DSGVO-Verstoß)
- Farben: Nur `#EDB800` — kein `#c9a227`, kein anderes Gold?
- Responsive: Mobile-Breakpoints vorhanden? Kein horizontales Scrollen?
- Rechtlich: Links zu `impressum.html` und `datenschutz.html` im Footer?
- Sicherheit: Alle externen Links mit `target="_blank" rel="noopener"`?
- Keine offenen KRITISCH-Befunde aus Phase 5a?
- **Faktenblatt-Konsistenz (PFLICHT):** Geburtsjahre, Geburtsorte, Galerien im HTML müssen IDENTISCH mit Faktenblatt sein. Jede Abweichung = KRITISCH.

Schreibe alle KRITISCH-Befunde explizit auf. Ein offener KRITISCH-Befund blockiert Phase 7.

Speichere in: `/tmp/phase5b_review.md`

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
- [ ] **ALLE externen Links per WebFetch geprüft — kein einziger 404?** (Künstler:innen-Links, Ausstellungslinks, Werk-Links)
- [ ] Zeitgeist-Essay sachlich korrekt?
- [ ] Layout-Reihenfolge korrekt? (Zeitgeist → Künstler → Atelier Studie → Ausstellungen)
- [ ] Header-Format: "XX / YYYY"?
- [ ] Farbe: #EDB800 (kein #c9a227)?
- [ ] Footer: nur TITANWEISS + Nummer?
- [ ] Kein Werk ohne Bild und ohne Link?
- [ ] KEINE Kunsthalle Oldenburg genannt?

Für jeden nicht bestandenen Punkt: Zurück zur entsprechenden Phase.

Speichere in: `/tmp/phase6_review.md`

---

### PHASE 7: BUILD AGENT

Baut die HTML-Datei. NUR wenn Phase 6 alle 19 Punkte approved hat.

**Design-System:** Montserrat + Inter (Google Fonts), #ffffff Hintergrund, #111111 Text, #EDB800 Akzente.

**Pfad dynamisch ermitteln:**
```python
import glob
paths = glob.glob("/sessions/*/mnt/kunstmagazin/")
kunstmagazin_path = paths[0] if paths else None
```

**Bilder (Drei-Stufen-Regel):**
1. Wikimedia-Bild: `<img>` Tag mit `loading="lazy"`
2. Nur Link verfügbar: Gesamter Block als klickbarer `<a>` — dunkler Hintergrund (#1a1a1a), Künstler + Titel + "Werk ansehen →" in #EDB800, 3:2-Verhältnis
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

### PHASE 9: AUTO-PUBLISH

Rufe `auto-push.sh` auf. Das Script erledigt alles weitere automatisch:

```python
import subprocess, glob

# Pfad zum Repo dynamisch ermitteln
paths = glob.glob("/sessions/*/mnt/kunstmagazin/")
repo = paths[0] if paths else None

if repo:
    result = subprocess.run(
        ["bash", repo + "auto-push.sh"],
        capture_output=True, text=True, cwd=repo
    )
    print(result.stdout)
    if result.returncode != 0:
        print("FEHLER:", result.stderr)
```

`auto-push.sh` übernimmt: check.sh Gate → ausgabe-aktuell.html überschreiben → index.html updaten → Archiv-Snapshot → archiv.html Eintrag → Git Push → Newsletter via Buttondown API.

---

## 6. Technischer Stack & Infrastruktur

| Dienst | Zweck | Details |
|---|---|---|
| GitHub | Versionskontrolle, Trigger | github.com/dea-felix/TITANWEI- |
| GitHub Pages | Hosting, Auto-Deploy | dea-felix.github.io/TITANWEI- |
| Buttondown | Newsletter | buttondown.com/titanweiss |
| Scheduled Task | KI-Inhaltserstellung + Auto-Publish | `inspiration-kunstmagazin`, Mo+Do 7:10 Uhr |

### Ordnerstruktur
```
kunstmagazin/
├── SPECS.md                              ← diese Datei — einzige Wahrheit
├── index.html                            ← Startseite
├── ausgabe-aktuell.html                  ← immer aktuelle Ausgabe
├── archiv.html                           ← Archiv-Übersicht
├── impressum.html                        ← Impressum (DSGVO-konform)
├── datenschutz.html                      ← Datenschutzerklärung
├── og-image.png                          ← 1200×630 Social-Preview-Bild
├── auto-push.sh                          ← Vollautomatischer Publish-Workflow
├── check.sh                              ← Health Check (läuft vor jedem Publish)
├── newsletter-pause                      ← wenn vorhanden: kein Newsletter
├── fonts/
│   ├── fonts.css                         ← lokale @font-face Definitionen
│   ├── montserrat-400/700/900.woff2      ← Montserrat lokal (DSGVO-konform)
│   └── inter-300/400/500.woff2           ← Inter lokal (DSGVO-konform)
├── archiv/
│   └── no-01/index.html                 ← Snapshot Ausgabe 01
└── ausgaben/
    ├── kuenstler_archiv.json             ← Wiederholungsschutz
    ├── kuenstler_backlog.json            ← Kandidaten für nächste Ausgaben
    ├── ausgaben_zaehler.json             ← Ausgaben-Counter
    └── April 2026/
        └── No. 02 - 04.2026/
            ├── TITANWEISS_Ausgabe_02_2026-04-03.html
            ├── TITANWEISS_Ausgabe_02_2026-04-03.pdf
            └── INHALT.md
```

### Datei-Namenskonvention
```
TITANWEISS_Ausgabe_XX_YYYY-MM-DD.html
```

---

## 7. Publish-Workflow

### Vollautomatisch (Normalfall)
1. Scheduled Task (`inspiration-kunstmagazin`) startet Mo+Do um 7:10 Uhr
2. Durchläuft Phasen 0–8: Recherche → Redaktion → Review → HTML → PDF
3. **Phase 9** ruft `auto-push.sh` auf — das erledigt alles weitere:
   - `check.sh` läuft als Gate (bricht ab bei Fehlern)
   - `ausgabe-aktuell.html` wird mit neuer Ausgabe überschrieben
   - `index.html` Ausgabe-Nummer wird aktualisiert
   - `archiv/no-XX/index.html` Snapshot wird erstellt
   - `archiv.html` bekommt neuen Eintrag
   - Git Push → GitHub Pages deployt automatisch
   - Newsletter an alle Abonnenten via Buttondown API

### Newsletter pausieren
Leere Datei `newsletter-pause` in Root-Ordner anlegen:
```bash
touch ~/Desktop/kunstmagazin/newsletter-pause && cd ~/Desktop/kunstmagazin && git add newsletter-pause && git commit -m "Newsletter pausiert" && git push
```
Löschen → läuft wieder:
```bash
rm ~/Desktop/kunstmagazin/newsletter-pause && cd ~/Desktop/kunstmagazin && git add -A && git commit -m "Newsletter wieder aktiv" && git push
```

### Manueller Fallback
```bash
bash ~/Desktop/kunstmagazin/auto-push.sh
```

### Fonts — DSGVO-Hinweis
Google Fonts sind lokal eingebunden (`fonts/`). Bei neuen Ausgaben immer `<link rel="stylesheet" href="fonts/fonts.css">` verwenden — KEIN Google Fonts CDN.

---

## 8. Newsletter

- **Dienst:** Buttondown (Free Tier, vollständige API)
- **Versand neuer Ausgaben:** Automatisch via `auto-push.sh` → Buttondown API (`/v1/emails`)
- **API-Key:** in `auto-push.sh` hinterlegt (dc61a8d1-…)

### Signup-Formular (ausgabe-aktuell.html)
- Kein Redirect zu Buttondown — Seite bleibt offen
- Technisch: versteckter `<form target="nl-iframe">` + unsichtbares `<iframe>` — Buttondown verarbeitet die Anfrage, der Redirect landet im iframe
- Double Opt-in bleibt erhalten — Buttondown schickt Bestätigungsmail
- Hinweis unter der Bestätigung: "Nichts da? Kurz im Spam-Ordner nachschauen." (Buttondown-Mails landen initial oft im Spam)
- Redirect-Ziel im hidden form: `danke.html`

### Buttondown Branding — Pflichtregeln
- **Kein echter Name** — nirgendwo "Felix Weckner" sichtbar ✅
- Username: `titanweiss` → URL: `buttondown.com/titanweiss` ✅
- Newsletter name: `TITANWEISS` ✅
- Author name: `TITANWEISS` (From-Feld in der Mail) ✅
- Header/Footer Editor: **Markdown mode** (nicht "Fancy mode" — "Naked mode"/HTML ist Paid-only)
- Logo im Header: PNG `https://dea-felix.github.io/TITANWEI-/titanweiss-logo-email.png` ✅
- Footer-Block (Settings → Design → Email → Footer toggle): TITANWEISS + Slogan + Link ✅
- **Großer Titel oben ("TITANWEISS")** — automatisch von Buttondown, Free Plan → nicht entfernbar, bleibt so
- **"Powered by Buttondown"** — nur mit Paid Plan ($9/Mo) entfernbar → bleibt vorerst
- Unsubscribe-Links im Footer — gesetzlich Pflicht, immer drin lassen

---

## 9. Künstler-Archiv (gesperrt — keine Wiederholung)

| Ausgabe | Künstler:innen |
|---|---|
| *(noch leer — Neustart ab No. 01, 07.04.2026)* | |

---

## 10. Absolute Regeln — nie brechen

1. **ERFINDE NICHTS.** Kein Werk, kein Datum, kein Preis, keine Ausstellung ohne verifizierte URL. Kein Geburtsjahr, kein Geburtsort, keine Galerie, keine Sammlung ohne WebFetch-Bestätigung.
2. Daniel Richter ≠ Gerhard Richter. Nie verwechseln.
3. **KEINE Kunsthalle Oldenburg** — die existiert nicht.
4. Kein NFT, keine Deko-Malerei, kein Social-Media-only.
5. **KEINE STOCKFOTOS.** Nie. Kein Unsplash, Pexels, Pixabay.
6. Ausstellungen NUR Oldenburg + Bremen. MIT spezifischen Links.
7. Sprache: Deutsch.
8. Akzentfarbe: `#EDB800`. Nicht `#c9a227`.
9. Layout-Reihenfolge: Zeitgeist → Künstler → Atelier Studie → Ausstellungen. Immer.
10. Design immer aus SPECS.md Section 2 (Design-System) übernehmen.
11. Qualität vor Geschwindigkeit. Immer.
12. **Hintergrund IMMER `#ffffff`** — kein `#f8f8f8`, kein `#fafafa`, kein Grau. Auch nicht als CSS-Variable.
13. **JEDER `target="_blank"` braucht `rel="noopener"`** — keine Ausnahme, auch nicht bei Buttondown-Links in Footern.
14. **Archiv-Nummern prüfen** — nach dem Kopieren von ausgabe-aktuell.html ins Archiv: `<title>` und `<span class="header-issue">` MÜSSEN die Archiv-Nummer zeigen, nicht die aktuelle Ausgabe.
15. **Keine unverifizierbaren Superlative** — "Jüngste Künstlerin in der Sammlung des...", "Erste Ausstellung seit..." — nur wenn per WebFetch auf der Quelle bestätigt. Sonst weglassen.
16. **Kein Google Fonts CDN** — in KEINER Datei, auch nicht in Ausgaben-Unterordnern. Immer lokale `fonts/fonts.css` mit korrektem relativen Pfad.

---

## 11. Rechtliches

### Impressum
- Betreiber: Felix Weckner, Staustraße 14, 26122 Oldenburg
- Kontakt: felixweckner@icloud.com
- KI-Hinweis + Haftungsausschluss vorhanden (`impressum.html`)
- Urheberrecht: eigene redaktionelle Leistungen, KI-unterstützt, Felix trägt Verantwortung

### Datenschutzerklärung (`datenschutz.html`)
- Hosting: GitHub Pages — Server-Logs max. 14 Tage
- Schriftarten: lokal eingebunden, kein Google Fonts CDN
- Newsletter: Buttondown, Rechtsgrundlage Einwilligung, Speicherung bis Abmeldung
- Cookies: keine
- KI-Werkzeuge: Claude von Anthropic, keine Besucherdaten werden übermittelt
- Aufsichtsbehörde: LfD Niedersachsen, Hannover
- KI-Kennzeichnungspflicht (EU AI Act Art. 50): gilt ab 2. August 2026

### SEO & Social
- og:image: `og-image.png` (1200×630px, weiß/schwarz/gold)
- Alle Seiten: og:title, og:description, og:image, Twitter Card
- Impressum + Datenschutz: `noindex, nofollow`

---

## 12. Offene Aufgaben

- [ ] Custom Domain (titanweiss.de oder titanweiss.art)
- [ ] Buttondown-Branding (Tint-Farbe Gold, Description, Absender-Name)
- [x] Impressum + Datenschutz (DSGVO-konform, April 2026)
- [x] Google Fonts lokal eingebunden
- [x] SEO Meta-Tags + og:image
- [x] KI-Pipeline vollautomatisch (Mo+Do 7:10 Uhr, Phasen 0–9)
- [x] Mobile-Optimierung

---

---

## 13. Emergenz-Agenten

Referenz-Definitionen für die Agent-Infrastruktur des EMERGENZ-Projekts.

### Agent: Lateraldenker

Lokation: `@agents/lateraldenker.md`

Elite-Ingenieur mit 30 Jahren Erfahrung in Messtechnik, Sensorik und Signalverarbeitung. Kernstärke: radikale Domänen-Transferenz — Lösung physischer, technischer und konzeptioneller Probleme durch Werkzeuge aus fremden Disziplinen. Einsatzgebiet: Hardware-Probleme, Messtechnik, Sensor-Design, Signalverarbeitung im ESP32-S3/Permakultur-Kontext.

**Board-Kommunikation:** Liest `orchestration/board/tasks.md` (Aufgaben mit `[Lateral]`), meldet Fortschritt in `orchestration/board/status.md`.

**Deliverables:** `{Datum}_{Thema}_Lateralanalyse.md` → `08_Hardware/`

---

### Agent: Review

Lokation: `@agents/review.md`

Prüft Code-Qualität, findet Bugs, stellt Standards sicher. Arbeitet nur Aufgaben mit `[Review]` aus `orchestration/board/tasks.md` ab.

**Zuständigkeiten:**
- Code-Reviews für neue Varianten und Änderungen
- Sicherheitsprüfung (SQL Injection, Input Validation, Secrets)
- Performance-Analyse (DB-Queries, API-Calls, Memory)
- Konsistenz-Check gegen Projekt-Standards
- Vergleich zwischen Varianten (Score-Bewertung)
- `variants.json` Score + Pros/Cons aktualisieren

**Review-Checkliste:**

*Code-Qualität:* TypeScript strict (kein `any`), Zod-Schemas für externe Daten, Error-Handling in Providern, SQL `IF NOT EXISTS` in Migrationen, keine hartkodierten Credentials, `@dea/shared` korrekt eingebunden.

*Architektur:* Provider-Pattern, Routes korrekt registriert, Export nach `weather_overrides`, Migrationen idempotent.

*Frontend:* Dark Theme CSS Variables, Template-Literals statt String-Concatenation, Leaflet korrekt initialisiert (CARTO Dark Basemap), Vanilla JS.

*Daten:* Koordinatensystem SRID 4326/32632, Oldenburg 53.1435N/8.2146E, Zeitzone UTC vs. Europe/Berlin, Einheiten dokumentiert.

**Scoring-Kriterien:**

| Kriterium | Gewicht |
|---|---|
| Datenqualität | 30% |
| Code-Qualität | 20% |
| Pipeline | 20% |
| Frontend | 15% |
| Dokumentation | 15% |

**Output-Format:**
```
## Review: {layer}/v{NN}-{name}
### Score: X.X / 1.0
### Positiv / Probleme ([KRITISCH] / [WARNUNG] / [HINWEIS]) / Empfehlungen
```

---

*Zuletzt aktualisiert: April 2026*

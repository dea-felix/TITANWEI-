# TITANWEISS — Übergabe & Projektstand

Dieses Dokument ist der Einstiegspunkt für neue Chat-Sessions.
Lies es zuerst, dann kennst du alles was bisher entschieden und gebaut wurde.

---

## Was ist TITANWEISS?

Ein persönliches Kunstmagazin für Felix Weckner, das vollautomatisch zweimal pro Woche erscheint (Montag & Donnerstag, 7:10 Uhr). Es enthält 5 Künstler/innen mit je 2 Werken, eine Atelier-Technik und aktuelle Ausstellungen in Oldenburg und Bremen.

---

## Aktueller Stand

### Fertig und läuft:
- **Scheduled Task** `inspiration-kunstmagazin` — aktiv, Cron `10 7 * * 1,4`
- **9-Phasen-Pipeline** (Phase 0–8): Zeitgeist → Kunst-Recherche → Ausstellungen → Kritiker → Redakteur → Design → Review (20-Punkte-Checkliste) → HTML-Build → PDF
- **Ordnerstruktur**: `ausgaben/{Monatsname Jahr}/No. {XX} - {MM}.{YYYY}/`
- **Künstler-Archiv**: verhindert Wiederholungen zwischen Ausgaben
- **Ausgaben-Zähler**: einfacher Counter statt fehleranfälliger Datumsberechnung
- **INHALT.md**: wird automatisch in jeden Ausgabe-Ordner geschrieben
- **Design**: verbindlich eingefroren in `TITANWEISS_Design_Reference.html`
- **Ausgabe 01** erschienen: 6. April 2026

### Design-Entscheidungen (nicht ändern ohne Felix):
- Akzentfarbe: `#FFD700` (reines Gold)
- Logo: TITANWEISS all-black, kein farbiges I
- Header: TITANWEISS links — "01 / 2026" rechts
- Footer: TITANWEISS links — Ausgabe-Nummer rechts
- Fonts: Montserrat (Headlines) + Inter (Body)
- Hintergrund: #ffffff, Text: #111111

---

## Ordnerstruktur

```
kunstmagazin/
├── UEBERGABE.md                          ← diese Datei
├── TITANWEISS_Prompt_zur_Kontrolle.md  ← vollständiger Prompt zum Lesen
├── TITANWEISS_Design_Reference.html    ← verbindliches CSS-Template
├── ausgaben/
│   ├── kuenstler_archiv.json            ← alle bisherigen Künstler/innen
│   ├── ausgaben_zaehler.json            ← aktueller Ausgaben-Counter
│   └── April 2026/
│       └── No. 01 - 04.2026/
│           ├── TITANWEISS_Ausgabe_01_2026-04-06.html
│           ├── TITANWEISS_Ausgabe_01_2026-04-06.pdf
│           └── INHALT.md
```

---

## Website & Infrastruktur

- **GitHub Repo**: https://github.com/dea-felix/TITANWEI-
- **Netlify URL**: https://titanweissmagazin.netlify.app
- **Auto-Push Script**: `/Users/felixweckner/Desktop/kunstmagazin/auto-push.sh`
- **Mac Cron-Job**: läuft Mo + Do um 7:30 Uhr → pusht neue Ausgabe zu GitHub → Netlify deployed automatisch

---

## Nächste geplante Aufgabe: NEWSLETTER

Felix möchte eine öffentliche Website + Newsletter aufbauen. Entschieden:
- **Öffentlich** (jeder mit dem Link kann lesen)
- **Offener Newsletter**: Signup-Formular auf der Website, jeder kann sich eintragen, langfristig Leserschaft aufbauen

### Geplante Architektur:
```
Scheduled Task (Montag/Donnerstag)
  ↓ baut HTML + PDF wie bisher
  ↓ pushed HTML zu GitHub Repository
  ↓
Netlify deployt automatisch → öffentliche Website
  ↓
Newsletter-API (Buttondown oder Beehiiv) → Email an Abonnenten
```

### Was noch fehlt / zu klären:
1. Hat Felix schon eine Domain (z.B. felixweckner.de)? Falls ja, kann die Website dort laufen. Falls nein: Netlify-Gratis-URL als Start.
2. Accounts anlegen: GitHub + Netlify + Newsletter-Dienst (Buttondown empfohlen: einfach, API-freundlich, kostenlos bis 100 Abonnenten)
3. GitHub Repository einrichten und mit Netlify verknüpfen
4. Scheduled Task um Phase 9 (GitHub Push) und Phase 10 (Newsletter-API) erweitern
5. Signup-Formular in das HTML-Template (Design_Reference.html) einbauen
6. Entscheiden: bekommt der Abonnent die volle Ausgabe per Email oder nur einen "Neue Ausgabe ist draußen"-Link?

### Empfehlung Newsletter-Dienst:
- **Buttondown** (buttondown.email) — einfachste API, Fokus auf Writer, $0 für erste 100 Abonnenten
- **Beehiiv** (beehiiv.com) — moderner, bessere Analytics, kostenlos bis 2.500 Abonnenten, etwas mehr Setup

---

## Bisherige Künstler/innen (gesperrt für zukünftige Ausgaben)

Ausgabe 01: Cecily Brown, Jadé Fadojutimi, Otis Kwame Kye Quaicoe, Neo Rauch, Henry Taylor

---

## Wichtige Regeln (nie vergessen)

- Daniel Richter ≠ Gerhard Richter
- Es gibt KEINE Kunsthalle in Oldenburg
- Keine Stockfotos (Unsplash, Pexels etc.) niemals
- Akzentfarbe immer #FFD700, nie #c9a227
- Layout: Zeitgeist → Künstler+Werke → Technik → Ausstellungen
- Design immer aus TITANWEISS_Design_Reference.html kopieren

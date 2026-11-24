#import "TUBAF_typst_template/tubaf_template.typ" as tubaf
#import "@preview/simple-plot:1.1.1": plot

#let theme = "tubaf"
//#let theme = "tud"
#if theme not in ("tubaf", "tud") {
  panic("Choose theme=tubaf or theme=tud.")
}

#let tud = if theme == "tud" {
  import "tud-presentation-template/lib.typ" as template
  template
}
#let accent = if theme == "tud" { tud.tudc.brilliantblau } else { tubaf.colors.Dunkelblau }
#let talk-title = [Typst -- eine moderne Alternative zu LaTeX]
#let talk-subtitle = "Bits & Bytes"
#let speakers = "Richard & Martin"
#let speaker-names = [Martin Werner - Richard Voigtmann]

#show: body => if theme == "tud" {
  tud.tud-deck(
    title: talk-title,
    author: speakers,
    lang: "de",
    partner-logo: image("TUBAF_typst_template/logos/TUBAF_Logo_blau.svg", height: 5.2mm),
  )[
    #tud.title-slide-6(title: talk-title, overline: talk-subtitle, extras: speaker-names)[]

    #body
  ]
} else {
  tubaf.presentation(
    title: talk-title,
    subtitle: talk-subtitle,
    author: speakers,
    bottom-text: speaker-names,
    lang: "de",
  )[
    #show figure.caption: it => text(size: 9pt)[*#it.supplement #it.counter.display()#it.separator* #it.body]
    #body
  ]
}

#let hidden_heading(it) = heading(level: 2, outlined: false, it)

#outline(depth: 2)



== Was ist das Problem?

- Erstellen von größeren Textdokumenten
- Formatvorlagen für gleichmäßiges styling
- Kollaboration mit mehreren Autoren... auf mehreren Geräten

#hidden_heading([Was ist das Problem?])

- Erstellen von größeren Textdokumenten
- Formatvorlagen für gleichmäßiges styling
- Kollaboration mit mehreren Autoren... auf mehreren Geräten

#place(bottom + center, dy: -50pt)[
  #text(size: 20pt)[Gibt es nicht schon Word?]
]

== Word und seine Spin-offs
#let word-critique = place(
  top + left,
  dy: if theme == "tud" { 4em } else { 3.25em },
  grid(columns: (1fr, 1fr), column-gutter: 1em)[
    - Direkt auf der Seite schreiben und das Layout sofort sehen.
    - Formatvorlagen anwenden, Bilder und Tabellen per Klick einfügen und bewegen.
    - Dokumente gemeinsam überarbeiten, kommentieren und Änderungen nachverfolgen.
  ][#figure(caption: [Word im Browser])[
    #image("images/word_ui.png", height: 75%)
  ]],
)
#word-critique

// One reveal per click. Earlier images keep their positions as new pairs pile up.
#let word-reveals = (
  ((file: "word_lizenz.png", x: 1em, y: 7em, width: 100%, angle: 10deg),),
  (
    (file: "Wordhate/image.png", x: 16.3em, y: 10.4em, width: 32.8em, angle: -5deg),
    (file: "Wordhate/image copy.png", x: -1.7em, y: 10.8em, width: 16.8em, angle: 8deg),
  ),
  (
    (file: "Wordhate/image copy 2.png", x: -0.85em, y: 16.15em, width: 39.5em, angle: 3.5deg),
    (file: "Wordhate/image copy 3.png", x: 9.8em, y: -0.3em, width: 35.5em, angle: 3.5deg),
  ),
  (
    (file: "Wordhate/image copy 4.png", x: -1.8em, y: 5.4em, width: 32.7em, angle: 4deg),
    (file: "Wordhate/image copy 5.png", x: 15.1em, y: 19.95em, width: 28em, angle: -2.5deg),
  ),
  (
    (file: "Wordhate/image copy 6.png", x: -1.8em, y: 19.25em, width: 30em, angle: 3deg),
    (file: "Wordhate/image copy 7.png", x: 9.5em, y: 5.8em, width: 30.3em, angle: -4deg),
  ),
  (
    (file: "Wordhate/image copy 8.png", x: 10.9em, y: 14.8em, width: 38.9em, angle: -3.8deg),
    (file: "Wordhate/image copy 9.png", x: -1.5em, y: 0.05em, width: 11.8em, angle: -7deg),
  ),
)
#for count in range(1, word-reveals.len() + 1) {
  if theme == "tud" { pagebreak() } else { hidden_heading[Word und seine Spin-offs] }
  word-critique
  for overlay in word-reveals.slice(0, count).flatten() {
    place(top + left, dx: overlay.x, dy: overlay.y, rotate(
      overlay.angle,
      image("images/" + overlay.file, width: overlay.width),
    ))
  }
  place(bottom + right, dy: -20pt, dx: 9pt)[#text(
    size: 9pt,
  )[@reddit:word_hate_1,@reddit:word_hate_2,@reddit:word_hate_3,@word_lizenz]]
}
#hidden_heading([Word und seine Spin-offs])
#grid(columns: (45%, 1fr))[

  - 149 € einmalig (Office Home) oder regulär 99 € *pro Jahr* (Microsoft 365 Single) @word_pricing.
  - Word hat eine Web version... ABER: Abschnittsumbrüche nur am Desktop @word_web_features.
  - *Seitenzahlen.* Einstellung zu Seitennummerierung unnötig schwer @forum_word_page_numbers @forum_writer_page_numbers.
  - *Vorlagenpflege.* Geänderte Formatvorlagen je Dokument übernehmen @forum_word_template_styles @writer_template_styles.
  - *UI Clutter* die UIs sind überladen mit Optionen
][
  #figure(caption: [@libreoffice_ui])[
    #image("/images/libre office toolbar.png", height: 65%)
  ]
]
//- *Preis.* Word für den Desktop gibt es etwa mit Office Home 2024 für einmalig 149 € oder mit Microsoft 365 Single für regulär 99 € pro Jahr @word_pricing.
//- *Webversion.* Word im Browser ist kostenlos. Wer Abschnittsumbrüche oder ein automatisches Literaturverzeichnis einfügen will, braucht die Desktop-App @word_web_features.
//- *Seitenzahlen ab Kapitel 1.* Abschnittsumbruch einfügen, Fußzeile vom vorigen Abschnitt trennen und die Nummerierung bei 1 starten
//- *Ausfüllbare Vorlagen.* Für Eingabefelder in einer `.dotx` unter Windows erst die Entwicklertools einblenden (Datei → Optionen → Menüband anpassen)

== Gibt es nicht schon LaTeX?
#grid(
  columns: (4fr, 3fr),
  column-gutter: 2cm, 
  [
    *Donald Knuth 1977: Textsatzsystem TeX* @wiki:TeX

      - Formatierung von Texten für die Anzeige, Druck, oder Veröffentlichung
      - Makrosprache _TeX_

    #v(1em)
    *Leslie Lamport 1984: LaTeX* @wiki:LaTeX

      - Sammlung an TeX-Makros um die Nutzung von TeX zu vereinfachen
      - sehr beliebt für wissenschafltiche Arbeiten mit großem Seitenumfang und strengen typografischen Anforderungen
  ],
  {
    block(stroke: 0.3pt, inset: 5mm, radius: 2mm, width: 100%)[
      ```tex
      \documentclass{article}
      \begin{document}
      Die Sigmoidfunktion ist eine Aktivierungsfunktion 
      für neuronale Netzwerke: 
      \[\sigma(z) = \frac{1}{1 + e^{-z}}\]
      \end{document}
      ```
    ]
    text(size: 14pt)[#h(1fr) #sym.arrow.b.double #h(1fr)]
    block(stroke: 0.3pt, inset: 5mm, radius: 2mm, width: 100%)[
      #image("images/latex_demo.png")
    ]
  }
)

#hidden_heading[Gibt es nicht schon LaTeX?]
#grid(
  columns: (1fr, 1fr),
  column-gutter: 2cm
)[
  - automatisches Spacing, Silbentrennung, Seitenanordnung 
  - einfache Eingabe von mathematischen Gleichungen und Formelzeichen
  - robuste Zählungen, Referenzen und Literaturverweise
  - Quelldateien in Klartext $->$ einfache Versionsverwaltung und Kollaboration
  - Stabilität auf großen Dokumenten
  - tausende Pakete 
  - kostenlos & open-source @latex_project
][
  #plot(
    width: 9cm,
    height: 8cm,
    xmin: 0, xmax: 1,
    ymin: 0, ymax: 1,
    xlabel: [Komplexität und Größe des Dokuments],
    xlabel-anchor: 0,
    xlabel-offset: (ox: -6.4, oy: -0.2),
    ylabel: [Mühe & Zeit],
    show-grid: none,
    xtick-labels: none,
    ytick-labels: none,
    show-origin: false,
    (fn: x => calc.pow(x, 2) / 1.7 + 0.25, stroke: blue + 1.5pt, label: [LaTeX], label-pos: 0.75, label-side: "below-right"),
    (fn: x => calc.pow(1.7 * x, 2) + 0.04, stroke: red + 1.5pt, label: [MS Word], label-pos: 0.5, label-side: "east"),
  )
]

#hidden_heading[LaTeX-Distributionen]
*Aktiv gepflegt*
- *TeX Live* für Linux, macOS und Windows
- *MiKTeX* mit automatischer Nachinstallation fehlender Pakete
- *MacTeX* mit TeX Live und macOS-Programmen wie TeXShop
- *TinyTeX* als kompakte TeX-Live-Installation, etwa für Quarto
- *BasicTeX* als kompakte TeX-Live-Installation für macOS

*Historisch* \
proTeXt, teTeX, W32TeX, gwTeX, OzTeX, fpTeX, emTeX, AmigaTeX, PasTeX

[Inset grosses Fragezeichen weil wft warum so viele meinungen das sollte doch möglichst einfach zu nutzen sein????]

#hidden_heading[]
#let comparison-height = if theme == "tud" { 72mm } else { 100% }
#place(top + left, dy: if theme == "tud" { 0mm } else { -10mm })[
  #grid(
    columns: (1fr, 1fr),
    align: center,
  )[
    #block(stroke: 1pt)[
      #image("comparison/latex.pdf", height: comparison-height)
    ]
  ][
    #block(stroke: 1pt)[
      #image("comparison/typst.pdf", height: comparison-height)
    ]
  ]
]
#hidden_heading[]
#let comparison-height = if theme == "tud" { 72mm } else { 100% }
#place(top + left, dy: if theme == "tud" { 0mm } else { -10mm })[
  #grid(
    columns: (1fr, 1fr),
    align: center,
  )[
    #block(stroke: 1pt)[
      #image("comparison/latex.pdf", height: comparison-height)
    ]
  ][
    #block(stroke: 1pt)[
      #image("comparison/typst.pdf", height: comparison-height)
    ]
  ]
]
#place(center + horizon)[#text(size: 50pt)[Was ist was?]]
#hidden_heading[]
#let comparison-height = if theme == "tud" { 72mm } else { 100% }
#place(top + left, dy: if theme == "tud" { 0mm } else { -10mm })[
  #grid(
    columns: (1fr, 1fr),
    align: center,
  )[
    #block(stroke: 1pt)[
      #image("comparison/latex.pdf", height: comparison-height)
    ]
  ][
    #block(stroke: 1pt + green)[
      #image("comparison/typst.pdf", height: comparison-height)
    ]
  ]
]

#hidden_heading[Drei Aufgaben, eine Dateiendung]
#grid(
  columns: (5fr, 6fr),
  column-gutter: 1.75em,
  [
    #text(size: 1.25em, weight: "bold")[LaTeX]
    #v(0.4375em)
    #line(length: 100%, stroke: 0.0625em + accent)
    #v(0.625em)
    #grid(
      columns: (4em, 1fr),
      row-gutter: 0.875em,
      align: left + horizon,
      text(size: 1.5em)[`.tex`], [Dokument],
      text(size: 1.5em)[`.cls`], [Dokumentklasse, z. B. `scrartcl`],
      text(size: 1.5em)[`.sty`], [Paket für eigene Befehle],
    )
  ],
  [
    #text(size: 1.25em, weight: "bold")[Typst]
    #v(0.4375em)
    #line(length: 100%, stroke: 0.0625em + accent)
    #v(0.625em)
    #text(size: 2.5em, fill: accent)[`.typ`]

    Vorlage und Hilfsfunktionen in derselben Datei.

    ```typ
    #import "tubaf_template.typ" as tubaf
    #show: tubaf.presentation
    #tubaf.tip(lang: "de")[Ein Hinweis]
    ```

  ],
)


== Vorstellung Typst
#grid(
  columns: (4fr, 3fr),
  column-gutter: 2cm
)[
*Laurenz Mädje und Martin Haug:* @wiki:Typst

- ab 2019 Entwicklung von Typst im Rahmen ihrer Masterarbeit an der TU Berlin
- Markup-basiertes Textsatzsystem zum Schreiben und Formatieren wissenschaftlicher Texte
- #link("https://github.com/typst/typst")[Compiler] geschrieben in Rust 
  - seit 2023 open-source
  - schnelles, inkrementelles Kompilieren
- seit 2023 weiterentwickelt durch Typst GmbH
  - Hauptprodukt ist die WEB-IDE #link("https://typst.app/")[_\"Typst App\"_] (Freemium)
][#{
      block(stroke: 0.3pt, inset: 5mm, radius: 2mm, width: 100%)[
      ```typst
      #set page(paper: "a4")
      #set text(size: 14pt)
      Die Sigmoidfunktion ist eine Aktivierungsfunktion für neuronale Netzwerke:
      $ sigma(z) = 1 / (1 + e^(-z)) $
      ```
    ]
    text(size: 14pt)[#h(1fr) #sym.arrow.b.double #h(1fr)]
    block(stroke: 0.3pt, inset: 5mm, radius: 2mm, width: 100%)[
      #image("images/latex_demo.png")
    ]
}]


== Wie kann ich jetzt Typst benutzen? -- Lokale Installation
- Anzahl an verschiedenen Installationen
- Installationsgröße
- Pakete
- Befehle
- Tinymist VSCode Extension


== Performance
- compile Beispiel an Bachelorarbeit
- compile Beispiel an Praktikumsbericht


== Syntax
- leichteres Markdown
- fühlt sich für Programmierer vertraulicher an
- text is text und alles was mit mutieren zutun hat ist eine funktion wie man es vom programmieren

Konkret:
- Content mode
- Code mode
- Math mode

== Limits

- das tyeing system ist noch sehr ausbaufähig

== Figuren -- Referenzen -- tolle Pakete


== Vorlagen
#hidden_heading[TUD]
https://github.com/ShadowPaint-SP/TUD-typst-template.git
#hidden_heading[TUBAF]
https://github.com/DM-3/TUBAF_typst_template


== Kollaboration / Versionierung
- overleaf $->$ typst universum
- github
- durch git hat man ein mächtiges versionierungssystem und kann änderungen günstig zurücksetzen ohne etwas zu verlieren.


== Typst mit KI

mit typst:
1357 Tokens @KI:tokenizer -> fast 40% weniger tokens (und auch 2000 character weniger)

mit latex:
2191 Tokens @KI:tokenizer -> ugf 60% mehr tokens als typst


== Zusammenfassung
#plot(
  width: 9cm,
  height: 8cm,
  xmin: 0, xmax: 1,
  ymin: 0, ymax: 1,
  xlabel: [Komplexität und Größe des Dokuments],
  xlabel-anchor: 0,
  xlabel-offset: (ox: -6.4, oy: -0.2),
  ylabel: [Mühe & Zeit],
  show-grid: none,
  xtick-labels: none,
  ytick-labels: none,
  show-origin: false,
  (fn: x => calc.pow(x, 2) / 3.1 + 0.17, stroke: green + 1.5pt, label: image("images/Typst.svg.webp", height: 7mm), label-pos: 0.75, label-side: "below-right"),
  (fn: x => calc.pow(x, 2) / 1.7 + 0.25, stroke: blue + 1.5pt, label: [LaTeX], label-pos: 0.75, label-side: "below-right"),
  (fn: x => calc.pow(1.7 * x, 2) + 0.04, stroke: red + 1.5pt, label: [MS Word], label-pos: 0.5, label-side: "east"),
)


#{
  set heading(outlined: false)
  show heading.where(level: 1): it => heading(level: 2, it.body, outlined: true)
  set text(size: 11pt)
  bibliography("references.bib", title: "Quellen")
}

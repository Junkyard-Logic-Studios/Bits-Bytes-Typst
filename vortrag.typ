#import "TUBAF_typst_template/tubaf_template.typ" as tubaf

#show: tubaf.presentation.with(
  title: [Typst -- eine moderne Alternative zu LaTeX],
  subtitle: "Bits & Bytes",
  author: "Richard & Martin",
  bottom-text: [Richard Voigtmann\ Martin Werner],
  lang: "de",
)
#show figure.caption: it => text(size: 9pt)[*#it.supplement #it.counter.display()#it.separator* #it.body]

#outline(depth: 1)



= Was ist das Problem?
- Wir wollen Textdokumente erstellen (Bachelorarbeit und co...)
- Word ist doof
  -> Latex?


= Gibt es nicht schon LaTeX?
#grid(
  columns: (4fr, 3fr),
  [
    Geschichte:
    - TeX https://de.wikipedia.org/wiki/TeX
    - LaTeX https://de.wikipedia.org/wiki/LaTeX

    Nutzung:
    - lokale Installation, MiKTeX, TeXLive, MacTeX
    - Overleaf

    -> LaTeX ist alt und hat einige Schwierigkeiten
  ],
  figure(
    image("images/LaTeX-Word-Graph.svg"),
    caption: [LaTeX vs Office X; Mühe und Zeitbeanspruchung aufgetragen gegen Komplexität und Größe des Dokuments (Autor: Matthias M. https://commons.wikimedia.org/wiki/File:LaTeX-Word-Graph.svg)],
  ),
)

== LaTeX-Distributionen
*Aktiv gepflegt*
- *TeX Live* für Linux, macOS und Windows
- *MiKTeX* mit automatischer Nachinstallation fehlender Pakete
- *MacTeX* mit TeX Live und macOS-Programmen wie TeXShop
- *TinyTeX* als kompakte TeX-Live-Installation, etwa für Quarto
- *BasicTeX* als kompakte TeX-Live-Installation für macOS

*Historisch* \
proTeXt, teTeX, W32TeX, gwTeX, OzTeX, fpTeX, emTeX, AmigaTeX, PasTeX

[Inset grosses Fragezeichen weil wft warum so viele meinungen das sollte doch möglichst einfach zu nutzen sein????]

== Typst vs. LaTeX
#place(top + left, dy: 12mm)[
  #grid(
    columns: (0.6fr, 1fr, 1fr),
    fill: color.white,
  )[

  ][
    #block(stroke: 1pt)[
      #image("comparison/latex.pdf", height: 92%)
    ]
  ][
    #block(stroke: 1pt)[
      #image("comparison/typst.pdf", height: 92%)
    ]
  ]
]


== Drei Aufgaben, eine Dateiendung
#grid(
  columns: (5fr, 6fr),
  column-gutter: 28pt,
  [
    #text(size: 20pt, weight: "bold")[LaTeX]
    #v(7pt)
    #line(length: 100%, stroke: 1pt + tubaf.colors.Dunkelblau)
    #v(10pt)
    #grid(
      columns: (64pt, 1fr),
      row-gutter: 14pt,
      align: left + horizon,
      text(size: 24pt)[`.tex`], [Dokument],
      text(size: 24pt)[`.cls`], [Dokumentklasse, z. B. `scrartcl`],
      text(size: 24pt)[`.sty`], [Paket für eigene Befehle],
    )
  ],
  [
    #text(size: 20pt, weight: "bold")[Typst]
    #v(7pt)
    #line(length: 100%, stroke: 1pt + tubaf.colors.Dunkelblau)
    #v(10pt)
    #text(size: 40pt, fill: tubaf.colors.Dunkelblau)[`.typ`]

    Vorlage und Hilfsfunktionen in derselben Datei.

    #block(width: 100%, inset: 12pt, fill: tubaf.colors.Uniblau.lighten(94%))[
      #show raw: set text(size: 14pt)
      ```typ
      #import "tubaf_template.typ" as tubaf
      #show: tubaf.presentation
      #tubaf.tip(lang: "de")[Ein Hinweis]
      ```
    ]
  ],
)


= Vorstellung Typst
ganz kurz Geschichte

https://de.wikipedia.org/wiki/Typst

- entwickelt von...
- die machen ihr Geld mit der online Version (Freemium)


= Wie kann ich jetzt Typst benutzen? -- Lokale Installation
- Anzahl an verschiedenen Installationen
- Installationsgröße
- Pakete
- Befehle
- Tinymist VSCode Extension


= Performance
- compile Beispiel an Bachelorarbeit
- compile Beispiel an Praktikumsbericht


= Syntax
- leichteres Markdown
- fühlt sich für Programmierer vertraulicher an

Konkret:
- Content mode
- Code mode
- Math mode



= Figuren -- Referenzen -- tolle Pakete


= Vorlagen
== TUD
https://github.com/ShadowPaint-SP/TUD-typst-template.git
== TUBAF
https://github.com/DM-3/TUBAF_typst_template


= Kollaboration / Versionierung
- overleaf $->$ typst universum
- github
- durch git hat man ein mächtiges versionierungssystem und kann änderungen günstig zurücksetzen ohne etwas zu verlieren.


= Typst mit KI

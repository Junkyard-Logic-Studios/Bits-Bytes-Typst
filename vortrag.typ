#import "TUBAF_typst_template/tubaf_template.typ" as tubaf

// #let theme = "tubaf" 
#let theme = "tud"
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
  tud.tud-deck(title: talk-title, author: speakers, lang: "de")[
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
- Wir wollen Textdokumente erstellen (Bachelorarbeit und co...)
- Word ist doof
  -> Latex?


== Gibt es nicht schon LaTeX?
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
ganz kurz Geschichte

https://de.wikipedia.org/wiki/Typst

- entwickelt von...
- die machen ihr Geld mit der online Version (Freemium)


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

Konkret:
- Content mode
- Code mode
- Math mode



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
1357 Tokens -> fast 40% weniger tokens (und auch 2000 character weniger)

mit latex:
2191 Tokens -> ugf 60% mehr tokens als typst

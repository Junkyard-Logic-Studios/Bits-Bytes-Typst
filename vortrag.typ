#import "TUBAF_typst_template/tubaf_template.typ" as tubaf

//#let theme = "tubaf"
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

// Each frame adds one comment. Keep positions fixed so the earlier comments stay put.
#let word-comments = (
  (file: "word_lizenz.png", x: 1em, y: 7em, width: 100%, angle: 10deg),
  (file: "Wordhate/image.png", x: 16em, y: 12.4em, width: 28em, angle: -6deg),
  (file: "Wordhate/image copy.png", x: 1em, y: 11em, width: 12.6em, angle: 8deg),
  (file: "Wordhate/image copy 2.png", x: 2.2em, y: 16.4em, width: 29.3em, angle: 4deg),
  (file: "Wordhate/image copy 3.png", x: 13.2em, y: 7.8em, width: 31em, angle: -4.5deg),
  (file: "Wordhate/image copy 4.png", x: 1.6em, y: 3.5em, width: 33em, angle: 3deg),
  (file: "Wordhate/image copy 5.png", x: 12.7em, y: 19.5em, width: 27em, angle: -3deg),
)
#for count in range(1, word-comments.len() + 1) {
  if theme == "tud" { pagebreak() } else { hidden_heading[Wo Word umständlich wird] }
  word-critique
  for comment in word-comments.slice(0, count) {
    place(top + left, dx: comment.x, dy: comment.y, rotate(
      comment.angle,
      image("images/" + comment.file, width: comment.width),
    ))
  }
  place(bottom + right)[#text(size: 7pt)[@reddit:word_hate_1,@reddit:word_hate_2,@word_lizenz]]
}
#hidden_heading([Word und seine Spin-offs])

- *Preis.* Word für den Desktop gibt es etwa mit Office Home 2024 für einmalig 149 € oder mit Microsoft 365 Single für regulär 99 € pro Jahr @word_pricing.
- *Webversion.* Word im Browser ist kostenlos. Wer Abschnittsumbrüche oder ein automatisches Literaturverzeichnis einfügen will, braucht die Desktop-App @word_web_features.
- *Seitenzahlen ab Kapitel 1.* Abschnittsumbruch einfügen, Fußzeile vom vorigen Abschnitt trennen und die Nummerierung bei 1 starten @word_page_numbering.
- *Ausfüllbare Vorlagen.* Für Eingabefelder in einer `.dotx` unter Windows erst die Entwicklertools einblenden (Datei → Optionen → Menüband anpassen) @word_templates.


== Gibt es nicht schon LaTeX?
#grid(
  columns: (4fr, 3fr),
  [
    Geschichte:
    - TeX @wiki:TeX
    - LaTeX @wiki:LaTeX

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

#{
  set heading(outlined: false)
  show heading.where(level: 1): it => heading(level: 2, it.body, outlined: true)
  bibliography("references.bib", title: "Quellen")
}

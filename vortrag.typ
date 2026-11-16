#import "TUBAF_typst_template/tubaf_template.typ" as tubaf

#show: tubaf.presentation.with(
  title: [Typst -- eine moderne Alternative zu LaTeX],
  subtitle: "Bits & Bytes",
  author: "Richard & Martin",
  bottom-text: [Richard Voigtmann\ Martin Werner],
  lang: "de",
)
#show figure.caption: it => text(size: 9pt)[*#it.supplement #it.counter.display()#it.separator* #it.body]

#outline()

= Was ist das Problem?


= Gibt es nicht schon LaTeX?
#grid(
  columns: (4fr, 3fr),
  [],
  figure(
    image("images/LaTeX-Word-Graph.svg"),
    caption: [LaTeX vs Office X; Mühe und Zeitbeanspruchung aufgetragen gegen Komplexität und Größe des Dokuments (Autor: Matthias M. https://commons.wikimedia.org/wiki/File:LaTeX-Word-Graph.svg)]
  )
)

= Wie kann ich jetzt Typst benutzen? -- Lokale Installation
- Anzahl an verschiedenen Installationen
- Installationsgröße
- Pakete
- Befehle
- Tinymist VSCode Extension

= Performance
- compile Beispiel an Bachelorarbeit
- compile Beispiel an Praktikumsbericht

= Syntax -- Scripting

= Figuren -- Referenzen

= Vorlagen
== TUD
https://github.com/ShadowPaint-SP/TUD-typst-template.git
== TUBAF
https://github.com/DM-3/TUBAF_typst_template

= Kollaboration
- overleaf <-> typst universum
- github

= Typst mit KI

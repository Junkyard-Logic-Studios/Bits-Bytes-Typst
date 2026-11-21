#let accent = rgb("#194f54")
#let code-background = rgb("#f2f5f5")
#let argmin = math.op("arg min", limits: true)

#set page(paper: "a4", margin: (x: 21mm, top: 23mm, bottom: 22mm))
#set document(title: "Ridge regression")
#set text(
  font: ("CMU Serif", "New Computer Modern"),
  size: 10.5pt,
  hyphenate: false,
  top-edge: 0.8em,
  bottom-edge: -0.2em,
)
#set par(leading: 3.5pt, spacing: 7pt)
#set enum(spacing: 2pt)
#set list(body-indent: 8pt)
#set math.equation(numbering: "(1)")
#show math.equation.where(block: true): set block(above: 24pt, below: 12pt)

#show heading: set text(size: 13pt, fill: accent)
#show heading: set block(above: 22pt, below: 11pt)
#show footnote.entry: set text(size: 8.5pt)
#set footnote.entry(separator: line(length: 32mm, stroke: 0.5pt), gap: 3pt)

#show raw: set text(font: "CMU Typewriter Text", size: 8.5pt)
#show raw.where(block: true): set par(leading: 3pt)
#show raw.where(block: true): it => block(
  width: 100%,
  fill: code-background,
  inset: 7pt,
  spacing: 7pt,
  below: 30pt,
  it,
)

#text(size: 29pt, weight: "bold")[Ridge regression]
#v(3pt)
#text(size: 12pt, fill: accent)[A worked example with two correlated predictors]
#v(9pt)
#line(length: 100%, stroke: 0.7pt + accent)
#v(14pt)

#columns(2, gutter: 9mm)[
  = The problem

  Two predictors can carry almost the same information. Ordinary least squares
  can then assign them large coefficients of opposite signs. The predictions can
  stay nearly the same even as the coefficients swing.

  Ridge regression adds a penalty for large coefficients. Hoerl and Kennard
  introduced the estimator @hoerl-estimator and illustrated its behavior with
  examples @hoerl-applications.

  = The estimator

  Let $X$ be the $n$-by-$p$ matrix of predictors and $y$ the response vector.
  Take the columns and the response to be centered.#footnote[
    Centering puts the intercept at zero, so the penalty applies only to the
    slopes.
  ] For a penalty strength $lambda >= 0$, the ridge estimate is

  $
    hat(beta)_lambda & = argmin_(beta in RR^p)
                       [norm(y - X beta)_2^2 + lambda norm(beta)_2^2] \
                     & = (X^top X + lambda I_p)^(-1) X^top y.
  $ <ridge>

  For $lambda > 0$, the added diagonal makes the matrix invertible even if
  two columns of $X$ are identical. At $lambda = 0$, the inverse requires
  full column rank.

  = Fitting the model

  + Center the predictors and the response.
  + Pick a penalty strength $lambda$.
  + Solve the system in @ridge.

  = Reading the fit

  The first row of the table shows how a perfect fit can hide large slopes.
  Consider the observation where both predictors are $2$.

  - At $lambda = 0$, the slopes nearly cancel. The fitted value is
    $2 (-15.50 + 17.00) = 3.00$.
  - At $lambda = 1$, both slopes are below one. The fitted value drops to
    about $2.26$.

  #colbreak()

  = Computing the solution

  The code uses a linear solve to evaluate @ridge without forming a matrix
  inverse. The two columns of $X$ differ by just $0.1$ in two of the four rows.

  ```python
  import numpy as np

  def ridge(X, y, lam):
      gram = X.T @ X
      identity = np.eye(X.shape[1])
      return np.linalg.solve(
          gram + lam * identity, X.T @ y
      )

  X = np.array([[1, .9], [2, 2],
                [-1, -.9], [-2, -2]])
  y = np.array([-.2, 3, .2, -3])

  print(ridge(X, y, lam=1))
  ```

  = What changes

  The table reports both slopes and the root mean square error (RMSE) on the
  same four observations used to fit the model.#footnote[
    Training RMSE measures fit on these four rows. Choose the penalty using
    validation data when the goal is prediction.
  ]

  #table(
    columns: (1fr, 1fr, 1fr, 1fr),
    align: (left, right, right, right),
    inset: (x: 0pt, y: 3pt),
    stroke: none,
    table.hline(stroke: 0.8pt + accent),
    table.header([$lambda$], [$hat(beta)_1$], [$hat(beta)_2$], [*RMSE*]),
    table.hline(stroke: 0.4pt + accent),
    [0.00], [−15.50], [17.00], [0.00],
    [0.01], [−6.63], [7.96], [0.57],
    [0.10], [−0.62], [1.82], [0.96],
    [1.00], [0.44], [0.69], [1.03],
    table.hline(stroke: 0.8pt + accent),
  )

  = References

  #text(size: 9pt)[
    #bibliography("references.bib", title: none, style: "ieee")
  ]
]

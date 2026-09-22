# Formalization Working Memo: The Race Between Machine and Man: Implications of Technology for Growth, Factor Shares and Employment

This is a working lead log, not audit evidence and not a final validation
report. Record possible issues while reading and proving; independently verify
each retained item against the pinned source and final Lean surface during
closeout.

For every item, record the exact source location, current mathematical reading,
Lean treatment, and review state. Prefer “clarification” unless the printed
formula or statement is actually false.

## Possible Source Clarifications

- `source.txt:1267-1269`: Proposition 4 says "if only if"; the mathematical
  reading is "if and only if".  This does not affect the present partial core.
- Bars, tildes, and underlines are lost in several plaintext displays.  Formula
  checks therefore use the rendered pinned PDF, especially for Propositions
  2, 3, 6, 8, and 9.

## Possible Printed Typos Or Errors

- `source.txt:498-504`: Assumption 3's capital threshold is corrupted in the
  extraction and cannot be reconstructed exactly from the plaintext alone.
- `source.txt:2185-2187` and `source.txt:7129-7132`: Propositions 9 and B2 print
  `I* = I > I-tilde`, although `I* = min {I, I-tilde}`.  The surrounding model
  and the rendered comparative-statics regime require `I* = I < I-tilde`.
- `source.txt:5364-5369`: a displayed Proposition B1 special-case derivative
  has the opposite sign from the proposition, Lemma A1, and Proposition 2.
- `source.txt:7627-7638`: Proposition B3 appears to cite Assumption 1'' where
  the immediately relevant condition is Assumption 2'', and it reuses market
  clearing equations that the preceding alternative model says are modified.

## Possible Proof-Strategy Deviations

- The Lean development proves algebraic sign/decomposition facts and scalar
  monotone-crossing arguments directly.  It does not reproduce the paper's
  differential-equation stability proofs.
- The scalar `CrossesFromBelowAt` predicate is a transparent order-theoretic
  proxy for the sign pattern around a BGP root.  It is not identified with
  saddle-path or asymptotic stability of the full dynamic equilibrium.

## Possible Model Conventions Or Extra Assumptions

- No unproved paper theorem is installed as a Lean assumption.  Monotonicity
  hypotheses on reduced-form value gaps and effective wages are explicit in
  the partial Specs and mark the unformalized bridge from the source model.

## Deferred Formalization Or Library Work

- Derive the static threshold equilibrium and Proposition 2 derivatives from
  the continuum-task price index and labor-supply equations.
- Formalize the net-output function, capital accumulation, normalized value
  functions, and the BGP ODE system needed for Propositions 4--8.
- Build a reusable one-dimensional equilibrium-stability layer: the pinned
  Mathlib checkout supplies ODE existence/uniqueness but no ready deterministic
  asymptotic-stability API.
- Formalize the heterogeneous-skill, creative-destruction, planner, and
  quasi-labor-supply extensions, including the corrected Proposition 9 regime.

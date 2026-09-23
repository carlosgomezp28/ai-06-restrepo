import AR18RaceManMachine.MainTheorems
import AR18RaceManMachine.Assumptions

/-!
# Human-Facing Paper Interface: The Race Between Machine and Man: Implications of Technology for Growth, Factor Shares and Employment

This is the compact Lean file a human should read after formalization to check
whether the paper's definitions and named theorem statements were represented
correctly. Keep the row-level dashboard and LLM audit statements in this file
for every paper. Move implementation details, proof aliases, and bulky helper
lemmas behind imported modules such as `AuditInterface.lean`, but expose the
audited paper-facing statements directly here; do not use
`paper_interface.audit_surface_path`.

Rules for completing this file:

- Keep the paper's definitions/formatted objects first, in source order.
- Expose the actual paper formulas here; do not only point to generic library
  definitions or implementation witnesses.
- A material reusable `AppliedModelingLib` primitive may remain a reference here only
  after `audit/library_semantic_review.json` records its exact bounded library
  declaration and an explicit byte-pinned paper-source connection. The
  dashboard and human-review packet show and source-check that declaration
  before the dependent Spec; a library name, docstring, or glossary is not a
  semantic bridge. Do not add a duplicate paper claim merely to restate it.
- If a named theorem needs a hypothesis that is not derived from earlier Lean
  declarations, declare that hypothesis in `Assumptions.lean` and list it in
  `status.json` `review_surface.assumption_names`.
- Then state the named results directly, with assumptions visible in each
  theorem signature by referencing named paper assumptions imported from
  `Assumptions.lean`.
- In the statement-first phase, write every complete source-facing statement as
  a transparent `<name>Spec : Prop` here, exactly once. Put the paired
  theorem/lemma of that exact type in `ProofInterface.lean`; its temporary
  proof body may be `by sorry` only in a private draft. This separation keeps
  the human semantic surface free of thin wrapper declarations.
- Before drafting that Lean surface, independently inventory every material
  source atom from exact pinned source quote bytes. Do not infer source atoms
  from declaration, binder, field, function, or source-map names.
- Run raw-source-to-expanded-Spec statement matching plus Lean-emitted
  premise/conclusion claim-atom review on the skeleton. The semantic comparison uses
  only byte-pinned source quotes (and separately pinned source context) against
  the expanded transparent Spec; map summaries and proof wrappers are not
  semantic inputs. Then freeze each canonical Lean declaration-manifest digest.
- In the proof phase, replace the `ProofInterface.lean` `sorry` with a short
  proof that calls into `MainTheorems.lean` or lower proof files without
  changing the specification or theorem type. Any specification/type change
  invalidates the freeze and requires a fresh statement audit.
- At formalized closeout, complete the v11 realization receipt: Lean Meta checks
  the theorem has exactly the transparent Spec type; each source atom is bound
  to the elaborated Spec surface; closure traversal includes proof and instance
  arguments; and every material terminal has a source, approved correction or
  additional assumption, checked derivation, or version-pinned foundation
  disposition. No data, container, or identifier-based exemption is allowed.
- The transparent `...Spec` is the sole semantic-review target for its source
  claim. The paired theorem/lemma is a proof endpoint whose exact Spec type is
  verified by Lean Meta, not a duplicate source-to-Lean comparison row.
- Keep proof endpoints, exhaustive endpoint aliases, and proof-seam checks in
  `ProofInterface.lean`, implementation modules, or `ProofLedger.lean`, not
  here. Do not create new `PostPaperAudit.lean` or `AuditLedger.lean` files;
  those names are legacy.

## Partial formalization boundary

The source paper has nineteen named results.  The specifications below expose
the algebraic and order-theoretic cores currently checked in Lean: the static
comparative-statics signs and decompositions, monotonicity and balanced-growth
crossing arguments, and the welfare sign decomposition.  They do not claim to
derive those reduced-form objects from the paper's continuum-task equilibrium,
capital-accumulation system, or innovation-value differential equations.

Consequently every row is a *partial* source component, not an exact endpoint
for a complete named proposition.  The missing analytic bridge is stated here
rather than hidden behind an assumed theorem or certificate.
-/

namespace AR18RaceManMachine

/-! ## Corollary 1: Cobb--Douglas task-share accounting -/

/-- The two task exponents in Corollary 1 add to one.  This checks the
constant-returns accounting inside the displayed Cobb--Douglas formula, not
the equilibrium derivation of that formula. -/
def corollary1_task_share_accountingSpec : Prop :=
  ∀ N equilibriumAutomation : ℝ,
    capitalTaskExponent N equilibriumAutomation +
      laborTaskExponent N equilibriumAutomation = 1

/-! ## Proposition 2: comparative-statics formula cores -/

/-- Sign consequences of Proposition 2's three technology-constrained
comparative-statics formulas.  The definitions in `Model.lean` are the displayed
right-hand sides; differentiating the full equilibrium system to obtain those
right-hand sides is outside the present boundary. -/
def proposition2_constrained_signsSpec : Prop :=
  ∀ sigmaHat laborSupplyElasticity lambdaI lambdaN : ℝ,
    0 < sigmaHat →
    0 < laborSupplyElasticity →
    0 < lambdaI →
    0 < lambdaN →
      constrainedAutomationRelativePriceChange
          sigmaHat laborSupplyElasticity lambdaI < 0 ∧
      0 < constrainedNewTaskRelativePriceChange
          sigmaHat laborSupplyElasticity lambdaN ∧
      0 < constrainedCapitalRelativePriceElasticity
          sigmaHat laborSupplyElasticity

/-- Proposition 2's technology-free substitution elasticity is strictly larger
than the technology-constrained elasticity when both source semi-elasticities
are positive. -/
def proposition2_technology_free_elasticitySpec : Prop :=
  ∀ sigmaHat comparativeAdvantageSemiElasticity lambdaI : ℝ,
    0 < comparativeAdvantageSemiElasticity →
    0 < lambdaI →
      sigmaHat < technologyFreeElasticity
        sigmaHat comparativeAdvantageSemiElasticity lambdaI

/-! ## Proposition 3: productivity and factor-price decomposition -/

/-- Algebraic core of Proposition 3.  A positive CES scale times a positive
effective-cost saving is positive, and the wage and rental-rate changes split
into the paper's productivity and relative-price terms. -/
def proposition3_productivity_factor_price_coreSpec : Prop :=
  ∀ scale expensive cheap productivity laborShare relativePriceChange : ℝ,
    0 < scale →
    cheap < expensive →
      0 < productivityContribution scale expensive cheap ∧
      wageChangeDecomposition productivity laborShare relativePriceChange =
        productivity + (1 - laborShare) * relativePriceChange ∧
      rentalChangeDecomposition productivity laborShare relativePriceChange =
        productivity - laborShare * relativePriceChange

/-! ## Lemma A1: affine monotonicity core -/

/-- The affine monotonicity used by the relative-demand comparative statics in
Lemma A1.  The omitted bridge identifies the paper's implicit market-clearing
function with this reduced-form core. -/
def lemmaA1_affine_relative_demand_coreSpec : Prop :=
  ∀ a b : ℝ,
    0 < a →
    0 < b →
    ∀ base : ℝ,
      StrictAnti (fun threshold : ℝ => base - a * threshold) ∧
      StrictMono (fun newTasks : ℝ => base + b * newTasks)

/-! ## Propositions 4 and 6: balanced-growth crossing core -/

/-- A strictly increasing innovation-value gap with one interior zero has one
and only one interior zero and crosses it from below.  This is the scalar
crossing part of the BGP uniqueness/stability argument; it is not a
formalization of the paper's full ODE saddle-path stability proof. -/
def proposition6_unique_interior_crossing_coreSpec : Prop :=
  ∀ gap : ℝ → ℝ,
    ∀ lower root : ℝ,
      StrictMono gap →
      IsInteriorBGPCrossing gap lower root →
        (∃! n, IsInteriorBGPCrossing gap lower n) ∧
        CrossesFromBelowAt gap root

/-! ## Corollary 2: automation-productivity comparative statics -/

/-- Conditional crossing-shift core of Corollary 2.  Once the two BGPs are
represented by zeros of the displayed innovation-value gaps and the new gap is
strictly increasing, a permanent increase in automation productivity shifts
the crossing to a lower value of `n`. -/
def corollary2_automation_productivity_shift_coreSpec : Prop :=
  ∀ kappaI kappaI' kappaN : ℝ,
    ∀ vI vN : ℝ → ℝ,
      ∀ oldCrossing newCrossing : ℝ,
        kappaI < kappaI' →
        0 < vI oldCrossing →
        StrictMono (innovationValueGap kappaI' kappaN vI vN) →
        innovationValueGap kappaI kappaN vI vN oldCrossing = 0 →
        innovationValueGap kappaI' kappaN vI vN newCrossing = 0 →
          newCrossing < oldCrossing

/-! ## Propositions 5 and 7: effective-wage directions -/

/-- The monotone effective-wage comparison used in the long-run and
heterogeneous-skill extensions: increasing `n` raises the effective wage at the
automation margin and lowers it at the new-task margin. -/
def proposition5_effective_wage_direction_coreSpec : Prop :=
  ∀ wI wN : ℝ → ℝ,
    StrictMono wI →
    StrictAnti wN →
    ∀ n₁ n₂ : ℝ,
      n₁ < n₂ → wI n₁ < wI n₂ ∧ wN n₂ < wN n₁

/-! ## Proposition 8: creative-destruction instability core -/

/-- A strictly decreasing innovation-value gap cannot have the global
crossing-from-below property used by the paper's stability comparison. -/
def proposition8_no_stable_crossing_coreSpec : Prop :=
  ∀ gap : ℝ → ℝ,
    StrictAnti gap → ¬ ∃ root, CrossesFromBelowAt gap root

/-! ## Proposition 9 and Proposition B2: welfare sign core -/

/-- The welfare sign algebra isolated from the equilibrium/envelope
derivation: the baseline productivity term is positive, the new-task frictional
terms reinforce each other, and the automation frictional decomposition can
have either sign. -/
def proposition9_welfare_sign_coreSpec : Prop :=
  (∀ marginalUtility productivityEffect : ℝ,
      0 < marginalUtility →
      0 < productivityEffect →
        0 < baselineWelfareChange marginalUtility productivityEffect) ∧
  (∀ productivityGain employmentGain : ℝ,
      0 < productivityGain →
      0 ≤ employmentGain →
        0 < frictionalNewTaskWelfareChange productivityGain employmentGain) ∧
  frictionalAutomationWelfareChange 1 2 < 0 ∧
  0 < frictionalAutomationWelfareChange 2 1

end AR18RaceManMachine

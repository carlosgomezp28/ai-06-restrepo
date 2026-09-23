import Mathlib.Data.Real.Basic
import Mathlib.Order.Monotone.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum

/-!
# Source model fragments for Acemoglu--Restrepo (2018)

This module records the paper's algebraic comparative-statics quantities and
the order-theoretic crossing notions used by the partial formalization.  It is
deliberately paper-local: the definitions retain the notation and economic
roles of NBER Working Paper 22252 (revised June 2017).

The current formalization covers the qualitative algebra and crossing
arguments.  It does not yet derive these reduced-form quantities from the
paper's continuum task production economy or its differential system; that
analytic bridge is kept visible as the remaining partial-formalization
boundary.
-/

namespace AR18RaceManMachine

noncomputable section

/-! ## Static task shares and comparative statics -/

/-- Corollary 1's capital exponent, `1 - N + I*`. -/
def capitalTaskExponent (N equilibriumAutomation : ℝ) : ℝ :=
  1 - N + equilibriumAutomation

/-- Corollary 1's labor exponent, `N - I*`. -/
def laborTaskExponent (N equilibriumAutomation : ℝ) : ℝ :=
  N - equilibriumAutomation

/-- Proposition 2's technology-constrained automation effect on
`ln (W / R)` and on the normalized relative labor-demand variable. -/
def constrainedAutomationRelativePriceChange
    (sigmaHat laborSupplyElasticity lambdaI : ℝ) : ℝ :=
  -lambdaI / (sigmaHat + laborSupplyElasticity)

/-- Proposition 2's technology-constrained new-task effect on
`ln (W / R)` and on the normalized relative labor-demand variable. -/
def constrainedNewTaskRelativePriceChange
    (sigmaHat laborSupplyElasticity lambdaN : ℝ) : ℝ :=
  lambdaN / (sigmaHat + laborSupplyElasticity)

/-- Proposition 2's capital elasticity of `W / R` in the constrained regime. -/
def constrainedCapitalRelativePriceElasticity
    (sigmaHat laborSupplyElasticity : ℝ) : ℝ :=
  (1 + laborSupplyElasticity) / (sigmaHat + laborSupplyElasticity)

/-- The paper's technology-free elasticity of substitution,
`sigma_free = sigmaHat + Lambda_I / epsilon_gamma`. -/
def technologyFreeElasticity
    (sigmaHat comparativeAdvantageSemiElasticity lambdaI : ℝ) : ℝ :=
  sigmaHat + lambdaI / comparativeAdvantageSemiElasticity

/-- Proposition 3's generic cost-saving contribution.  In the full source
formula the `expensive` and `cheap` entries are the relevant powered unit costs
and `scale` is the positive CES coefficient. -/
def productivityContribution (scale expensive cheap : ℝ) : ℝ :=
  scale * (expensive - cheap)

/-- Proposition 3's wage-change decomposition into productivity and relative-
price terms. -/
def wageChangeDecomposition
    (productivity laborShare relativePriceChange : ℝ) : ℝ :=
  productivity + (1 - laborShare) * relativePriceChange

/-- Proposition 3's rental-rate-change decomposition. -/
def rentalChangeDecomposition
    (productivity laborShare relativePriceChange : ℝ) : ℝ :=
  productivity - laborShare * relativePriceChange

/-! ## Balanced-growth crossings -/

/-- The normalized innovation-value gap used in Proposition 6:
`kappa_I v_I(n) - kappa_N v_N(n)`. -/
def innovationValueGap
    (kappaI kappaN : ℝ) (vI vN : ℝ → ℝ) (n : ℝ) : ℝ :=
  kappaI * vI n - kappaN * vN n

/-- An interior balanced-growth crossing of the innovation-value curves. -/
def IsInteriorBGPCrossing
    (gap : ℝ → ℝ) (lower n : ℝ) : Prop :=
  lower < n ∧ n < 1 ∧ gap n = 0

/-- The global crossing-from-below property used as the paper-local formal
proxy for saddle-path stability in the creative-destruction comparison.  The
paper's actual local dynamical-system stability remains outside this predicate
and is an explicit analytic boundary. -/
def CrossesFromBelowAt (gap : ℝ → ℝ) (root : ℝ) : Prop :=
  (∀ x, x < root → gap x < 0) ∧ (∀ x, root < x → 0 < gap x)

/-! ## Welfare effects -/

/-- The no-friction envelope contribution in Proposition 9. -/
def baselineWelfareChange (marginalUtility productivityEffect : ℝ) : ℝ :=
  marginalUtility * productivityEffect

/-- Proposition 9's automation welfare decomposition under a binding
quasi-labor-supply constraint. -/
def frictionalAutomationWelfareChange
    (productivityGain employmentLoss : ℝ) : ℝ :=
  productivityGain - employmentLoss

/-- Proposition 9's new-task welfare decomposition under a binding
quasi-labor-supply constraint. -/
def frictionalNewTaskWelfareChange
    (productivityGain employmentGain : ℝ) : ℝ :=
  productivityGain + employmentGain

end

end AR18RaceManMachine

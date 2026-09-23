import AR18RaceManMachine.Model

/-!
# Paper-Facing Theorems: The Race Between Machine and Man: Implications of Technology for Growth, Factor Shares and Employment

This file is the implementation theorem layer for the source paper. Keep
source-faithful definitions and theorem wrappers here, and expose only the
compact human-review subset in `PaperInterface.lean`.

During the statement-first phase, each exact paper-facing proposition lives in a
transparent `<name>Spec : Prop` declaration in `PaperInterface.lean`; the paired
theorem/lemma endpoint belongs in `ProofInterface.lean` and has exactly that
type. Add proof implementations here only after those specifications pass v11
raw-source-to-expanded-Spec review and recursive premise provenance audit. Before full closeout, the v11
realization audit independently binds pinned source atoms to the elaborated Spec
and accounts for the complete Lean closure; a proof hole or a declaration name
is never evidence for that correspondence.
-/

namespace AR18RaceManMachine

/-! ## Corollary 1: Cobb--Douglas task-share accounting -/

theorem capitalTaskExponent_add_laborTaskExponent
    (N equilibriumAutomation : ℝ) :
    capitalTaskExponent N equilibriumAutomation +
        laborTaskExponent N equilibriumAutomation = 1 := by
  simp [capitalTaskExponent, laborTaskExponent]

/-! ## Proposition 2: comparative-statics signs -/

theorem constrainedAutomationRelativePriceChange_neg
    {sigmaHat laborSupplyElasticity lambdaI : ℝ}
    (hsigma : 0 < sigmaHat) (helasticity : 0 < laborSupplyElasticity)
    (hlambda : 0 < lambdaI) :
    constrainedAutomationRelativePriceChange
        sigmaHat laborSupplyElasticity lambdaI < 0 := by
  unfold constrainedAutomationRelativePriceChange
  exact div_neg_of_neg_of_pos (neg_neg_of_pos hlambda)
    (add_pos hsigma helasticity)

theorem constrainedNewTaskRelativePriceChange_pos
    {sigmaHat laborSupplyElasticity lambdaN : ℝ}
    (hsigma : 0 < sigmaHat) (helasticity : 0 < laborSupplyElasticity)
    (hlambda : 0 < lambdaN) :
    0 < constrainedNewTaskRelativePriceChange
        sigmaHat laborSupplyElasticity lambdaN := by
  unfold constrainedNewTaskRelativePriceChange
  exact div_pos hlambda (add_pos hsigma helasticity)

theorem constrainedCapitalRelativePriceElasticity_pos
    {sigmaHat laborSupplyElasticity : ℝ}
    (hsigma : 0 < sigmaHat) (helasticity : 0 < laborSupplyElasticity) :
    0 < constrainedCapitalRelativePriceElasticity
        sigmaHat laborSupplyElasticity := by
  unfold constrainedCapitalRelativePriceElasticity
  exact div_pos (by linarith) (add_pos hsigma helasticity)

theorem technologyFreeElasticity_gt_sigmaHat
    {sigmaHat comparativeAdvantageSemiElasticity lambdaI : ℝ}
    (helasticity : 0 < comparativeAdvantageSemiElasticity)
    (hlambda : 0 < lambdaI) :
    sigmaHat < technologyFreeElasticity
        sigmaHat comparativeAdvantageSemiElasticity lambdaI := by
  unfold technologyFreeElasticity
  have hquotient : 0 < lambdaI / comparativeAdvantageSemiElasticity :=
    div_pos hlambda helasticity
  linarith

/-! ## Proposition 3: productivity and factor-price decomposition -/

theorem productivityContribution_pos
    {scale expensive cheap : ℝ}
    (hscale : 0 < scale) (hcost : cheap < expensive) :
    0 < productivityContribution scale expensive cheap := by
  exact mul_pos hscale (sub_pos.mpr hcost)

theorem wageChangeDecomposition_eq
    (productivity laborShare relativePriceChange : ℝ) :
    wageChangeDecomposition productivity laborShare relativePriceChange =
      productivity + (1 - laborShare) * relativePriceChange := rfl

theorem rentalChangeDecomposition_eq
    (productivity laborShare relativePriceChange : ℝ) :
    rentalChangeDecomposition productivity laborShare relativePriceChange =
      productivity - laborShare * relativePriceChange := rfl

/-! ## Lemma A1: a checked affine relative-demand core -/

/-- The appendix's monotonic relative-demand argument, proved for the affine
core `base - a I* + b N`.  The remaining bridge from the paper's implicit
market-clearing equation to this core is recorded as a formalization gap. -/
theorem affineRelativeDemand_strictAnti_threshold_strictMono_newTasks
    {a b : ℝ} (ha : 0 < a) (hb : 0 < b) (base : ℝ) :
    StrictAnti (fun threshold : ℝ => base - a * threshold) ∧
      StrictMono (fun newTasks : ℝ => base + b * newTasks) := by
  constructor
  · intro x y hxy
    dsimp
    nlinarith
  · intro x y hxy
    dsimp
    nlinarith

/-! ## Lemma A2 / Propositions 1, 4, 6 and B3--B4: crossing core -/

theorem existsUnique_interiorBGPCrossing_of_strictMono
    {gap : ℝ → ℝ} {lower root : ℝ}
    (hmono : StrictMono gap)
    (hroot : IsInteriorBGPCrossing gap lower root) :
    ∃! n, IsInteriorBGPCrossing gap lower n := by
  refine ⟨root, hroot, ?_⟩
  intro n hn
  by_contra hne
  rcases lt_or_gt_of_ne hne with hlt | hgt
  · have hstrict := hmono hlt
    rw [hn.2.2, hroot.2.2] at hstrict
    exact (lt_irrefl 0 hstrict)
  · have hstrict := hmono hgt
    rw [hroot.2.2, hn.2.2] at hstrict
    exact (lt_irrefl 0 hstrict)

theorem strictMono_root_sign_characterization
    {gap : ℝ → ℝ} {root x : ℝ}
    (hmono : StrictMono gap) (hroot : gap root = 0) :
    (x < root → gap x < 0) ∧ (root < x → 0 < gap x) := by
  constructor
  · intro hx
    simpa [hroot] using hmono hx
  · intro hx
    simpa [hroot] using hmono hx

/-! ## Lemma A3 and Proposition 6: innovation-value monotonicity -/

theorem innovationValueGap_strictMono
    {kappaI kappaN : ℝ} {vI vN : ℝ → ℝ}
    (hkappaI : 0 < kappaI) (hkappaN : 0 < kappaN)
    (hvI : StrictMono vI) (hvN : StrictAnti vN) :
    StrictMono (innovationValueGap kappaI kappaN vI vN) := by
  intro x y hxy
  have hI := hvI hxy
  have hN := hvN hxy
  unfold innovationValueGap
  nlinarith

/-! ## Corollary 2: a permanent increase in automation productivity -/

theorem higherAutomationProductivity_lowers_crossing
    {kappaI kappaI' kappaN : ℝ} {vI vN : ℝ → ℝ}
    {oldCrossing newCrossing : ℝ}
    (hkappa : kappaI < kappaI')
    (hvIold : 0 < vI oldCrossing)
    (hnewMono : StrictMono (innovationValueGap kappaI' kappaN vI vN))
    (hold : innovationValueGap kappaI kappaN vI vN oldCrossing = 0)
    (hnew : innovationValueGap kappaI' kappaN vI vN newCrossing = 0) :
    newCrossing < oldCrossing := by
  have hpositive :
      0 < innovationValueGap kappaI' kappaN vI vN oldCrossing := by
    unfold innovationValueGap at hold ⊢
    nlinarith
  by_contra hnot
  have hle : oldCrossing ≤ newCrossing := le_of_not_gt hnot
  rcases hle.eq_or_lt with heq | hlt
  · subst newCrossing
    linarith
  · have hstrict := hnewMono hlt
    rw [hnew] at hstrict
    linarith

/-! ## Proposition 5 and Proposition 7: monotone long-run effects -/

theorem effectiveWage_directions
    {wI wN : ℝ → ℝ} (hwI : StrictMono wI) (hwN : StrictAnti wN)
    {n₁ n₂ : ℝ} (hn : n₁ < n₂) :
    wI n₁ < wI n₂ ∧ wN n₂ < wN n₁ :=
  ⟨hwI hn, hwN hn⟩

/-! ## Proposition 8: constant creative-destruction intensity -/

theorem innovationValueGap_strictAnti
    {kappaI kappaN : ℝ} {vI vN : ℝ → ℝ}
    (hkappaI : 0 < kappaI) (hkappaN : 0 < kappaN)
    (hvI : StrictAnti vI) (hvN : StrictMono vN) :
    StrictAnti (innovationValueGap kappaI kappaN vI vN) := by
  intro x y hxy
  have hI := hvI hxy
  have hN := hvN hxy
  unfold innovationValueGap
  nlinarith

theorem no_crossingFromBelow_of_strictAnti
    {gap : ℝ → ℝ} (hanti : StrictAnti gap) :
    ¬ ∃ root, CrossesFromBelowAt gap root := by
  rintro ⟨root, hcross⟩
  let left := root - 1
  let right := root + 1
  have hleft_lt : left < root := by dsimp [left]; linarith
  have hroot_lt : root < right := by dsimp [right]; linarith
  have hlr : left < right := lt_trans hleft_lt hroot_lt
  have hleftNeg : gap left < 0 := hcross.1 left hleft_lt
  have hrightPos : 0 < gap right := hcross.2 right hroot_lt
  have horder : gap right < gap left := hanti hlr
  linarith

/-! ## Proposition 9 and Proposition B2: welfare signs -/

theorem baselineWelfareChange_pos
    {marginalUtility productivityEffect : ℝ}
    (hmarginal : 0 < marginalUtility) (hproductivity : 0 < productivityEffect) :
    0 < baselineWelfareChange marginalUtility productivityEffect :=
  mul_pos hmarginal hproductivity

theorem frictionalNewTaskWelfareChange_pos
    {productivityGain employmentGain : ℝ}
    (hproductivity : 0 < productivityGain) (hemployment : 0 ≤ employmentGain) :
    0 < frictionalNewTaskWelfareChange productivityGain employmentGain := by
  unfold frictionalNewTaskWelfareChange
  linarith

theorem frictionalAutomationWelfareChange_can_be_negative :
    frictionalAutomationWelfareChange 1 2 < 0 := by
  norm_num [frictionalAutomationWelfareChange]

theorem frictionalAutomationWelfareChange_can_be_positive :
    0 < frictionalAutomationWelfareChange 2 1 := by
  norm_num [frictionalAutomationWelfareChange]

end AR18RaceManMachine

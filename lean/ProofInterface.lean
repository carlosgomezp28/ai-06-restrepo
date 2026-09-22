import AR18RaceManMachine.PaperInterface

/-!
# Proof Interface: The Race Between Machine and Man: Implications of Technology for Growth, Factor Shares and Employment

This file contains exact-type proof endpoints for the transparent propositions
in `PaperInterface.lean`. It is not a human semantic-review surface: one source
claim is reviewed once, against its expanded `...Spec : Prop` declaration.
-/

namespace AR18RaceManMachine

theorem corollary1_task_share_accounting :
    corollary1_task_share_accountingSpec := by
  intro N equilibriumAutomation
  exact capitalTaskExponent_add_laborTaskExponent N equilibriumAutomation

theorem proposition2_constrained_signs :
    proposition2_constrained_signsSpec := by
  intro sigmaHat laborSupplyElasticity lambdaI lambdaN
    hsigma helasticity hlambdaI hlambdaN
  exact ⟨
    constrainedAutomationRelativePriceChange_neg hsigma helasticity hlambdaI,
    constrainedNewTaskRelativePriceChange_pos hsigma helasticity hlambdaN,
    constrainedCapitalRelativePriceElasticity_pos hsigma helasticity⟩

theorem proposition2_technology_free_elasticity :
    proposition2_technology_free_elasticitySpec := by
  intro sigmaHat comparativeAdvantageSemiElasticity lambdaI
    helasticity hlambdaI
  exact technologyFreeElasticity_gt_sigmaHat helasticity hlambdaI

theorem proposition3_productivity_factor_price_core :
    proposition3_productivity_factor_price_coreSpec := by
  intro scale expensive cheap productivity laborShare relativePriceChange
    hscale hcost
  exact ⟨productivityContribution_pos hscale hcost,
    wageChangeDecomposition_eq productivity laborShare relativePriceChange,
    rentalChangeDecomposition_eq productivity laborShare relativePriceChange⟩

theorem lemmaA1_affine_relative_demand_core :
    lemmaA1_affine_relative_demand_coreSpec := by
  intro a b ha hb base
  exact affineRelativeDemand_strictAnti_threshold_strictMono_newTasks ha hb base

theorem proposition6_unique_interior_crossing_core :
    proposition6_unique_interior_crossing_coreSpec := by
  intro gap lower root hmono hroot
  refine ⟨existsUnique_interiorBGPCrossing_of_strictMono hmono hroot, ?_⟩
  constructor
  · intro x hx
    exact (strictMono_root_sign_characterization (x := x) hmono hroot.2.2).1 hx
  · intro x hx
    exact (strictMono_root_sign_characterization (x := x) hmono hroot.2.2).2 hx

theorem corollary2_automation_productivity_shift_core :
    corollary2_automation_productivity_shift_coreSpec := by
  intro kappaI kappaI' kappaN vI vN oldCrossing newCrossing
    hkappa hvIold hnewMono hold hnew
  exact higherAutomationProductivity_lowers_crossing
    hkappa hvIold hnewMono hold hnew

theorem proposition5_effective_wage_direction_core :
    proposition5_effective_wage_direction_coreSpec := by
  intro wI wN hwI hwN n₁ n₂ hn
  exact effectiveWage_directions hwI hwN hn

theorem proposition8_no_stable_crossing_core :
    proposition8_no_stable_crossing_coreSpec := by
  intro gap hanti
  exact no_crossingFromBelow_of_strictAnti hanti

theorem proposition9_welfare_sign_core :
    proposition9_welfare_sign_coreSpec := by
  refine ⟨?_, ?_, frictionalAutomationWelfareChange_can_be_negative,
    frictionalAutomationWelfareChange_can_be_positive⟩
  · intro marginalUtility productivityEffect hmarginal hproductivity
    exact baselineWelfareChange_pos hmarginal hproductivity
  · intro productivityGain employmentGain hproductivity hemployment
    exact frictionalNewTaskWelfareChange_pos hproductivity hemployment

end AR18RaceManMachine

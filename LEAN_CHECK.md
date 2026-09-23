# Lean check — AR18RaceManMachine

AppliedModelingLib paper folder: papers/AR18RaceManMachine/

Required command:
python3 scripts/paper_contribution.py check AR18RaceManMachine --fast

Final result:
+ lake build +AR18RaceManMachine.PaperInterface
Build completed successfully (832 jobs).
+ git diff --check -- papers/AR18RaceManMachine papers/AR18RaceManMachine.lean lakefile.toml ':(exclude)papers/AR18RaceManMachine/source/'
exit_code=0

The run initially encountered three proof/build issues that were repaired without changing economic definitions, theorem statements, assumptions, domains, or conclusions:

1. Closed the unnamed noncomputable section before the AR18RaceManMachine namespace in Model.lean.
2. Replaced an invalid neg_neg.mpr proof step with neg_neg_of_pos in MainTheorems.lean.
3. Instantiated a pointwise strict-monotonicity helper separately for the two universally quantified clauses of CrossesFromBelowAt in ProofInterface.lean.

The final paper-scoped check completed successfully with exit code 0.

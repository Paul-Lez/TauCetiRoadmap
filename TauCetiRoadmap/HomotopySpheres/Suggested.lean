import Mathlib

/-!
# High-dimensional differential topology and homotopy spheres: target signatures

**This file is not the roadmap and is not exhaustive.** The definitive document is
`README.md`. The declarations below suggest Lean forms for a few load-bearing interfaces in
Mathlib's vocabulary; proving them does not by itself finish a stage or the roadmap.

The implementations of the group-valued targets must be the geometric quotients and filtered
colimits specified in the roadmap. A definition with the displayed codomain and an arbitrary
body does not meet that specification.
-/

namespace TauCetiRoadmap.HomotopySpheres

open CategoryTheory ContinuousMap
open scoped ContDiff Manifold Topology

/-! ## Stable groups and maps -/

/-- The `k`th stable stem, implemented as the suspension colimit of sphere homotopy groups. -/
noncomputable def stableStem (k : ℕ) : AddCommGrpCat := by
  sorry

/-- Stable homotopy of `SO`, implemented as the colimit under block inclusions. -/
noncomputable def stableSOHomotopy (k : ℕ) : AddCommGrpCat := by
  sorry

/-- Stable `J`, induced by the action of the finite special orthogonal groups on spheres. -/
noncomputable def stableJ (k : ℕ) : stableSOHomotopy k ⟶ stableStem k := by
  sorry

/-- Framed bordism on the shared collared-cobordism carrier. -/
noncomputable def framedBordismGroup (n : ℕ) : AddCommGrpCat := by
  sorry

/-- Pontryagin--Thom, after the collapse and regular-value constructions have been proved
independent of choices and mutually inverse. -/
noncomputable def pontryaginThom (n : ℕ) : framedBordismGroup n ≅ stableStem n := by
  sorry

/-! ## Geometric Kervaire--Milnor groups and maps -/

/-- Almost-framed bordism, constructed from the geometric defect-disc cycles in Stage 6. -/
noncomputable def almostFramedBordismGroup (n : ℕ) : AddCommGrpCat := by
  sorry

/-- Parallelizable fillings with homotopy-sphere boundary, on the shared cobordism carrier. -/
noncomputable def parallelizableFillingGroup (n : ℕ) (_hn : 5 ≤ n) : AddCommGrpCat := by
  sorry

/-- The simply connected Wall surgery-obstruction group, defined from quadratic data. -/
noncomputable def wallSurgeryObstructionGroup (n : ℕ) : AddCommGrpCat := by
  sorry

/-- Delete the defect-disc interior from an almost-framed cycle. -/
noncomputable def almostFramedToFilling (n : ℕ) (hn : 5 ≤ n) :
    almostFramedBordismGroup n ⟶ parallelizableFillingGroup n hn := by
  sorry

/-- The geometric filling group agrees with the normalized simply connected Wall group only
after the surgery-obstruction comparison theorem has been proved. -/
noncomputable def fillingIsoWall (n : ℕ) (hn : 5 ≤ n) :
    parallelizableFillingGroup n hn ≅ wallSurgeryObstructionGroup n := by
  sorry

/-! ## Representative low-dimensional calculations -/

/-- The stable composite `ν²`, constructed through the EHP/Toda calculation. -/
noncomputable def nuSquared : stableStem 6 := by
  sorry

theorem two_nuSquared : 2 • nuSquared = 0 := by
  sorry

theorem nuSquared_ne_zero : nuSquared ≠ 0 := by
  sorry

/-- The complete sixth-stem calculation, normalized by sending `ν²` to `1`. -/
noncomputable def sixthStableStemEquiv : stableStem 6 ≃+ ZMod 2 := by
  sorry

@[simp]
theorem sixthStableStemEquiv_nuSquared : sixthStableStemEquiv nuSquared = 1 := by
  sorry

/-- Bott periodicity supplies these vanishing results as consequences of the full eight-periodic
table, not as isolated calculations. -/
theorem stableSOHomotopy_five_subsingleton : Subsingleton (stableSOHomotopy 5) := by
  sorry

theorem stableSOHomotopy_six_subsingleton : Subsingleton (stableSOHomotopy 6) := by
  sorry

/-- The six-dimensional Kervaire invariant, constructed from the framed intersection
quadratic form. -/
noncomputable def kervaireInvariantSix : stableStem 6 ⟶ AddCommGrpCat.of (ZMod 2) := by
  sorry

theorem kervaireInvariantSix_nuSquared : kervaireInvariantSix nuSquared = 1 := by
  sorry

/-! ## Homotopy spheres and smooth recognition -/

/-- The geometric group of oriented h-cobordism classes of smooth homotopy `n`-spheres. -/
noncomputable def homotopySphereGroup (n : ℕ) (_hn : 5 ≤ n) : AddCommGrpCat := by
  sorry

/-- A homotopy sphere acquires its canonical almost framing after one disc is removed. -/
noncomputable def homotopySphereToAlmostFramed (n : ℕ) (hn : 5 ≤ n) :
    homotopySphereGroup n hn ⟶ almostFramedBordismGroup n := by
  sorry

/-- Exactness at almost-framed bordism is proved from geometric fillings, not stored as data. -/
theorem exact_homotopySphere_almostFramed_filling (n : ℕ) (hn : 6 ≤ n) :
    Function.Exact (homotopySphereToAlmostFramed n (by omega))
      (almostFramedToFilling n (by omega)) := by
  sorry

/-- The Kervaire--Milnor calculation in dimension six. -/
theorem homotopySphereGroup_six_subsingleton :
    Subsingleton (homotopySphereGroup 6 (by omega)) := by
  sorry

private abbrev SixSphere :=
  Metric.sphere (0 : EuclideanSpace ℝ (Fin 7)) 1

private noncomputable abbrev SixModel :=
  modelWithCornersSelf ℝ (EuclideanSpace ℝ (Fin 6))

/-- The correctly scoped smooth recognition theorem. Compactness, separation, and countability
are explicit because `ChartedSpace` and `IsManifold` do not contain them. -/
theorem smoothPoincareSix (M : Type*) [TopologicalSpace M] [T2Space M]
    [SecondCountableTopology M] [CompactSpace M]
    [ChartedSpace (EuclideanSpace ℝ (Fin 6)) M]
    [IsManifold SixModel ∞ M]
    (_h : M ≃ₕ SixSphere) :
    Nonempty (M ≃ₘ⟮SixModel, SixModel⟯ SixSphere) := by
  sorry

end TauCetiRoadmap.HomotopySpheres

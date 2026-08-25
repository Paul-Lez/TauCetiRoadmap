import Mathlib.Analysis.Complex.UpperHalfPlane.FixedPoints
import Mathlib.Analysis.Complex.UpperHalfPlane.Manifold
import Mathlib.Analysis.Complex.UpperHalfPlane.ProperAction
import Mathlib.Geometry.Manifold.Instances.Quotient
import Mathlib.LinearAlgebra.Matrix.ProjectiveSpecialLinearGroup
import Mathlib.Topology.Compactification.OnePoint.ProjectiveLine

/-!
# Fuchsian groups and orbifold Riemann surfaces: target signatures

**This file is not the roadmap and is not exhaustive.** The definitive document is
`README.md`. These declarations pin the effective projective action, the standard orbit
quotient and free locus, invariant-function descent, and the cusp-coordinate convention.

The compactified quotient, elliptic quotient charts, local multiplicity, and degree of a
holomorphic map are roadmap targets whose public APIs do not yet exist at the dependency pin.
They are specified in the markdown rather than represented by empty `Prop` wrappers.
-/

namespace TauCetiRoadmap.FuchsianOrbifolds

open Matrix MulAction
open scoped ContDiff Manifold MatrixGroups UpperHalfPlane

private abbrev SL₂R := SL(2, ℝ)
private abbrev PSL₂R := PSL(2, ℝ)

/-! ## Effective projective action -/

/-- The Möbius action of `SL(2,R)` factors through its center. This named homomorphism is the
canonical projective action; any `MulAction` and continuous-action instances are derived from it
without exporting a competing action. -/
noncomputable def pslAction : PSL₂R →* Equiv.Perm ℍ := by
  sorry

/-- The projective Möbius action is effective. -/
theorem pslAction_injective : Function.Injective pslAction := by
  sorry

/-- Every element of the projective group acts holomorphically on the upper half-plane. -/
theorem pslAction_mdifferentiable (g : PSL₂R) : MDiff (pslAction g : ℍ → ℍ) := by
  sorry

/-! ## Existing properly-discontinuous and free-locus anchors -/

/-- Mathlib already proves proper discontinuity for every discrete subgroup of `SL(2,R)`.
The roadmap proves the effective `PSL(2,R)` form and does not infer freeness from this result. -/
example (Γ : Subgroup SL₂R) [DiscreteTopology Γ] : ProperlyDiscontinuousSMul Γ ℍ :=
  inferInstance

/-- Proper discontinuity gives finite stabilizers, not trivial stabilizers. -/
example (Γ : Subgroup SL₂R) [DiscreteTopology Γ] (z : ℍ) :
    (MulAction.stabilizer Γ z : Set Γ).Finite :=
  ProperlyDiscontinuousSMul.finite_stabilizer z

/-- The ordinary quotient projection is a covering on exactly the trivial-stabilizer locus.
Elliptic points are handled by the separate cyclic quotient chart of the roadmap. -/
example (Γ : Subgroup SL₂R) [DiscreteTopology Γ] :
    IsCoveringMapOn (Quotient.mk <| MulAction.orbitRel Γ ℍ) <|
      (Quotient.mk <| MulAction.orbitRel Γ ℍ) ''
        {z | MulAction.stabilizer Γ z = ⊥} :=
  isCoveringMapOn_quotientMk_of_properlyDiscontinuousSMul

/-! ## Descent through the standard orbit quotient -/

private abbrev OrbitQuotient (Γ : Type*) [Group Γ] [MulAction Γ ℍ] :=
  MulAction.orbitRel.Quotient Γ ℍ

/-- An invariant function descends through `MulAction.orbitRel.Quotient`; no quotient section is
chosen. Holomorphic and meromorphic descent add the corresponding map-level hypotheses. -/
def descendInvariant {Γ Y : Type*} [Group Γ] [MulAction Γ ℍ] (f : ℍ → Y)
    (hf : ∀ (g : Γ) (z : ℍ), f (g • z) = f z) : OrbitQuotient Γ → Y :=
  Quotient.lift f fun a b hab ↦ by
    rcases hab with ⟨g, rfl⟩
    exact hf g b

@[simp]
theorem descendInvariant_quotientMk {Γ Y : Type*} [Group Γ] [MulAction Γ ℍ]
    (f : ℍ → Y) (hf : ∀ (g : Γ) (z : ℍ), f (g • z) = f z) (z : ℍ) :
    descendInvariant f hf (Quotient.mk'' z) = f z :=
  rfl

/-! ## Cusp-coordinate convention -/

/-- The q-coordinate associated to a positive cusp width `w`. -/
noncomputable def cuspCoordinate (w : ℝ) (z : ℍ) : ℂ :=
  Complex.exp (2 * (Real.pi : ℂ) * Complex.I * (z : ℂ) / w)

/-- Positive translation by the cusp width fixes the q-coordinate. -/
theorem cuspCoordinate_vadd (w : ℝ) (hw : 0 < w) (z : ℍ) :
    cuspCoordinate w (w +ᵥ z) = cuspCoordinate w z := by
  sorry

/-- A cusp coordinate takes values in the punctured plane before compactification. -/
theorem cuspCoordinate_ne_zero (w : ℝ) (z : ℍ) : cuspCoordinate w z ≠ 0 := by
  exact Complex.exp_ne_zero _

/-! ## Elliptic local coordinate anchor -/

/-- The coordinate map for a cyclic stabilizer of order `m`. The roadmap proves that the full
local orbit map is biholomorphically conjugate to this map. -/
def cyclicQuotientCoordinate (m : ℕ) (z : ℂ) : ℂ := z ^ m

theorem cyclicQuotientCoordinate_differentiable (m : ℕ) :
    Differentiable ℂ (cyclicQuotientCoordinate m) := by
  sorry

theorem cyclicQuotientCoordinate_eq_zero {m : ℕ} (hm : 0 < m) (z : ℂ) :
    cyclicQuotientCoordinate m z = 0 ↔ z = 0 := by
  sorry

/-!
The level-one application first constructs a compact Riemann surface, then descends `j`, proves
the extended map to `OnePoint ℂ` has degree one, and only then obtains a biholomorphism with the
Riemann sphere. No target here installs a sphere atlas on the quotient by assumption.
-/

end TauCetiRoadmap.FuchsianOrbifolds

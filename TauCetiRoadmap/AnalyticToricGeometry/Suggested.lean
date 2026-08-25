import Mathlib

/-!
# Analytic toric geometry: target signatures

**This file is not the roadmap and is not exhaustive.** The definitive document is
`README.md`. The declarations below pin a few interfaces that can be stated against the current
Mathlib dependency. The algebraic fan, semigroup, and toric-variety types are deliberately not
redeclared here: the roadmap consumes their public shapes from Yaël Dillies's Toric project.

Tau Ceti implements the missing algebraic input in that same public shape and states the central
targets against it immediately. These include the regular affine-chart biholomorphism, analytic
fan realization, toric properness criterion, and algebraic--analytic comparison.
-/

namespace TauCetiRoadmap.AnalyticToricGeometry

open Topology
open scoped BigOperators

/-! ## Existing cone and gluing anchors -/

section ConeAnchors

variable {N : Type*} [AddCommGroup N] [Module ℝ N]

/-- Fans use Mathlib's face relation on pointed cones, rather than a second face predicate. -/
example {σ τ : PointedCone ℝ N} (hστ : σ.IsFaceOf τ) : σ ≤ τ :=
  hστ.le

/-- The face lattice used by the algebraic fan API is the existing Mathlib face lattice. -/
example (σ : PointedCone ℝ N) (F : σ.Face) : (F : PointedCone ℝ N).IsFaceOf σ :=
  F.isFaceOf

end ConeAnchors

/-- Analytic fan gluing uses Mathlib's canonical maps into `TopCat.GlueData.glued`. -/
example (D : TopCat.GlueData) (i : D.J) : IsOpenEmbedding (D.toGlueData.ι i) :=
  D.ι_isOpenEmbedding i

/-! ## Regular affine charts and complex points

For an affine semigroup `S`, the type below is the actual functor-of-points carrier
`Spec(ℂ[S])(ℂ)`.  It is therefore shared with the algebraic construction, rather than being an
unconstrained type introduced only to carry an analytic structure.

The algebraic toric API owns the dual integral semigroup of a cone and the theorem identifying it
with the coordinate semigroup below when the cone is regular.  The analytic layer consumes that
identification as an `AddEquiv`; it does not define another cone, fan, face, or regularity dialect.
-/

/-- The coordinate model for the dual semigroup of a regular cone with `k` boundary and `l` torus
directions. -/
abbrev RegularDualSemigroup (k l : ℕ) :=
  (Fin k →₀ ℕ) × (Fin l →₀ ℤ)

/-- The coordinate ring of an affine semigroup chart. -/
abbrev AffineSemigroupCoordinateRing
    (S : Type*) [AddCommMonoid S] :=
  MonoidAlgebra ℂ (Multiplicative S)

/-- The complex points of an affine semigroup chart, expressed through its coordinate ring. -/
abbrev AffineSemigroupComplexPoint
    (S : Type*) [AddCommMonoid S] :=
  AffineSemigroupCoordinateRing S →ₐ[ℂ] ℂ

/-- The affine-chart comparison supplied by the universal property of the monoid algebra.  An
algebraic regularity theorem supplies `e` for the dual integral semigroup of a regular cone. -/
noncomputable def regularAffinePointEquiv {S : Type*} [AddCommMonoid S] {k l : ℕ}
    (e : S ≃+ RegularDualSemigroup k l) :
    AffineSemigroupComplexPoint S ≃ (Fin k → ℂ) × (Fin l → ℂˣ) := by
  sorry

/-- The analytic topology on the complex points of a regular affine toric chart.  This is a named
definition, not a global instance: downstream constructions install it only on the chart under
consideration. -/
@[instance_reducible]
noncomputable def regularAffinePointTopology {S : Type*} [AddCommMonoid S] {k l : ℕ}
    (e : S ≃+ RegularDualSemigroup k l) :
    TopologicalSpace (AffineSemigroupComplexPoint S) :=
  TopologicalSpace.induced (regularAffinePointEquiv e) inferInstance

/-- With the named topology above, the algebraic complex-point carrier is the expected analytic
model `ℂ^k × (ℂ×)^l`.  This is the central local algebraic--analytic comparison target. -/
noncomputable def regularAffinePointHomeomorph {S : Type*} [AddCommMonoid S] {k l : ℕ}
    (e : S ≃+ RegularDualSemigroup k l) :
    @Homeomorph (AffineSemigroupComplexPoint S) ((Fin k → ℂ) × (Fin l → ℂˣ))
      (regularAffinePointTopology e) inferInstance := by
  sorry

/-! ## Coordinate monomial maps

These definitions are coordinate calculations, not replacements for the coordinate-free
character and semigroup maps owned by the shared algebraic toric API.
-/

/-- A polynomial monomial map between affine coordinate spaces. -/
noncomputable def affineMonomialMap {m n : ℕ} (A : Matrix (Fin m) (Fin n) ℕ) :
    (Fin n → ℂ) → Fin m → ℂ :=
  fun z i ↦ ∏ j, z j ^ A i j

/-- Affine monomial maps are holomorphic. -/
theorem affineMonomialMap_differentiable {m n : ℕ} (A : Matrix (Fin m) (Fin n) ℕ) :
    Differentiable ℂ (affineMonomialMap A) := by
  sorry

/-- Matrix multiplication is composition of affine monomial maps. -/
theorem affineMonomialMap_mul {l m n : ℕ} (B : Matrix (Fin l) (Fin m) ℕ)
    (A : Matrix (Fin m) (Fin n) ℕ) (z : Fin n → ℂ) :
    affineMonomialMap (B * A) z = affineMonomialMap B (affineMonomialMap A z) := by
  sorry

/-- Laurent monomials give the coordinate form of maps between complex algebraic tori. -/
noncomputable def torusMonomialMap {m n : ℕ} (A : Matrix (Fin m) (Fin n) ℤ) :
    (Fin n → ℂˣ) → Fin m → ℂˣ :=
  fun z i ↦ ∏ j, z j ^ A i j

/-- Integral matrix multiplication is composition of torus monomial maps. -/
theorem torusMonomialMap_mul {l m n : ℕ} (B : Matrix (Fin l) (Fin m) ℤ)
    (A : Matrix (Fin m) (Fin n) ℤ) (z : Fin n → ℂˣ) :
    torusMonomialMap (B * A) z = torusMonomialMap B (torusMonomialMap A z) := by
  sorry

/-- A character in coordinates. The public API uses the character lattice and proves this
formula after choosing a basis. -/
noncomputable def torusCharacter {n : ℕ} (u : Fin n → ℤ) (z : Fin n → ℂˣ) : ℂˣ :=
  ∏ i, z i ^ u i

theorem torusCharacter_add {n : ℕ} (u v : Fin n → ℤ) (z : Fin n → ℂˣ) :
    torusCharacter (u + v) z = torusCharacter u z * torusCharacter v z := by
  sorry

theorem torusCharacter_monomialMap {m n : ℕ} (A : Matrix (Fin m) (Fin n) ℤ)
    (u : Fin m → ℤ) (z : Fin n → ℂˣ) :
    torusCharacter u (torusMonomialMap A z) =
      torusCharacter (fun j ↦ ∑ i, u i * A i j) z := by
  sorry

/-!
The generic parameter `S` above is not a competing toric-semigroup abstraction: an application
must provide an equivalence from the algebraic API's dual integral semigroup to the regular
coordinate model.  Thus the same monoid-algebra complex points underlie both the algebraic and
analytic sides, while the topology remains local and explicit.
-/

end TauCetiRoadmap.AnalyticToricGeometry

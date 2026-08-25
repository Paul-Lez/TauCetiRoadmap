import Mathlib.Analysis.Complex.Basic
import Mathlib.Geometry.Manifold.Instances.Quotient
import Mathlib.Geometry.Manifold.LocalDiffeomorph
import Mathlib.Geometry.Manifold.VectorBundle.Pullback
import Mathlib.Topology.Compactification.OnePoint.ProjectiveLine
import Mathlib.Topology.Gluing

/-!
# Complex manifolds, quotients, bundles, and gluing: target signatures

**This file is not the roadmap and is not exhaustive.** The definitive document is
`README.md`. These declarations suggest Lean forms for representative load-bearing interfaces.
The roadmap also requires the full basic API, compatibility, and naturality described there.

Missing compatibility conditions are not represented by empty `Prop` wrappers. In particular,
the open-gluing theorem will state compatibility directly in Mathlib's structure-groupoid
vocabulary once its input signature is implemented.
-/

namespace TauCetiRoadmap.ComplexManifolds

open Topology
open scoped ContDiff Manifold

/-! ## Existing carriers which the roadmap extends -/

/-- Open gluing keeps Mathlib's glued carrier and canonical inclusions. -/
example (D : TopCat.GlueData) (i : D.J) : IsOpenEmbedding (D.toGlueData.ι i) :=
  D.ι_isOpenEmbedding i

/-- Free properly discontinuous quotients keep Mathlib's standard orbit quotient. -/
noncomputable example {M G H : Type*} [TopologicalSpace M] [Group G] [MulAction G M]
    [ProperlyDiscontinuousSMul G M] [ContinuousConstSMul G M] [IsCancelSMul G M]
    [T2Space M] [LocallyCompactSpace M] [TopologicalSpace H] [ChartedSpace H M] :
    ChartedSpace H (MulAction.orbitRel.Quotient G M) :=
  inferInstance

/-! ## Named atlas transport -/

/-- Pull a charted-space structure back along a homeomorphism. The roadmap develops this in the
shape of mathlib4#42847 and proves composition, inverse, and groupoid-transport laws. -/
@[instance_reducible]
noncomputable def pullbackChartedSpace {H M N : Type*} [TopologicalSpace H]
    [TopologicalSpace M] [TopologicalSpace N] [ChartedSpace H N] (e : M ≃ₜ N) :
    ChartedSpace H M := by
  sorry

/-- A manifold structure transports with the named atlas. Use this through a local or scoped
instance when a carrier supports more than one transported atlas. -/
theorem pullback_isManifold {𝕜 E H M N : Type*} {n : ℕ∞} [NontriviallyNormedField 𝕜]
    [NormedAddCommGroup E] [NormedSpace 𝕜 E] [TopologicalSpace H]
    (I : ModelWithCorners 𝕜 E H) [TopologicalSpace M] [TopologicalSpace N] [ChartedSpace H N]
    [IsManifold I n N] (e : M ≃ₜ N) :
    @IsManifold 𝕜 _ E _ _ H _ I n M _ (pullbackChartedSpace e) := by
  sorry

/-! ## The Riemann sphere on `OnePoint ℂ` -/

/-- The two-chart complex atlas on Mathlib's existing one-point compactification. -/
@[instance_reducible]
noncomputable def riemannSphereChartedSpace : ChartedSpace ℂ (OnePoint ℂ) := by
  sorry

/-- The named atlas is an integrable one-dimensional complex-manifold atlas. -/
theorem riemannSphere_isManifold :
    letI := riemannSphereChartedSpace
    IsManifold 𝓘(ℂ, ℂ) ∞ (OnePoint ℂ) := by
  sorry

/-! ## Complex quotients by biholomorphic actions -/

section ComplexQuotient

variable {E M G : Type*} [NormedAddCommGroup E] [NormedSpace ℂ E]
  [TopologicalSpace M] [Group G] [MulAction G M] [ProperlyDiscontinuousSMul G M]
  [ContinuousConstSMul G M] [IsCancelSMul G M] [T2Space M] [LocallyCompactSpace M]
  [ChartedSpace E M] [IsManifold 𝓘(ℂ, E) ∞ M]

/-- A free properly discontinuous action preserves the complex quotient atlas only when every
action map is holomorphic. The hypothesis at `g⁻¹` makes each action map biholomorphic. -/
theorem complexQuotient_isManifold
    (_holo : ∀ g : G, ContMDiff 𝓘(ℂ, E) 𝓘(ℂ, E) ∞ fun x : M ↦ g • x) :
    IsManifold 𝓘(ℂ, E) ∞ (MulAction.orbitRel.Quotient G M) := by
  sorry

/-- The orbit projection is a covering map and local biholomorphism. This is not a theorem about
a later projection from the quotient to an unrelated base. -/
theorem quotientMk_isLocalBiholomorph
    (_holo : ∀ g : G, ContMDiff 𝓘(ℂ, E) 𝓘(ℂ, E) ∞ fun x : M ↦ g • x) :
    IsLocalDiffeomorph 𝓘(ℂ, E) 𝓘(ℂ, E) ∞
      (Quotient.mk (MulAction.orbitRel G M)) := by
  sorry

end ComplexQuotient

end TauCetiRoadmap.ComplexManifolds

import Mathlib

open CategoryTheory Limits

/-!
# Stable reduction of curves and stable maps: target signatures

**This file is not the roadmap and is not exhaustive.** The definitive document is
`README.md`. The statements here will suggest Lean forms for particular milestones so that
contributors and reviewers converge on names and signatures; discharging all of them will
finish neither a layer nor the roadmap.

At this roadmap repository's pinned Mathlib commit
`9caeba1000ef8f302920981f4a08651d325abc81`, most vocabulary needed to state the targets
faithfully does not exist: families of curves, at-worst-nodal morphisms, relative dualizing
sheaves, stable pointed families, stable maps, and finite DVR extensions are all roadmap
targets. Introducing placeholder `Prop` definitions here would make the summit vacuous, so
later signatures will be added only as those types land in Tau Ceti. Mathlib already proves
the generic- and special-fibre immersion facts, so the first compiled Layer 0 prototypes
below instead pin the missing model interface.

The narrative roadmap fixes the mathematical statements, conventions, proof route,
dependency layers, acceptance examples, stable-map API, and boundary with moduli spaces.
-/

namespace TauCetiRoadmap.StableReduction

universe u

noncomputable section

open AlgebraicGeometry

/-- Suggested Layer 0 shape for a model with its generic-fibre identification. -/
structure Model (R K : Type u) [CommRing R] [IsDomain R] [IsDiscreteValuationRing R]
    [Field K] [Algebra R K] [IsFractionRing R K]
    (C : Scheme.{u}) (toK : C ⟶ Spec (.of K)) where
  total : Scheme.{u}
  toBase : total ⟶ Spec (.of R)
  genericFiberIso :
    pullback toBase (Spec.map (CommRingCat.ofHom (algebraMap R K))) ≅ C
  genericFiberIso_hom_toK :
    genericFiberIso.hom ≫ toK =
      pullback.snd toBase (Spec.map (CommRingCat.ofHom (algebraMap R K)))

namespace Model

variable {R K : Type u} [CommRing R] [IsDomain R] [IsDiscreteValuationRing R]
variable [Field K] [Algebra R K] [IsFractionRing R K]
variable {C : Scheme.{u}} {toK : C ⟶ Spec (.of K)}

private abbrev genericPointMap : Spec (.of K) ⟶ Spec (.of R) :=
  Spec.map (CommRingCat.ofHom (algebraMap R K))

/-- The morphism on generic fibres induced by a morphism over the base. -/
def baseChangeHom {M N : Model R K C toK} (f : M.total ⟶ N.total)
    (over_base : f ≫ N.toBase = M.toBase) :
    pullback M.toBase (genericPointMap (R := R) (K := K)) ⟶
      pullback N.toBase (genericPointMap (R := R) (K := K)) :=
  pullback.lift (pullback.fst _ _ ≫ f) (pullback.snd _ _) (by
    rw [Category.assoc, over_base]
    exact pullback.condition)

/-- Suggested Layer 0 shape for morphisms of models. -/
structure Hom (M N : Model R K C toK) where
  hom : M.total ⟶ N.total
  over_base : hom ≫ N.toBase = M.toBase
  genericFiber :
    baseChangeHom (R := R) (K := K) hom over_base ≫ N.genericFiberIso.hom =
      M.genericFiberIso.hom

end Model

end

end TauCetiRoadmap.StableReduction

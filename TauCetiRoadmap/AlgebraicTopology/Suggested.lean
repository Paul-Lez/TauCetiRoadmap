import Mathlib

/-!
# Algebraic topology of spaces and manifolds: target signatures

**This file is not the roadmap and is not exhaustive.** The definitive document is
`README.md`. The declarations below suggest Lean forms for a few load-bearing interfaces in
Mathlib's vocabulary; proving them does not by itself finish a stage or the roadmap.

The roadmap also asks for van Kampen, excision, cellular comparison, duality, Hurewicz, and
Whitehead. Several of their final signatures depend on functors which the roadmap first asks Tau
Ceti to construct, so this file does not replace missing hypotheses by empty `Prop` wrappers.
-/

namespace TauCetiRoadmap.AlgebraicTopology

open CategoryTheory ContinuousMap Topology
open scoped Topology

/-! ## Existing anchors -/

/-- Relative topology uses Mathlib's category of embedded topological pairs. -/
example {X : TopCat} (A : Set X) : TopPair :=
  TopPair.ofSubset A

/-- Ordinary singular chains remain the absolute chain functor used by the relative theory. -/
noncomputable example (R : Type*) [CommRing R] :
    ModuleCat R ⥤ TopCat ⥤ ChainComplex (ModuleCat R) ℕ :=
  AlgebraicTopology.singularChainComplexFunctor (ModuleCat R)

/-- Cellular chains are built from Mathlib's actual cells, not from a record of cell counts. -/
example {X : Type*} [TopologicalSpace X] (C : Set X) [CWComplex C] (n : ℕ) : Type _ :=
  Topology.CWComplex.cell C n

/-! ## Relative chains and homology -/

/-- The relative singular-chain functor. The implementation factors through `SSetPair` and is
naturally isomorphic to the quotient of the two absolute singular-chain complexes. -/
noncomputable def relativeSingularChainComplex (R : Type*) [CommRing R] :
    ModuleCat R ⥤ TopPair ⥤ ChainComplex (ModuleCat R) ℕ := by
  sorry

/-- Relative singular homology, functorial in its coefficient module and in maps of pairs. -/
noncomputable def relativeSingularHomology (R : Type*) [CommRing R] (n : ℕ) :
    ModuleCat R ⥤ TopPair ⥤ ModuleCat R := by
  sorry

/-! ## Finite CW Euler characteristic -/

/-- Euler characteristic of a chosen finite CW structure. The roadmap proves that this agrees
with alternating homology rank and is invariant under homotopy equivalence. -/
noncomputable def finiteCWEulerCharacteristic (X : Type*) [TopologicalSpace X]
    [CWComplex (Set.univ : Set X)] [CWComplex.Finite (Set.univ : Set X)] : ℤ := by
  sorry

theorem finiteCWEulerCharacteristic_eq_of_homotopyEquiv
    {X Y : Type*} [TopologicalSpace X] [TopologicalSpace Y]
    [CWComplex (Set.univ : Set X)] [CWComplex.Finite (Set.univ : Set X)]
    [CWComplex (Set.univ : Set Y)] [CWComplex.Finite (Set.univ : Set Y)]
    (_e : X ≃ₕ Y) :
    finiteCWEulerCharacteristic X = finiteCWEulerCharacteristic Y := by
  sorry

/-! ## Homological Whitehead -/

/-- A map between simply connected CW complexes which induces isomorphisms on integral singular
homology is itself the forward map of a homotopy equivalence. -/
theorem homologicalWhitehead
    {X Y : Type} [TopologicalSpace X] [TopologicalSpace Y]
    [SimplyConnectedSpace X] [SimplyConnectedSpace Y]
    [CWComplex (Set.univ : Set X)] [CWComplex (Set.univ : Set Y)]
    (f : C(X, Y))
    (_hf : ∀ n : ℕ,
      IsIso (((AlgebraicTopology.singularHomologyFunctor (ModuleCat ℤ) n).obj
        (ModuleCat.of ℤ ℤ)).map (TopCat.ofHom f))) :
    ∃ e : X ≃ₕ Y, e.toFun = f := by
  sorry

end TauCetiRoadmap.AlgebraicTopology

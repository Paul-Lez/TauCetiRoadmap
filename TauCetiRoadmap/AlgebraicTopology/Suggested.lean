import Mathlib

/-!
# Algebraic topology of spaces and manifolds: target signatures

**This file is not the roadmap and is not exhaustive.** The definitive document is
`README.md`. The declarations below suggest Lean forms for load-bearing interfaces in Mathlib's
vocabulary; proving them does not by itself finish a stage or the roadmap.
-/

namespace TauCetiRoadmap.AlgebraicTopology

open CategoryTheory ContinuousMap Topology
open CategoryTheory.Limits
open scoped ContDiff Manifold Topology

noncomputable section

universe u

private abbrev SingularChains (R : Type u) [CommRing R] (M : ModuleCat.{u} R)
    (X : TopCat.{u}) : ChainComplex (ModuleCat.{u} R) ℕ :=
  ((AlgebraicTopology.singularChainComplexFunctor (ModuleCat.{u} R)).obj M).obj X

private abbrev SingularHomology (R : Type u) [CommRing R] (M : ModuleCat.{u} R)
    (X : TopCat.{u}) (n : ℕ) : ModuleCat.{u} R :=
  ((AlgebraicTopology.singularHomologyFunctor (ModuleCat.{u} R) n).obj M).obj X

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

/-- The relative singular-chain functor. The implementation factors through `SSetPair`. -/
noncomputable def relativeSingularChainComplex (R : Type*) [CommRing R] :
    ModuleCat R ⥤ TopPair ⥤ ChainComplex (ModuleCat R) ℕ := by
  sorry

/-- Relative singular homology, functorial in its coefficient module and in maps of pairs. -/
noncomputable def relativeSingularHomology (R : Type*) [CommRing R] (n : ℕ) :
    ModuleCat R ⥤ TopPair ⥤ ModuleCat R := by
  sorry

/-- The quotient of absolute chains on `X` by absolute chains on `A`. -/
noncomputable def relativeChainQuotient (R : Type u) [CommRing R]
    (M : ModuleCat.{u} R) (X : TopPair.{u}) : ChainComplex (ModuleCat.{u} R) ℕ :=
  cokernel (((AlgebraicTopology.singularChainComplexFunctor (ModuleCat.{u} R)).obj M).map X.map)

/-- The `SSetPair` construction is naturally the quotient `C_*(X) / C_*(A)`. -/
noncomputable def relativeSingularChainComplexIsoQuotient (R : Type u) [CommRing R]
    (M : ModuleCat.{u} R) (X : TopPair.{u}) :
    (((relativeSingularChainComplex R).obj M).obj X) ≅ relativeChainQuotient R M X := by
  sorry

/-- The chain-level sequence `C_*(A) ⟶ C_*(X) ⟶ C_*(X,A)`, using the quotient carrier. -/
noncomputable def relativeChainShortComplex (R : Type u) [CommRing R]
    (M : ModuleCat.{u} R) (X : TopPair.{u}) :
    ShortComplex (ChainComplex (ModuleCat.{u} R) ℕ) :=
  ShortComplex.mk
    (((AlgebraicTopology.singularChainComplexFunctor (ModuleCat.{u} R)).obj M).map X.map)
    (cokernel.π _)
    (cokernel.condition _)

/-- Exactness of relative chains is the source of the long exact sequence. -/
theorem relativeChainShortComplex_shortExact (R : Type u) [CommRing R]
    (M : ModuleCat.{u} R) (X : TopPair.{u}) :
    (relativeChainShortComplex R M X).ShortExact := by
  sorry

/-! ## Groupoid van Kampen -/

/-- An open cover, with no connectedness assumption on its members or intersections. -/
structure OpenCover (X : TopCat.{u}) where
  ι : Type u
  U : ι → TopologicalSpace.Opens X
  iSup_eq_top : iSup U = ⊤

/-- Nonempty finite intersections index the Čech diagram. The order is used contravariantly so
that inclusions of intersections induce the diagram maps. -/
def OpenCover.CechIndex {X : TopCat.{u}} (U : OpenCover X) :=
  {s : Finset U.ι // s.Nonempty}

instance OpenCover.cechIndexPartialOrder {X : TopCat.{u}} (U : OpenCover X) :
    PartialOrder U.CechIndex :=
  PartialOrder.lift (fun s : U.CechIndex => s.val) Subtype.val_injective

noncomputable def cechFundamentalGroupoidDiagram {X : TopCat.{u}} (U : OpenCover X) :
    U.CechIndexᵒᵖ ⥤ Cat.{u, u} := by
  sorry

/-- The cocone maps each intersection groupoid to the groupoid of the covered space. -/
noncomputable def cechFundamentalGroupoidCocone {X : TopCat.{u}} (U : OpenCover X) :
    Cocone (cechFundamentalGroupoidDiagram U) := by
  sorry

/-- The cocone point is the actual fundamental groupoid, not an abstract replacement. -/
noncomputable def cechFundamentalGroupoidCoconePointIso {X : TopCat.{u}} (U : OpenCover X) :
    (cechFundamentalGroupoidCocone U).pt ≅ Cat.of (FundamentalGroupoid X) := by
  sorry

noncomputable def fundamentalGroupoid_openCover_isColimit {X : TopCat.{u}} (U : OpenCover X) :
    IsColimit (cechFundamentalGroupoidCocone U) := by
  sorry

/-! ## Excision and Mayer--Vietoris -/

/-- Geometric data for excising `U` from the pair `(X,A)`. -/
structure ExcisionDatum (X : TopCat.{u}) where
  A : Set X
  U : Set X
  closure_subset_interior : closure U ⊆ interior A

noncomputable def ExcisionDatum.source {X : TopCat.{u}} (D : ExcisionDatum X) : TopPair.{u} := by
  sorry

noncomputable def ExcisionDatum.target {X : TopCat.{u}} (D : ExcisionDatum X) : TopPair.{u} :=
  TopPair.ofSubset D.A

/-- Inclusion `(X \ U, A \ U) ⟶ (X,A)`. -/
noncomputable def ExcisionDatum.map {X : TopCat.{u}} (D : ExcisionDatum X) :
    D.source ⟶ D.target := by
  sorry

theorem relativeSingularHomology_map_isIso_of_excision (R : Type u) [CommRing R]
    (M : ModuleCat.{u} R) (n : ℕ) {X : TopCat.{u}} (D : ExcisionDatum X) :
    IsIso (((relativeSingularHomology R n).obj M).map D.map) := by
  sorry

/-- The Mayer--Vietoris map `(i_U,-i_V)` from the intersection. -/
noncomputable def mayerVietorisLeftMap (R : Type u) [CommRing R]
    (M : ModuleCat.{u} R) (n : ℕ) {X : TopCat.{u}}
    (U V : TopologicalSpace.Opens X) :
    SingularHomology R M (TopCat.of ↥(U ⊓ V)) n ⟶
      SingularHomology R M (TopCat.of U) n ⊞ SingularHomology R M (TopCat.of V) n := by
  sorry

/-- The Mayer--Vietoris map from the two opens to the covered space. -/
noncomputable def mayerVietorisRightMap (R : Type u) [CommRing R]
    (M : ModuleCat.{u} R) (n : ℕ) {X : TopCat.{u}}
    (U V : TopologicalSpace.Opens X) :
    SingularHomology R M (TopCat.of U) n ⊞ SingularHomology R M (TopCat.of V) n ⟶
      SingularHomology R M X n := by
  sorry

/-- The Mayer--Vietoris short complex in degree `n`, before adjoining its connecting map. -/
noncomputable def mayerVietorisShortComplex (R : Type u) [CommRing R]
    (M : ModuleCat.{u} R) (n : ℕ) {X : TopCat.{u}}
    (U V : TopologicalSpace.Opens X)
    (_hcover : U ⊔ V = ⊤) : ShortComplex (ModuleCat.{u} R) :=
  ShortComplex.mk (mayerVietorisLeftMap R M n U V)
    (mayerVietorisRightMap R M n U V) (by sorry)

theorem mayerVietorisShortComplex_exact (R : Type u) [CommRing R]
    (M : ModuleCat.{u} R) (n : ℕ) {X : TopCat.{u}}
    (U V : TopologicalSpace.Opens X)
    (hcover : U ⊔ V = ⊤) :
    (mayerVietorisShortComplex R M n U V hcover).Exact := by
  sorry

/-! ## Cellular comparison -/

noncomputable def cellularChainComplex (R : Type u) [CommRing R]
    (X : Type u) [TopologicalSpace X] [CWComplex (Set.univ : Set X)] :
    ChainComplex (ModuleCat.{u} R) ℕ := by
  sorry

noncomputable def cellularToSingular (R : Type u) [CommRing R]
    (X : Type u) [TopologicalSpace X] [CWComplex (Set.univ : Set X)] :
    cellularChainComplex R X ⟶ SingularChains R (ModuleCat.of R R) (TopCat.of X) := by
  sorry

theorem cellularToSingular_quasiIso (R : Type u) [CommRing R]
    (X : Type u) [TopologicalSpace X] [CWComplex (Set.univ : Set X)] :
    QuasiIso (cellularToSingular R X) := by
  sorry

/-! ## Finite covers, transfer, and Cartan--Leray -/

/-- A finite cover of constant degree. General finite covers are handled componentwise. -/
structure FiniteCover (E B : TopCat.{u}) where
  p : E ⟶ B
  isCoveringMap : IsCoveringMap p
  degree : ℕ
  finite_fiber : ∀ b : B, Finite {e : E // p e = b}
  fiber_card : ∀ b : B, Nat.card {e : E // p e = b} = degree

noncomputable def finiteCoverTransfer (R : Type u) [CommRing R]
    (M : ModuleCat.{u} R) {E B : TopCat.{u}} (D : FiniteCover E B) :
    SingularChains R M B ⟶ SingularChains R M E := by
  sorry

theorem finiteCover_transfer_push (R : Type u) [CommRing R]
    (M : ModuleCat.{u} R) {E B : TopCat.{u}} (D : FiniteCover E B) :
    finiteCoverTransfer R M D ≫
      ((AlgebraicTopology.singularChainComplexFunctor (ModuleCat.{u} R)).obj M).map D.p =
        D.degree • 𝟙 _ := by
  sorry

/-- A regular deck action; simple transitivity is stated on each fibre. -/
structure RegularDeckAction {E B : TopCat.{u}} (D : FiniteCover E B)
    (G : Type u) [Group G] where
  deck : G → C(E, E)
  deck_one : deck 1 = ContinuousMap.id E
  deck_mul : ∀ g h, deck (g * h) = (deck g).comp (deck h)
  commutes : ∀ g x, D.p (deck g x) = D.p x
  simplyTransitive : ∀ {x y : E}, D.p x = D.p y → ∃! g, deck g x = y

theorem finiteCover_push_transfer_regular (R : Type u) [CommRing R]
    (M : ModuleCat.{u} R) {E B : TopCat.{u}} (D : FiniteCover E B)
    (G : Type u) [Group G] [Fintype G] (A : RegularDeckAction D G) :
    ((AlgebraicTopology.singularChainComplexFunctor (ModuleCat.{u} R)).obj M).map D.p ≫
      finiteCoverTransfer R M D =
        ∑ g : G,
            ((AlgebraicTopology.singularChainComplexFunctor (ModuleCat.{u} R)).obj M).map
            (TopCat.ofHom (A.deck g)) := by
  sorry

/-- An `R[G]`-module expressed without introducing a second module category. -/
structure GroupModule (R : Type u) [CommRing R] (G : Type u) [Group G] where
  M : ModuleCat.{u} R
  action : Representation R G M

/-- Group homology, implemented from the bar resolution. -/
noncomputable def groupHomology (R : Type u) [CommRing R] (G : Type u) [Group G]
    (M : GroupModule R G) (n : ℕ) : ModuleCat.{u} R := by
  sorry

noncomputable def coverHomologyGroupModule (R : Type u) [CommRing R]
    (M : ModuleCat.{u} R) {E B : TopCat.{u}} (D : FiniteCover E B)
    (G : Type u) [Group G] (A : RegularDeckAction D G) (q : ℕ) : GroupModule R G := by
  sorry

noncomputable def cartanLeraySpectralSequence (R : Type u) [CommRing R]
    (M : ModuleCat.{u} R) {E B : TopCat.{u}} (D : FiniteCover E B)
    (G : Type u) [Group G] [Fintype G] (A : RegularDeckAction D G) :
    SpectralSequence (ModuleCat.{u} R)
      (fun r ↦ ComplexShape.spectralSequenceNat ⟨-r, r - 1⟩) 2 := by
  sorry

noncomputable def cartanLerayE2Iso (R : Type u) [CommRing R]
    (M : ModuleCat.{u} R) {E B : TopCat.{u}} (D : FiniteCover E B)
    (G : Type u) [Group G] [Fintype G] (A : RegularDeckAction D G) (p q : ℕ) :
    ((cartanLeraySpectralSequence R M D G A).page 2).X ⟨p, q⟩ ≅
      groupHomology R G (coverHomologyGroupModule R M D G A q) p := by
  sorry

/-! ## Local coefficients, cap products, and duality -/

abbrev LocalCoefficientSystem (R : Type u) [CommRing R] (X : TopCat.{u}) :=
  FundamentalGroupoid X ⥤ ModuleCat.{u} R

noncomputable def twistedSingularChainComplex (R : Type u) [CommRing R]
    (X : TopCat.{u}) (L : LocalCoefficientSystem R X) :
    ChainComplex (ModuleCat.{u} R) ℕ := by
  sorry

noncomputable def singularCohomology (R : Type u) [CommRing R]
    (X : TopCat.{u}) (n : ℕ) : ModuleCat.{u} R := by
  sorry

/-- Cap product with the Alexander--Whitney sign convention. -/
noncomputable def capProduct (R : Type u) [CommRing R] (X : TopCat.{u}) (p q : ℕ) :
    singularCohomology R X p ⟶
      ModuleCat.of R (SingularHomology R (ModuleCat.of R R) X q →ₗ[R]
        SingularHomology R (ModuleCat.of R R) X (q - p)) := by
  sorry

/-- The pair `(X, X \ {x})` used to define local homology. -/
noncomputable def puncturedPair (X : TopCat.{u}) (x : X) : TopPair.{u} :=
  TopPair.ofSubset ({x}ᶜ : Set X)

/-- Local orientation data: a global class whose image generates every local top homology
module. The maps are induced by `(X, ∅) ⟶ (X, X \ {x})`. -/
structure FundamentalClassDatum (R : Type u) [CommRing R] (X : TopCat.{u}) (n : ℕ) where
  fundamentalClass : ((relativeSingularHomology R n).obj (ModuleCat.of R R)).obj
    (TopPair.incl.obj X)
  spans : ∀ x : X,
    Submodule.span R
      {((relativeSingularHomology R n).obj (ModuleCat.of R R)).map
        (TopPair.j (puncturedPair X x)) fundamentalClass} = ⊤

noncomputable def poincareDualityMap (R : Type u) [CommRing R]
    (X : TopCat.{u}) (n p : ℕ) (c : FundamentalClassDatum R X n) :
    singularCohomology R X p ⟶ SingularHomology R (ModuleCat.of R R) X (n - p) := by
  sorry

/-- Compact Hausdorff second-countable manifolds with a fundamental class satisfy duality. The
orientation-local-system version precedes this constant-coefficient corollary in the roadmap. -/
theorem poincareDualityMap_isIso (R : Type u) [CommRing R] (n : ℕ)
    (M : Type u) [TopologicalSpace M] [T2Space M] [SecondCountableTopology M]
    [CompactSpace M] [ConnectedSpace M]
    [ChartedSpace (EuclideanSpace ℝ (Fin n)) M]
    [IsManifold (modelWithCornersSelf ℝ (EuclideanSpace ℝ (Fin n))) ∞ M]
    (p : ℕ) (c : FundamentalClassDatum R (TopCat.of M) n) :
    IsIso (poincareDualityMap R (TopCat.of M) n p c) := by
  sorry

/-! ## Relative Hurewicz -/

/-- Explicit NDR data for an embedded pair. -/
structure NDRPairData (X : TopPair.{u}) where
  u : C(X.fst, unitInterval)
  H : C(unitInterval × X.fst, X.fst)
  zero_set : ∀ x, u x = 0 ↔ x ∈ Set.range X.map
  at_zero : ∀ x, H (0, x) = x
  fixed : ∀ (t : unitInterval) (a : X.snd), H (t, X.map a) = X.map a
  at_one : ∀ x, u x < 1 → H (1, x) ∈ Set.range X.map

/-- Relative homotopy groups use the same based-cube model as Mathlib's `HomotopyGroup`. -/
noncomputable def relativeHomotopyGroup (n : ℕ) (X : TopPair.{u}) : ModuleCat.{u} ℤ := by
  sorry

noncomputable def relativeHurewicz (n : ℕ) (X : TopPair.{u}) :
    relativeHomotopyGroup n X ⟶
      (relativeSingularHomology ℤ n).obj (ModuleCat.of ℤ ℤ) |>.obj X := by
  sorry

theorem relativeHurewicz_isIso (n : ℕ) (hn : 2 ≤ n) (X : TopPair.{u})
    (_hNDR : NDRPairData X)
    [SimplyConnectedSpace X.fst] [SimplyConnectedSpace X.snd]
    (_hvanish : ∀ i < n, Subsingleton (relativeHomotopyGroup i X)) :
    IsIso (relativeHurewicz n X) := by
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

end

end TauCetiRoadmap.AlgebraicTopology

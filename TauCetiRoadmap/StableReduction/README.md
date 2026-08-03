# Roadmap: stable reduction of curves and stable maps

The eventual application is the **properness of the moduli space of stable maps**. This
roadmap builds two prerequisites: the stable-reduction theory of curves over a discrete
valuation ring and the scheme-level theory of stable maps. Its summit includes existence
and uniqueness of a stable curve model after finite base extension, first for smooth curves
of genus at least two and then for stable pointed curves in the full stable range. It also
defines families of stable maps to a projective target and develops their basic geometric
API. It does **not** construct a moduli functor, stack, or coarse moduli space, and it does
not yet claim that such an object is proper.

The proof route is the scheme-theoretic Artin–Winters/Deligne–Mumford route organized in
the [Stacks Project, *Semistable Reduction*](https://stacks.math.columbia.edu/tag/0C2P)
and [*Moduli of Curves*, §109.24](https://stacks.math.columbia.edu/tag/0E8C): build regular
models and their numerical types, use sufficiently much prime-to-residue-characteristic
Picard torsion to force a reduced nodal special fibre, and contract unstable components.
This is preferable here to proving the theorem through GIT and a pre-existing proper moduli
stack: Mathlib and Tau Ceti have neither the required GIT nor moduli-stack infrastructure,
while the chosen route splits into reusable scheme, curve, surface, divisor, and Picard
theory.

Suggested home: `TauCeti/AlgebraicGeometry/Curves/`, with the model and reduction theory
under `TauCeti/AlgebraicGeometry/Curves/StableReduction/` and the map-specific definitions
under `TauCeti/AlgebraicGeometry/Curves/StableMaps/`. General-purpose blowups, intersection
theory, relative `Proj`, coherent cohomology, and duality belong in the corresponding shared
`TauCeti/AlgebraicGeometry/` directories rather than under either specialized namespace.

## The end goals

Let `R` be a discrete valuation ring with fraction field `K`, with no completeness,
Henselian, algebraic-closure, or perfect-residue-field hypothesis.

1. **Classical stable reduction.** If `C/K` is a smooth, projective, geometrically connected
   curve of genus `g ≥ 2`, there are a finite separable extension `K'/K`, a maximal ideal
   `m'` of the integral closure `R̃` of `R` in `K'` above the maximal ideal of `R`, and a
   stable family `X → Spec(R̃_{m'})` of genus `g`, together with an isomorphism from its
   generic fibre to `C_{K'}`.
2. **Uniqueness.** Over a fixed DVR, two stable models with an identified generic fibre are
   related by a unique isomorphism extending that identification. This is uniqueness in a
   groupoid, not literal equality of schemes or of chosen pullbacks.
3. **Pointed stable reduction.** For `n` disjoint marked points on a smooth projective
   geometrically connected curve, with `2g - 2 + n > 0`, the same conclusion holds with a
   stable `n`-pointed family and extensions of all markings. Include the corresponding
   extension statement for a generic fibre that is already a stable pointed nodal curve;
   here the theorem may first be stated after a finite extension, with separability proved
   wherever the construction supplies it.
4. **Stable maps as geometric objects.** For a projective target `V → S`, define a family
   of `n`-pointed genus-`g` stable maps as a pointed prestable curve `C → S`, a morphism
   `F : C → V` over `S`, and the fibrewise stability condition. Prove that stability is
   equivalent both to the component criterion for components contracted by `F` and to
   finiteness of the automorphism group scheme. Keep the target polarization separate from
   the underlying stable-map data.
5. **A usable stable-map API.** Develop base change, isomorphisms, automorphisms, evaluation
   maps, polarization degree, decorated dual graphs, constant maps, reindexing and forgetting
   markings, gluing, and map-aware stabilization. These are constructions on individual
   objects and families, not the construction of their moduli space.
6. **A valuative interface.** Package existence after finite DVR extension and uniqueness
   over a fixed DVR in a form that a future moduli-stack development can consume. Do not
   call this `IsProper`: Mathlib's `AlgebraicGeometry.ValuativeCriterion` concerns morphisms
   of schemes, whereas the moduli object here is eventually a stack.

The mathematical shape of the two summits is:

```lean
-- Suggested shape once the prerequisite vocabulary exists; this is not present-day Lean.
-- theorem exists_stableReduction
--     (R K : Type*) [CommRing R] [IsDomain R] [IsDiscreteValuationRing R]
--     [Field K] [Algebra R K] [IsFractionRing R K]
--     (C : Scheme) (toK : C ⟶ Spec K)
--     [SmoothOfRelativeDimension 1 toK] [IsProjective toK]
--     (hconn : GeometricallyConnected toK) (hg : arithmeticGenus toK = g) (hg2 : 2 ≤ g) :
--   ∃ (K' R' : Type*) ..., StableFamily ... ∧ genericFiber ... ≅ baseChange C K'

-- Suggested stable-map data once pointed prestable curves exist; this is not present-day Lean.
-- structure PrestableMap (target : V ⟶ S) (n : ℕ) where
--   curve : PointedPrestableFamily S n
--   map : curve.total ⟶ V
--   map_over : map ≫ target = curve.toBase
-- def IsStableMap (F : PrestableMap target n) : Prop := ...
```

Do not freeze this spelling before the curve-family, projective-morphism, and DVR-extension
APIs exist. The definitive targets are the mathematical statements above, not this comment.

## Standing conventions

- **Schemes first.** Work with morphisms of Mathlib's `Scheme`. Algebraic spaces and stacks
  are downstream consumers, not foundations for the proof. Definitions should nevertheless
  be morphism properties, stable under base change and invariant under isomorphism, so they
  can later be transported to spaces.
- **No bundled mega-object.** `FamilyOfCurves f`, `AtWorstNodalOfRelativeDimensionOne f`,
  `Prestable f`, `Stable f`, and the genus condition are separate predicates. A marked
  family packages the sections and their equations with `f`, but does not silently bundle
  projectivity, a DVR base, or a chosen polarization.
- **Geometric fibres govern stability.** Connectedness, nodes, irreducible components, and
  the componentwise stability inequalities are tested after residue-field extension to an
  algebraic closure. Prove descent and invariance; do not define stability using only the
  visible components over a non-algebraically-closed residue field.
- **Terminology follows the Stacks Project.** A scheme-level family of curves is proper,
  flat, finitely presented, and of relative dimension at most one. A **prestable** family
  is an at-worst-nodal relative curve of pure relative dimension one with geometrically
  connected fibres. An unpointed **semistable** family is defined to have no rational tails;
  for genus at least one, record the equivalence with global generation of powers of the
  relative dualizing sheaf. An unpointed **stable** family of genus at least two has neither
  rational tails nor rational bridges; in that range, record the equivalence with ampleness
  of the relative dualizing sheaf. Do not use `semistable` merely as an unpinned synonym for
  `nodal`.
- **Marked stability is logarithmic.** Markings are pairwise disjoint sections through the
  smooth locus. An `n`-pointed prestable curve is stable when
  `ω_{X/S}(s₁ + ⋯ + sₙ)` is relatively ample; equivalently, on every geometric fibre
  each genus-zero component has at least three special points and each genus-one component
  has at least one. This is the convention needed in genus zero and one.
- **Stable-map stability is map-dependent.** A stable map has a pointed prestable source,
  not necessarily a stable pointed source. On every geometric fibre, only components on
  which the map is constant must satisfy the pointed stability inequalities: a contracted
  genus-zero component has at least three special points and a contracted genus-one
  component has at least one. Prove equivalence with finiteness of the automorphism group
  scheme. In positive characteristic, finiteness does not by itself mean unramifiedness;
  isolate hypotheses such as separability when a reduced or unramified automorphism scheme
  is needed.
- **Polarizations are structure for degree, not hidden data.** The core stable-map structure
  records a target morphism and a map over the base. A chosen relatively ample invertible
  sheaf `L` on a projective target supplies component degrees, a numerical total degree, and
  the positivity criterion using
  `ω_{C/S}(Σsᵢ) ⊗ F^*(L^⊗3)`. Prove that the stability predicate is independent of the
  chosen ample polarization.
- **Genus means arithmetic genus.** For a proper geometrically connected curve over a field,
  `g = dim H¹(X, 𝒪_X)`. In a family, genus `g` means that `R¹f_*𝒪_X` is locally free of
  rank `g`, with the fibrewise and Euler-characteristic formulations proved equivalent.
  Never use the sum of the genera of the normalizations: the first Betti number of the dual
  graph also contributes.
- **A model carries its generic-fibre identification.** A model of `C/K` over `R` includes
  `X → Spec R` and an explicit isomorphism `X_K ≅ C`. Morphisms of models must commute with
  those isomorphisms. This prevents uniqueness statements from forgetting which birational
  map is being extended.
- **DVR extensions are local data.** For finite `K'/K`, the integral closure of `R` can have
  several maximal ideals. Choose one above the closed point and localize. Do not pretend the
  integral closure itself is always a DVR, and do not choose an extension of the valuation
  without recording it.
- **All characteristics.** Prime-to-residue-characteristic torsion is chosen inside the
  proof. Characteristic zero, perfect residue fields, and semistable reduction of the
  Jacobian may yield later corollaries, but are not hypotheses of the main theorem.

## Inventory: what Mathlib and Tau Ceti already give us

This inventory was checked on 2026-08-03 against Tau Ceti commit
`373eee14f6209add708eddd85923d14ec0a128ee` and the Mathlib commit pinned by that Tau Ceti
checkout, `30696563acb0596ab44d272bc5dfee96b2e72263`; this roadmap repository itself builds
against Mathlib commit `9caeba1000ef8f302920981f4a08651d325abc81`.

### Consume from Mathlib

- **Schemes, pullbacks, and fibres:** `Mathlib/AlgebraicGeometry/{Scheme,Pullbacks,Fiber}.lean`;
  in particular `Scheme.Hom.fiber`, the morphism to `Spec κ(s)`, and compatibility of
  fibres with pullback.
- **Morphism properties:** `Proper`, `Flat`, `LocallyOfFinitePresentation`, `Smooth`,
  `SmoothOfRelativeDimension`, `Separated`, `Finite`, `Etale`, `ClosedImmersion`, and their
  base-change/descent API under `Mathlib/AlgebraicGeometry/Morphisms/`.
- **Geometric predicates:** geometrically connected, reduced, irreducible, and integral
  morphisms under `Mathlib/AlgebraicGeometry/Geometrically/`.
- **Valuative criterion:** `AlgebraicGeometry.ValuativeCommSq`,
  `ValuativeCriterion.Existence`, `ValuativeCriterion.Uniqueness`, and
  `IsProper.eq_valuativeCriterion` in `Mathlib/AlgebraicGeometry/ValuativeCriterion.lean`.
  The file explicitly leaves reduction from arbitrary valuation rings to DVRs over a
  Noetherian base as future work; build that bridge rather than assuming it.
- **Valuation and DVR algebra:** `ValuationRing`, `IsDiscreteValuationRing`, fraction rings,
  localization, integral closure in a finite extension, and the fact that the integral
  closure of a Dedekind domain in a finite separable extension is Dedekind, under
  `Mathlib/RingTheory/{Valuation,DedekindDomain,Localization}/`.
- **Normalization and properness ingredients:** relative normalization and Zariski's main
  theorem; ideal sheaves and closed subschemes; `Proj` of a graded ring and its properness.
  These are ingredients, not a blowup, relative `Proj`, ample-line-bundle, or general
  projective-morphism API.
- **Abstract cohomology:** sheaf cohomology on a site and Čech/Mayer–Vietoris machinery.
  This is not yet coherent cohomology of schemes, cohomology and base change, or duality.

### Consume and coordinate with Tau Ceti

- The [Jacobian challenge](../JacobianChallenge/README.md) owns the shared foundations of
  invertible sheaves, divisors, the Picard group, coherent cohomology, Riemann–Roch, Serre
  duality, relative coherent cohomology, and base change. Current Tau Ceti already contains
  the beginning of this lane: scheme-level invertible sheaves, rational points and residue
  degrees, and a substantial Weil-divisor/degree/Abel–Jacobi API. Stable reduction consumes
  and extends those shared foundations; it must not create a second Picard or divisor theory.
- The stable-reduction proof needs only the abstract Picard group and its prime-to-
  characteristic torsion, plus curve cohomology and duality. It does **not** wait for
  representability of the Picard functor or construction of the Jacobian as an abelian
  variety. State the exact lemmas shared with the Jacobian roadmap in neutral files so both
  developments can import them without a cycle.

### Work already in motion

The audit found no Tau Ceti issue, pull request, or public Lean project intention for general
stable reduction, stable curves, nodal families, or stable maps. Two open Mathlib pull
requests develop coordinate-level singular Weierstrass cubics:
[#25071](https://github.com/leanprover-community/mathlib4/pull/25071) and rational points on
nodal cubics [#25069](https://github.com/leanprover-community/mathlib4/pull/25069). If they
land, use them for elliptic examples; they are not a general scheme-theoretic node or family
of nodal curves API. Recheck open Mathlib work and Lean Zulip before beginning each major
foundation below, especially blowups, coherent cohomology, and duality.

## Inventory: what is missing

There is presently no scheme-level API for families of curves, relative dimension at most
one, nodal singularities or the relative singular locus, arithmetic genus in families,
relative dualizing sheaves, ampleness/projective morphisms, prestable/semistable/stable
curves, marked curves, stable maps, blowups or contractions, intersection theory on
arithmetic surfaces, regular/minimal models, numerical types, or semistable/stable reduction.
The summit cannot be reached by filling one isolated `sorry`; every item below is part of
its dependency graph.

---

## The build, in layers

The layers give dependency order. Within a layer, put general-purpose material in Mathlib-
compatible namespaces and prove the expected base-change, localization, and isomorphism API
before the named milestone.

### Layer 0: relative curves and extensions of DVRs

- Define relative dimension `≤ 1` and pure relative dimension `1` for scheme morphisms,
  fibrewise via Krull dimension, with invariance under isomorphism, locality, composition
  facts in the cases needed here, and stability under arbitrary base change.
- Define the scheme-level `FamilyOfCurves f` predicate: `f` is proper, flat, finitely
  presented, and of relative dimension `≤ 1`. Prove its base-change and isomorphism API.
  Keep geometric connectedness and exact genus separate.
- Develop generic and special fibres over a DVR, including the open immersion of the generic
  fibre, the closed immersion of the special fibre, and compatibility with scalar extension.
  Reuse `Scheme.Hom.fiber`; do not introduce a competing fibre construction.
- Package finite extensions of DVR data: integral closure in `K'`, primes over the maximal
  ideal, localization at such a prime, domination/locality of `R → R'`, fraction field
  `K'`, and finite/separable towers. Prove common-refinement lemmas for two chosen finite
  extensions.
- Define models and morphisms of models with their generic-fibre identifications. Construct a
  proper model of a projective curve by scheme-theoretic closure in projective space.

### Layer 1: nodes, normalization, and dual graphs

- Develop Kähler differentials and Fitting ideals far enough to form the relative singular
  closed subscheme `Sing(f)`. Build syntomic morphisms (flat, locally finitely presented
  local complete intersections) and their relative-dimension API. Define
  `AtWorstNodalOfRelativeDimensionOne f` by the scheme-theoretic criterion: syntomic of
  relative dimension one and `Sing(f) → S` unramified. Prove the equivalent fibrewise
  condition: flat and locally finitely presented, with pure one-dimensional fibres having
  at worst nodes.
- Prove the local normal form. At a node of a fibre the completed local ring is
  `κ̄[[x,y]]/(xy)`; over a DVR a nodal family is étale-locally
  `R'[x,y]/(xy)` or `R'[x,y]/(xy - πⁿ)`. Prove that smooth relative curves are nodal,
  and that nodality is stable under base change and local for the étale topology.
- Prove that the singular locus of a proper nodal fibre is finite. Develop normalization of
  a reduced nodal curve, the two branches above a geometric node, the conductor, and the
  normalization exact sequence for `𝒪_X`.
- Build the finite **dual graph** of a proper geometric nodal curve: vertices are irreducible
  components of the normalization and edges are nodes, with loops allowed. Record component
  genera, incidence/special points, graph connectedness, and the formula
  `pₐ(X) = Σ_v g_v + b₁(Γ_X)`.
- Define rational tails and rational bridges geometrically and prove their invariance under
  field extension. A rational component is unstable exactly when the log-canonical degree
  on it is nonpositive; this bridge to Layer 3 must be a theorem, not a second definition.

### Layer 2: coherent curve theory, duality, and positivity

This is the main shared lane with the Jacobian roadmap. Put it in shared files and coordinate
ownership before implementation.

- Build quasi-coherent/coherent sheaves of modules on schemes, finite pushforward under a
  proper morphism, `Rⁱf_*`, finite-dimensionality over a proper curve, vanishing above
  degree one, flat/cohomology-and-base-change, and semicontinuity in the cases used below.
- Define arithmetic genus and prove the normalization/dual-graph formula, invariance in a
  proper flat family, and the locally-free-rank description of genus `g`.
- Build the relative dualizing complex/sheaf for proper flat finitely presented relative
  Cohen–Macaulay curves. For Gorenstein fibres, prove that `ω_{X/S}` is invertible and that
  its formation commutes with arbitrary base change. Nodal curves are Gorenstein.
- Prove the componentwise degree formula on a geometric nodal fibre:
  `deg(ω_X|_E) = 2g(Ẽ) - 2 + #(branches on Ẽ above nodes of X lying on E)`, where `Ẽ`
  is the normalization of `E`; the count includes all such branches, so a self-node of `E`
  contributes two. With markings, add the number of markings on `E`.
- Extend Tau Ceti's invertible-sheaf API with tensor powers, Cartier divisors, pullback,
  degree on components, global generation, and relative ampleness. Build projective
  morphisms and relative `Proj` of a finitely generated graded quasi-coherent algebra;
  connect affine-base cases to Mathlib's `Proj`.
- Prove the curve criteria for global generation and ampleness by componentwise degree.
  These turn combinatorial stability into positivity of `ω` or log `ω` and later make
  contractions canonical.

### Layer 3: prestable, semistable, stable, and pointed curves

- Define prestable families as proper, at-worst-nodal relative curves of pure dimension one
  with geometrically connected fibres. Prove equivalence with universal
  `f_*𝒪_X = 𝒪_S`, and develop restriction, pullback, and fibre APIs.
- Define unpointed semistable and stable families with the conventions above. Prove:
  in genus at least one, semistable iff there are no rational tails iff `ω^m` is fibrewise
  globally generated for `m ≥ 2`; in genus at least two, stable iff there are no rational
  tails or bridges iff `ω` is relatively ample.
- Define an `n`-pointed prestable family using sections `s : Fin n → (S ⟶ X)` with
  `s i ≫ f = 𝟙 S`, pairwise-disjoint images, and images in the smooth locus. Define
  stability by relative ampleness of `ω(Σsᵢ)` and prove the geometric-component
  criterion and the numerical non-emptiness condition `2g - 2 + n > 0`.
- Prove stability is invariant under isomorphism, stable under arbitrary base change, open on
  the base in a prestable family, and compatible with forgetting a marking followed by
  stabilization.
- Develop isomorphisms and automorphisms of (pointed) families. Prove a stable geometric
  fibre has a finite unramified automorphism scheme and no infinitesimal automorphisms.
  Keep this separate from construction of a moduli stack.

### Layer 4: blowups and intersection theory on arithmetic surfaces

- Construct the Rees algebra and the blowup of a quasi-coherent finite-type ideal as a
  relative `Proj`. Prove the universal property, properness/projectivity, compatibility
  with flat base change, behaviour away from the centre, exceptional divisor, strict
  transform, and affine chart descriptions.
- Work out the essential test case `R[x,y]/(xy - πⁿ)`: blowing up its closed singular
  point preserves the nodal-family property and replaces `n` by `n - 2` on the remaining
  singular chart. Deduce termination in a regular total space.
- Develop Cartier/Weil intersection multiplicities on a regular two-dimensional scheme,
  especially vertical divisors on a proper regular model over a DVR: bilinearity,
  projection formula, self-intersection, and the negative-semidefinite intersection matrix
  of components of the special fibre.
- Formalize the resolution theorem in the exact scope required here: a normal proper model
  of a smooth curve over a DVR admits a regular proper model after a finite sequence of
  normalized blowups in closed points (blowup followed by normalization, per Lipman's
  theorem in the scope needed here), and two regular proper models admit a common
  resolution. Over a general, possibly non-excellent DVR, prove that the relevant
  normalizations are finite; this is available here because the generic fibre is smooth.
  Do not cite unrestricted resolution of singularities as a black box.
- Define exceptional curves of the first kind and prove the curve-on-surface contraction
  theorem, including preservation of properness and control of the generic fibre.

### Layer 5: regular and minimal models

- Construct a regular proper model of a smooth projective curve from Layer 4. Define
  relative minimality by absence of exceptional curves of the first kind in the special
  fibre.
- Show every regular proper model contracts to a minimal one. For positive-genus generic
  fibre, prove the minimal regular model is unique up to unique isomorphism and has the
  expected terminal mapping property among regular models.
- Develop components and multiplicities of the special fibre, the scheme-theoretic equality
  `X_s = Σ mᵢCᵢ`, the intersection relations with that fibre, adjunction, and the genus
  formula. Prove that a reduced special fibre with smooth components and only transverse
  double intersections is a prestable model.
- Keep the genus-zero exception explicit: minimal regular models need not be unique. The
  pointed stabilization in Layer 9, not an invented unpointed uniqueness theorem, handles
  genus zero.

### Layer 6: numerical types and Picard torsion

- Define the numerical type of a regular model: the finite component index, multiplicities
  `mᵢ`, intersection matrix `aᵢⱼ`, canonical/intersection weights, component genera,
  residue degrees where needed, and the associated weighted dual graph. Prove that models
  satisfying the geometric hypotheses yield valid numerical types.
- Develop the abstract Picard group of a numerical type and its prime torsion. Prove the
  combinatorial bounds relating `Pic(T)[ℓ]`, the first Betti number of the graph, the
  geometric genera of components, and the arithmetic genus. Include the classification and
  boundedness results for minimal numerical types used by the Artin–Winters argument.
- Compare line bundles on the regular model, generic fibre, special fibre, reduced special
  fibre, and numerical type. Prove the specialization maps and exact sequences required to
  inject enough generic `ℓ`-torsion into the Picard group of the reduced special fibre.
- For a smooth projective genus-`g` curve and a prime `ℓ` distinct from the field
  characteristic, prove that after a finite separable extension the curve has a rational
  point and all of `Pic(C)[ℓ] ≅ (Z/ℓZ)^{2g}` is rational. Supply the explicit degree
  bound used by the source proof; do not assume an algebraically closed field.
- Prove the numerical conclusion: for `g ≥ 2` and sufficiently large
  `ℓ ≠ char(k)` (the Stacks proof takes `ℓ > 768g`), a minimal regular model carrying
  full `ℓ`-torsion has multiplicity-one, geometrically smooth components and at-worst-
  nodal special fibre.

### Layer 7: semistable reduction

- Prove semistable reduction in genus zero after a separable extension of degree at most two,
  using the conic/`ℙ¹` classification once a rational point exists.
- Prove genus-one semistable reduction after finite separable extension. The minimal regular
  model has special fibre either a smooth genus-one curve or a cycle of rational curves.
- Prove genus-`g ≥ 2` semistable reduction by Layers 5–6. Retain the source theorem's uniform
  finite-extension bound, even if later work improves it: for the first two primes
  `768g < ℓ' < ℓ`, one may take a bound of the form
  `B_g = (2g - 2)(ℓ^(2g))!`.
- State both useful forms: a chosen DVR `R'` above `R`, and simultaneous semistable models
  over every localization at a maximal ideal of the integral closure in one finite
  extension. Prove compatibility with further finite base extension.
- Separate the theorem from its stronger Jacobian criterion. The equivalence between
  semistable reduction of a curve and its Jacobian under additional residue-field
  hypotheses is a later theorem in this layer, not a premise smuggled into the main proof.

### Layer 8: canonical contraction and unpointed stable reduction

- Construct contraction of rational tails and bridges in a prestable family of genus at
  least two, first over a DVR and then in base-change-compatible families. The canonical
  construction is the relative `Proj` of the pluricanonical algebra; prove finite generation,
  identify exactly the contracted components, and show the result remains nodal and flat.
- Prove stabilization is unchanged on an already stable generic fibre and commutes with
  arbitrary base change. Its universal property must imply uniqueness, rather than relying
  on choices of a sequence of component contractions.
- Prove the classical stable-reduction existence theorem by semistable reduction followed by
  stabilization.
- Prove uniqueness of stable models over a DVR: extend the generic isomorphism through a
  common regular model, show both maps are the canonical stabilization, and obtain a unique
  isomorphism of models.
- Package existence, uniqueness, and compatibility after a common finite extension as the
  stable-reduction interface promised in the end goals.

### Layer 9: marked stabilization and stable pointed reduction

- Extend generic markings to sections by properness, then use finite base change and blowups
  to make their closures pairwise disjoint and contained in the smooth locus. Track the
  generic-fibre identifications throughout.
- Construct pointed stabilization from the log-canonical algebra
  `⊕_m f_*(ω_{X/S}(Σsᵢ))^m`. Prove it contracts exactly the components on which the
  log-canonical degree is nonpositive, preserves the marked generic fibre, and commutes with
  base change and forgetting markings.
- Prove stable pointed reduction for smooth generic curves whenever
  `2g - 2 + n > 0`, including `(g,n) = (0,n)` for `n ≥ 3` and `(1,n)` for `n ≥ 1`, and prove
  uniqueness over the fixed DVR.
- Extend the theorem from a smooth generic fibre to an already stable pointed nodal generic
  fibre: normalize, treat the preimages of generic nodes as additional markings, apply the
  pointed theorem componentwise after one common finite extension, and glue the paired
  sections. Prove the glued family is nodal and stable and is independent of all choices.
- Express the result as essential existence after finite DVR extension and unique extension
  over a fixed DVR. This is the precise input a future properness proof for
  `Mbar_{g,n}` and for stable-map moduli should consume.

### Layer 10: stable maps and their stability condition

This layer depends on the pointed-prestable-curve core of Layer 3 and may begin while the
stable-reduction layers are still in progress.

- For a target `q : V → S`, define a `PrestableMap q n` to consist of a pointed prestable
  family `π : C → S`, its `n` ordered markings, a morphism `F : C → V`, and the equation
  `F ≫ q = π`. Supply coercions or projections to the source family without duplicating its
  properties. Define pullback along `S' → S` using chosen pullbacks and prove independence
  from those choices up to canonical isomorphism.
- Define isomorphisms of prestable maps over a fixed target: isomorphisms of pointed source
  curves that commute with `F`. Develop identity, inverse, composition, extensionality, and
  transport along isomorphisms of the base and target. Package the automorphism functor and
  prove representability by a group scheme in the finite-presentation cases used here.
- On a geometric fibre, define when an irreducible component is **contracted** by `F`.
  Relate constancy of the restricted morphism, set-theoretic image dimension zero, and—when
  the target has an ample invertible sheaf—degree zero of its pullback. Prove that this
  notion is invariant under field extension and target isomorphism.
- Define `IsStableMap F` fibrewise: every contracted rational component has at least three
  special points and every contracted genus-one component has at least one. Prove invariance
  under isomorphism, stability under arbitrary base change, and openness on the base in a
  family of prestable maps.
- Prove the two standard characterizations. First, `F` is stable exactly when its geometric
  fibres have finite automorphism group schemes. Do not strengthen `Finite` to `Unramified`
  in positive characteristic without a separability hypothesis. Second, for a relatively
  ample invertible sheaf `L` on a projective target, stability is equivalent to relative
  ampleness of
  `ω_{C/S}(Σsᵢ) ⊗ F^*(L^⊗3)`. Prove independence from `L` and the analogous statement for
  every exponent at least three.
- Show that a constant prestable map is stable exactly when its pointed source is stable.
  A nonconstant map may be stable even when its pointed source is not; formalize this as an
  API theorem rather than making source stability a field of `PrestableMap`.

### Layer 11: basic stable-map API and map-aware stabilization

- Define the evaluation morphism at the `i`th marking as `sᵢ ≫ F : S → V`. Prove its
  compatibility with base change, reindexing of markings, isomorphisms of stable maps, and
  postcomposition on the target.
- Given a relatively ample `L`, define the degree of a map and its degree on each geometric
  irreducible component by the degree of `F^*L`. Prove nonnegativity, additivity over the
  components of a nodal curve, invariance under algebraically closed field extension, and
  local constancy of total degree in a connected family. Until a general cycle theory is
  available, this polarization degree is the compiled numerical invariant; connect it to
  the pushforward curve class once Chow groups of one-cycles exist.
- Decorate the dual graph from Layer 1 with marking legs and component degrees. Prove the
  genus and total-degree formulas and characterize stable vertices: a degree-zero vertex of
  genus zero has valence plus markings at least three, and a degree-zero vertex of genus one
  has at least one incident edge or marking. Develop restriction to a component,
  normalization at a node, and reconstruction of the numerical data.
- Reindex markings by equivalences and define forgetting one marking followed by
  **map-aware stabilization** whenever the resulting numerical type satisfies
  `2g - 2 + (n - 1) + 3d > 0`: contract only components that become unstable and on which
  `F` is constant. Prove that `F` descends uniquely through the contraction, the result is a
  stable map, and the operation commutes with base change and repeated forgetting.
- Define gluing two marked stable maps when their evaluation morphisms at the chosen
  markings agree. Construct the nodal source pushout in the cases needed here, descend the
  target maps, calculate the decorated dual graph, and prove stability of the glued map.
  Include self-gluing of two markings on one source.
- For a projective target with relatively ample `L`, map degree `d`, and
  `2g - 2 + n + 3d > 0`, construct stabilization of a prestable map using the relative
  `Proj` of the section algebra of `ω_{C/S}(Σsᵢ) ⊗ F^*(L^⊗3)`. Identify precisely the
  degree-zero unstable components it contracts. Prove its universal property, uniqueness,
  compatibility with base change, and identity on an already stable map. Prove separately
  that the excluded degree-zero genus-zero and genus-one numerical types admit no stable
  map.
- Record functoriality under target isomorphisms and closed immersions. For a general
  postcomposition `V → W`, prove a sharp criterion for preservation of stability rather
  than asserting it unconditionally: the new target map may contract additional source
  components.

## Acceptance criteria and worked examples

Build these alongside the layers; they detect definitions that are fibrewise, geometric,
or logarithmic in the wrong way.

- **Local node smoothing:** for a DVR uniformizer `π`, verify
  `Spec(R[x,y]/(xy-πⁿ)) → Spec R` is at-worst-nodal; it has regular total space exactly
  in the expected small cases, and successive blowups reduce the thickness and terminate.
- **Genus from a dual graph:** two smooth components meeting transversely in one node have
  genus equal to the sum of their genera; a cycle of `r` rational curves has arithmetic
  genus one. Both follow from the normalization exact sequence and agree with the graph
  formula.
- **Unpointed stability:** a smooth genus-two curve is stable; a rational tail and a rational
  bridge have nonpositive canonical degree and are contracted; a cycle of rational curves is
  semistable of genus one but is not an unpointed stable curve.
- **Pointed stability:** `(ℙ¹; 0,1,∞)` is stable. In the stable limit of four marked
  points on `ℙ¹` when two collide, the special fibre is two projective lines meeting in
  one node, with two markings on each component; both components have three special points.
- **Nonuniqueness in genus zero:** formalize the two contractions of the model
  `T₁T₂ - πT₀² = 0` in `ℙ²_R`, showing why unpointed minimal-model uniqueness
  cannot be asserted in genus zero.
- **Good reduction:** if `C` already extends to a smooth proper family of genus at least two,
  its stable reduction is that family itself, and uniqueness identifies any other stable
  model with it.
- **Stable maps versus stable sources:** the identity `ℙ¹ → ℙ¹` with no markings is a stable
  map although its source is not a stable pointed curve. The constant map from the same
  source is not stable, while a constant map from `(ℙ¹; 0,1,∞)` is stable.
- **Contracted and noncontracted components:** attach an unmarked rational tail to a stable
  source. A map that is constant on the tail is unstable; a map of positive degree on the
  tail can be stable. Verify both the component criterion and positivity of
  `ω(Σpᵢ) ⊗ F^*L^3`.
- **Evaluation and gluing:** glue two stable maps at markings with equal evaluations and
  check the resulting map, arithmetic genus, total degree, and decorated dual graph. Also
  verify that unequal evaluations correctly prevent the gluing construction.
- **Forgetting a marking:** take the constant map from the two-line nodal curve with two
  markings on each component from the pointed-stability example. Forget a marking on one
  component; that contracted rational component now has only two special points and
  map-aware stabilization must contract it. Contrast this with a positive-degree component,
  which remains after its last marking is forgotten because the map is nonconstant.

## Ordering and work lanes

Begin with Layer 0 and the nodal-family core of Layer 1. Four lanes can then advance without
duplicating ownership:

1. **Curve/duality lane:** Layers 1–3, shared with the Jacobian roadmap.
2. **Surface/model lane:** Layers 4–5, beginning with blowups and the local
   `xy = πⁿ` calculation.
3. **Combinatorial/Picard lane:** Layer 6, whose abstract numerical-type theory can start
   before all scheme comparisons exist.
4. **Stable-map lane:** Layer 10 begins after the pointed-curve and positivity cores of
   Layers 2–3. Its definitions, isomorphisms, evaluation maps, and decorated graphs can
   proceed independently of arithmetic-surface reduction. Layer 11's contraction results
   then join it to Layers 8–9.

Layer 7 joins the model and Picard lanes; Layer 8 also needs the duality/positivity lane;
Layer 9 completes pointed reduction, while Layers 10–11 complete the stable-map foundation.
Every implementation issue should name the exact layer and target it claims. A headline
stable-reduction or stable-map statement with unresolved definitions, hidden resolution
assumptions, or a placeholder notion of node does not advance the summit.

## Boundary: moduli spaces and properness

This roadmap defines stable maps and develops their object-level and family-level API, but
it does not define a functor, algebraic stack, or coarse space parametrizing them. It also
does not prove boundedness, finite type, separatedness, or properness of such a moduli
object.

A stable map can have a rational or elliptic component that is unstable as a pointed curve
but is protected from contraction because the map is nonconstant there. Consequently, the
future valuative proof cannot forget the map and apply pointed stable reduction verbatim.
It must extend a generic map to the target—using graph closure, elimination of
indeterminacy, or a sufficiently positive polarization—then apply the map-aware
stabilization developed here. Packaging that theorem as properness additionally requires
the moduli object and the bridge from finite DVR extensions to its valuative criterion.
Those are the next roadmap; the present one stops with stable maps themselves and the API
needed to state that work without placeholders.

## References

- The Stacks Project, [Chapter 55, *Semistable Reduction*](https://stacks.math.columbia.edu/tag/0C2P),
  especially [the local nodal models and regularization](https://stacks.math.columbia.edu/tag/0CDB),
  [genus at least two](https://stacks.math.columbia.edu/tag/0CEI), and
  [the final semistable-reduction theorem](https://stacks.math.columbia.edu/tag/0CDM).
- The Stacks Project, [families of nodal curves](https://stacks.math.columbia.edu/tag/0C58),
  [the relative dualizing sheaf](https://stacks.math.columbia.edu/tag/0E6N),
  [prestable curves](https://stacks.math.columbia.edu/tag/0E6S),
  [semistable curves](https://stacks.math.columbia.edu/tag/0E6X),
  [stable curves](https://stacks.math.columbia.edu/tag/0E73),
  [contraction morphisms](https://stacks.math.columbia.edu/tag/0E7B), and
  [stable reduction](https://stacks.math.columbia.edu/tag/0E98).
- P. Deligne and D. Mumford,
  [*The irreducibility of the space of curves of given genus*](https://pmihes.centre-mersenne.org/articles/10.1007/BF02684599/),
  Publ. Math. IHÉS 36 (1969), especially Corollary 2.7.
- M. Artin and G. Winters,
  [*Degenerate fibres and stable reduction of curves*](https://doi.org/10.1016/0040-9383(71)90028-0),
  Topology 10 (1971), 373–383.
- F. F. Knudsen,
  [*The projectivity of the moduli space of stable curves, II: The stacks M_{g,n}*](https://doi.org/10.7146/math.scand.a-12001),
  Math. Scand. 52 (1983), 161–199, for pointed stabilization and clutching.
- K. Behrend and Yu. Manin,
  [*Stacks of stable maps and Gromov–Witten invariants*](https://arxiv.org/abs/alg-geom/9506023),
  Duke Math. J. 85 (1996), 1–60, for stable maps, decorated graphs, and their morphisms.
- W. Fulton and R. Pandharipande,
  [*Notes on stable maps and quantum cohomology*](https://arxiv.org/abs/alg-geom/9608011),
  Proc. Sympos. Pure Math. 62 (1997), Part 2, 45–96, especially the basic definition,
  stability criterion, and polarization used in the projective construction.
- Q. Liu, *Algebraic Geometry and Arithmetic Curves*, for models, intersection theory,
  reduction of curves, and arithmetic surfaces.
- D. Mumford, J. Fogarty, and F. Kirwan, *Geometric Invariant Theory*, and D. Gieseker,
  *Lectures on Moduli of Curves*, for the alternative GIT route that this roadmap does not
  use as its dependency spine.

## Acknowledgements

This roadmap follows the Artin–Winters and Deligne–Mumford arguments through the modern
organization of the Stacks Project, and follows Behrend–Manin and Fulton–Pandharipande for
the stable-map layer. Its shared Picard, divisor, and cohomology foundations are coordinated
with the existing Tau Ceti Jacobian challenge rather than independently redesigned here.

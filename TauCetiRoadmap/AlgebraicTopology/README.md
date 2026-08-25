# Roadmap: algebraic topology of spaces and manifolds

This roadmap develops the map-level algebraic topology needed to calculate spaces from open
covers, CW structures, fibrations, and manifold decompositions.  It starts at Mathlib's singular
chains, fundamental groupoid, topological pairs, cubical homotopy groups, and classical CW
complexes.  It ends with reusable van Kampen, relative homology, excision, cellular comparison,
duality, Euler-characteristic, Hurewicz, and Whitehead theorems.

The point is a coherent library, not a collection of answers for particular spaces.  Every
calculation is induced by maps, chain maps, or natural transformations.  Homology groups are not
stored as fields asserting the desired answer, and a list of cell counts is not accepted in place
of an actual CW structure.

Suggested homes are `TauCeti/AlgebraicTopology/FundamentalGroupoid/`,
`TauCeti/AlgebraicTopology/Singular/`, `TauCeti/AlgebraicTopology/Cellular/`,
`TauCeti/AlgebraicTopology/Cohomology/`, and `TauCeti/AlgebraicTopology/Homotopy/`.

## Scope and completion criterion

The roadmap is complete when Tau Ceti supplies all of the following, with naturality and the
stated coefficient generality.

1. The fundamental-groupoid functor sends an open cover to the appropriate colimit and yields
   based van Kampen and presentation corollaries without connectedness assumptions on
   intersections.
2. Relative singular homology is a functor on `TopPair`, obtained through `SSetPair`, and satisfies
   the long exact sequence, homotopy invariance, excision, Mayer--Vietoris, dimension, and
   additivity axioms.
3. Mathlib's `CWComplex` and `RelCWComplex` structures have cellular chain complexes whose
   homology is naturally isomorphic to singular homology.  Cofibration, mapping-cylinder,
   cellular-approximation, and skeletal-induction APIs make those comparisons usable.
4. Mapping tori, finite covers, finite open covers, and fibre bundles have reusable chain-level
   tools: Wang and transfer sequences, Kunneth and torus calculations, and a finite-open-cover
   Čech double complex with its spectral sequence.
5. Singular cohomology, cup and cap products, integral fundamental classes, Poincare and
   Poincare--Lefschetz duality, and Euler characteristic are available in their standard
   functorial forms.
6. Relative homotopy groups, Hurewicz, Whitehead, and homological Whitehead are proved for CW
   complexes and then for spaces of CW type.  The cubical and Kan-simplicial models of homotopy
   groups are naturally compared rather than allowed to form separate incompatible APIs.

The scope includes the ordinary tools needed for compact manifolds and finite CW-type spaces.  It
does not include generalized cohomology theories, spectra, bordism, or surgery obstruction
groups.  Those theories consume this roadmap's chain, CW, duality, and homotopy interfaces.

## Ownership and dependencies

- The [universal-covers roadmap](../UniversalCovers/README.md) owns universal-cover
  construction, deck transformations, quotient covers, basepoint change, and induced maps on
  homotopy groups.  This roadmap consumes those maps, extends the higher-homotopy API with
  relative groups and comparison theorems, and does not construct another universal cover.
- The [geometric-topology roadmap](../GeometricTopology/README.md) owns smooth and PL
  triangulations, manifold boundaries and collars, gluing, connected sum, cobordism carriers,
  and geometric surgery.  This roadmap owns algebraic topology of CW pairs and proves results
  about any space of CW type.  A theorem that compact smooth manifolds have finite CW type
  consumes geometric topology's smooth-triangulation result.
- The [Heegaard Floer roadmap](../HeegaardFloer/README.md) owns the Mathlib-compatible manifold
  orientation and degree API.  This roadmap consumes it to construct integral fundamental
  classes and owns the chain-level proof and consequences of manifold duality.
- The [profinite-cohomology roadmap](../ProfiniteCohomology/README.md) owns continuous
  cohomology of profinite groups.  The singular cohomology here is cohomology of topological
  spaces; neither development introduces a second version of the other's objects.
- The high-dimensional differential-topology and homotopy-sphere roadmap consumes Hurewicz,
  Whitehead, duality, finite CW type, and the homology of spheres from this roadmap.  Stable
  homotopy, framed bordism, and the Kervaire--Milnor calculation live there.

## Encoding conventions

These choices are part of the specification.

- **Use Mathlib's categories.**  Spaces and maps live in `TopCat`; pairs live in `TopPair` and
  `SSetPair`; chains live in `ChainComplex`; exact sequences use the existing homological-complex,
  `ShortComplex`, and exactness APIs.  Do not bundle a space together with claimed homology.
- **Keep maps visible.**  Every induced map is the image of a continuous map, a pair map, or a
  chain map.  A result expressed only as unrelated equivalences in each degree is incomplete.
- **Work at natural coefficient generality.**  Singular chains and relative homology take a
  coefficient object in the appropriate preadditive category.  Module-valued corollaries state
  the ring and module hypotheses they use.  Integral specialization occurs only where
  orientations, torsion, degree, or Euler characteristic require it.
- **Use groupoids before groups.**  Van Kampen is first a colimit theorem for the fundamental
  groupoid on a set of basepoints.  The familiar based group theorem is derived under explicit
  path-connectedness hypotheses.  Disconnected intersections never acquire arbitrary paths.
- **Use actual CW structures.**  Cellular chains use `CWComplex.cell` and characteristic maps;
  relative statements use `RelCWComplex`.  Attaching degrees define differentials, and the proof
  that consecutive differentials compose to zero comes from the filtration exact couple.
- **Pin reduced and unreduced conventions.**  Reduced homology is the kernel of augmentation in
  degree zero and agrees with ordinary homology in positive degrees.  Relative homology of
  `(X, empty)` agrees naturally with ordinary homology.  All connecting morphisms use the
  homological grading convention `d : C_(n+1) -> C_n`.
- **Pin signs once.**  The singular boundary uses the alternating deletion convention.  The
  Mayer--Vietoris map from an intersection is `(i_U, -i_V)`, the cochain differential is induced
  by precomposition with the chain differential, and cup/cap signs follow the
  Alexander--Whitney convention.  Convention-checking examples below must compute with these
  signs.
- **Treat homotopy models by comparison.**  Mathlib's cubical `HomotopyGroup` remains a public
  interface.  Kan-simplicial homotopy groups are also constructed because they interact well
  with `TopCat.toSSet`; a natural comparison identifies the two, including induced maps,
  basepoint change, suspension, and relative boundary morphisms.
- **Finiteness is a hypothesis.**  Euler characteristic is defined for finite CW structures and
  extended to finite-CW-type spaces by transport and invariance.  Additivity and multiplicativity
  state the necessary cofibration, excision, and finite-generation hypotheses.

## Inventory: consume Mathlib and follow its interface direction

The development starts from these current APIs.

- `TopCat`, `TopCat.toSSet`, `SSet.chainComplex`, `singularChainComplexFunctor`, and
  `singularHomologyFunctor`.
- `TopPair`, `TopPair.ofSubset`, `TopPair.incl`, `TopPair.diag`, and the
  `TopPair.HomologyPretheory` classes already present at the dependency pin.
- `FundamentalGroupoid`, `FundamentalGroup`, induced maps, homotopy invariance, and Mathlib's
  covering and homotopy-lifting APIs.
- Abstract and classical `CWComplex`/`RelCWComplex`, subcomplexes, skeleta,
  `CWComplex.FiniteDimensional`, `CWComplex.FiniteType`, and `CWComplex.Finite`.
- `HomotopyGroup`, based cubes, `ContinuousMap.HomotopyEquiv`, mapping cones and pointed cones,
  category-theoretic colimits, chain homotopies, homology functors, and exact couples.

The following open Mathlib pull requests determine interfaces which are not wholly available at
the pin.  Import every declaration present at the pin.  Implement the rest in Tau Ceti now with
the same object and map shapes, then replace local code by imports when Mathlib supplies it.

- [mathlib4#41603](https://github.com/leanprover-community/mathlib4/pull/41603): the
  fundamental groupoid as a cosheaf and van Kampen as a colimit theorem.
- [mathlib4#41285](https://github.com/leanprover-community/mathlib4/pull/41285): relative
  simplicial homology through `SSetPair`.
- [mathlib4#38369](https://github.com/leanprover-community/mathlib4/pull/38369): the remaining
  Eilenberg--Steenrod axiom-class interfaces for `TopPair.HomologyPretheory`.
- [mathlib4#42435](https://github.com/leanprover-community/mathlib4/pull/42435): homotopy groups
  of Kan simplicial sets.
- [mathlib4#30109](https://github.com/leanprover-community/mathlib4/pull/30109) and
  [mathlib4#29792](https://github.com/leanprover-community/mathlib4/pull/29792): the lattice of
  CW subcomplexes and the colimit universal property of skeleta.
- [mathlib4#28246](https://github.com/leanprover-community/mathlib4/pull/28246): simple
  connectivity of spheres of dimension greater than one.

## Stage 1: van Kampen through the fundamental groupoid

This stage is independent of Stages 2--8.

1. For an open cover `U : i -> Opens X`, define the Cech diagram of all nonempty finite
   intersections, with inclusion functors between their fundamental groupoids.  State the cover
   either as a jointly-surjective family or by `iSup U = top`, following #41603's chosen shape.
2. Prove by subdivision of paths that every morphism in `FundamentalGroupoid X` is a composite of
   morphisms lying in cover members.  Prove by subdivision of homotopies that two such composites
   agree exactly under the Cech relations.
3. Construct the cocone to `FundamentalGroupoid X` and prove its colimit universal property,
   including naturality under maps of covered spaces and refinement of covers.
4. Derive the two-open-set pushout theorem and the based theorem when the two opens and their
   intersection are path connected and contain the basepoint.  Derive iterated finite-cover and
   group-presentation corollaries.
5. Check the groupoid theorem on a circle covered by two arcs with disconnected intersection and
   on a wedge of circles.  The first check must use more than one basepoint and the second must
   recover a free-group presentation.

The proof spine is Brown, *Topology and Groupoids*, Chapters 6--7: subdivision gives generation,
the square-grid subdivision of a homotopy gives relations, and the universal property identifies
the colimit.  Hatcher, *Algebraic Topology*, Section 1.2 supplies the based corollaries.

## Stage 2: relative singular chains and homology

1. Extend singular chains from `TopCat` to `TopPair` by applying the `SSetPair` relative-chain
   construction to `TopCat.toSSet`.  Exhibit the relative complex both as the quotient
   `C_*(X) / C_*(A)` and in the exact-sequence form selected by #41285, and prove the two forms
   naturally isomorphic.
2. Define the relative homology functor for coefficient objects in the natural preadditive
   category.  Prove functoriality, compatibility with composition, and the comparison
   `H_*(X, empty) ~= H_*(X)`.
3. Construct the short exact sequence of chain complexes for a pair and derive the natural long
   exact sequence, with its connecting morphism and naturality square.  Do the same for triples
   `B subset A subset X`.
4. Instantiate `TopPair.HomologyPretheory` and prove homotopy invariance, dimension, additivity,
   and reduced/unreduced comparison in the interface shape of #38369.
5. Calculate `(D^n,S^(n-1))`, a point, a discrete space, and a disjoint union.  These calculations
   fix the degree-zero and connecting-map conventions used in every downstream stage.
6. Define a local coefficient system as a functor from Mathlib's fundamental groupoid to the
   coefficient-module category.  Construct twisted singular chains and relative homology,
   pullback along maps, naturality, basepoint-change and monodromy formulas, and the comparison
   with ordinary homology for a constant system.  This uses the existing groupoid object and does
   not depend on Stage 1's van Kampen theorem.

The source spine is Eilenberg--Steenrod, *Foundations of Algebraic Topology*, Chapters I--III,
and Hatcher, Sections 2.1--2.2 and 3.H.  The Lean proof should pass through short exact sequences
of chain complexes and Mathlib's homology functor, rather than reconstructing an elementwise
exact sequence in every application.

## Stage 3: subdivision, excision, and Mayer--Vietoris

This stage consumes Stage 2.

1. Define affine subdivision of the standard simplex and barycentric subdivision of singular
   simplices in every degree.  Prove the boundary formula and construct the prism operator giving
   a chain homotopy from subdivision to the identity.
2. For an open cover, prove that every singular simplex becomes subordinate after sufficiently
   many subdivisions.  Turn the small chains into a subcomplex and prove its inclusion is a
   natural chain-homotopy equivalence.
3. Prove excision for `TopPair`: if the closure of the excised set lies in the interior of the
   subspace, the induced map on relative homology is an isomorphism.  Include maps of excision
   data and compatibility with the pair connecting morphism.
4. Apply excision to a binary open cover and construct the natural Mayer--Vietoris long exact
   sequence.  Prove that its first map is `(i_U, -i_V)` under the pinned sign convention.
5. Check Mayer--Vietoris on `S^1` from two arcs and on `S^n` from two hemispherical
   neighbourhoods, including the connecting isomorphism in top degree.

Hatcher, Proposition 2.21 and the proof of excision in Section 2.1 give the small-chain proof;
Section 2.2 gives Mayer--Vietoris.  Eilenberg--Steenrod supplies the natural formulation for
pairs.

## Stage 4: CW pairs, cellular homology, and cofibrations

This stage consumes Stages 2 and 3.

1. Use Mathlib's characteristic maps and skeleta to define the cellular group in degree `n` as
   the relative homology of consecutive skeleta.  Identify it naturally with the free module on
   `CWComplex.cell C n`, with finite-support rather than finite-cell assumptions in the general
   definition.
2. Define the cellular differential as the connecting map in the triple of three consecutive
   skeleta.  Prove `d^2=0`, identify its matrix entries with degrees of attaching maps, and prove
   naturality for cellular maps.
3. Construct the skeletal filtration exact couple and prove the cellular-to-singular comparison
   as a natural quasi-isomorphism.  Extend it to `RelCWComplex` and subcomplex pairs.
4. Prove finite-CW Euler--Poincare and finite-generation consequences from the cellular complex.
5. Prove that relative CW inclusions are closed cofibrations with the homotopy extension
   property.  Construct mapping cylinders, cellular approximation, and skeletal induction.
   Prove that a cofibration which is a homotopy equivalence is a strong deformation retract.
6. Calculate projective spaces in their cellular ranges and a two-cell complex whose attaching
   map has degree `m`; its cellular differential must be multiplication by `m`.

Hatcher, Sections 0.4 and 2.2, supplies CW pairs, cellular approximation, and cellular homology.
Whitehead, *Elements of Homotopy Theory*, Chapters II--IV, supplies cofibrations, mapping
cylinders, and skeletal induction.  The categorical implementation follows Mathlib's actual
skeleta and their colimit maps rather than a parallel cell-filtration record.

## Stage 5: bundles, covers, products, and finite-cover descent

This stage consumes Stages 2--4.

1. Construct the Alexander--Whitney and Eilenberg--Zilber maps for singular chains, the shuffle
   map, and the chain homotopies proving they are inverse up to homotopy.  Derive the homological
   cross product and Kunneth theorem with the exact `Tor` term and flatness hypotheses.
2. Derive the Wang long exact sequence for a mapping torus from a mapping-cone model.  Identify
   its endomorphism as `id - f_*`, and prove naturality under commuting squares of monodromies.
3. For a finite covering, construct transfer on chains by summing lifts.  Prove
   `p_* transfer = degree * id`, identify invariants and coinvariants under a regular deck action,
   and prove compatibility with composition of finite covers.
4. Calculate homology of finite products of circles as exterior powers, naturally under integer
   matrices acting on the first homology.  This is a theorem about the product and Kunneth maps,
   not a separately declared answer for a torus.
5. For a fibre bundle `F -> E -> B` with finite-CW base, filter the total space by inverse images
   of the base skeleta.  Construct the homology Serre spectral sequence with the monodromy local
   coefficient system `H_q(F;R)`, prove naturality under bundle maps and convergence under the
   stated boundedness and finite-type hypotheses, and identify
   `E^2_(p,q) = H_p(B; H_q(F;R))`.  Recover the product calculation under trivial monodromy and
   derive Euler-characteristic multiplicativity when base and fibre have finite CW type.
6. For an ordered finite open cover, construct the double complex
   `directSum_(i_0<...<i_p) C_q(U_(i_0...i_p);R)`.  Define the alternating Cech differential by
   dropping one index and the vertical singular differential with the total-complex sign.
7. Use Stage 3's small-chain theorem to prove that the augmented total complex is naturally
   quasi-isomorphic to singular chains.  Construct its first-quadrant spectral sequence,
   bounded by the cover cardinality, with
   `E^1_(p,q) = directSum H_q(U_(i_0...i_p);R)` and prove natural convergence.

Eilenberg--Zilber and Eilenberg--Mac Lane's acyclic-model proof, Hatcher Sections 3.B and 4.G,
and McCleary, *A User's Guide to Spectral Sequences*, Chapters 1--2, form the source spine.  The
mapping-torus calculation follows the mapping-cone derivation of the Wang sequence; transfer
follows Hatcher Section 3.G, and the bundle filtration follows Serre's skeletal construction.

## Stage 6: cohomology, products, and manifold duality

This stage consumes Stage 2 and the product maps of Stage 5.  Its manifold statements also
consume the orientation-and-degree API owned by Heegaard Floer and the boundary/collar
conventions owned by geometric topology.

1. Define absolute and relative singular cochains by applying `Hom` to singular chains.  Extend
   the construction to Stage 2's local coefficient systems and their duals.  Prove functoriality,
   the long exact sequence, homotopy invariance, additivity, constant-system comparison, and the
   universal coefficient short exact sequence with naturality and splitting consequences.
2. Use Alexander--Whitney to define cup products and Eilenberg--Zilber to compare them with cross
   products.  Define cap products, including tensor pairings of local coefficient systems, and
   prove naturality, associativity, the unit law, graded signs, and the boundary formula.
3. Construct local orientation classes and the orientation local system.  For an oriented compact
   manifold, construct the integral fundamental class, prove uniqueness under the chosen
   orientation, and identify its boundary with the induced boundary orientation.
4. Prove Poincare duality by cap product for closed oriented manifolds and
   Poincare--Lefschetz duality for compact oriented manifolds with boundary.  Include coefficients
   in a field and in the orientation local system, then derive the integral orientable form.
5. Derive top-degree homology, the homological characterization and duality formulas for the
   shared manifold degree, intersection pairings, torsion linking, and universal-coefficient
   consequences through the natural duality maps.  Do not define a competing degree invariant.

The proof spine is Hatcher Sections 3.1--3.3 for cohomology operations and duality, and Dold,
*Lectures on Algebraic Topology*, Chapters VII--VIII for natural products and local coefficients.
Collars fix the boundary sign; orientation is never reconstructed from a hand-written chart list.

## Stage 7: Euler characteristic and finite decompositions

This stage consumes every one of Stages 2--6.  Stage 1 is not a prerequisite.

1. Define Euler characteristic of a finite CW complex as the alternating sum of cell numbers and
   prove equality with the alternating rank of homology over a field.  Transport it to spaces of
   finite CW type and prove independence of the chosen model.
2. Prove homotopy invariance, product multiplicativity, and multiplicativity for fibre bundles
   with finite-CW base and fibre.  The bundle theorem must be derived from Stage 5's chain or
   spectral-sequence machinery.
3. Prove finite-cover multiplicativity from transfer and additivity for finite excisive
   decompositions from Mayer--Vietoris.  Prove cellular-stratification additivity from the
   relative cellular filtration.
4. State cofibration, compactness, and finiteness assumptions explicitly.  Establish the standard
   checks `chi(S^n)=1+(-1)^n`, `chi(T^n)=0` for `n>0`, and
   `chi(CP^n)=n+1`.

## Stage 8: relative homotopy, Hurewicz, and Whitehead

This stage consumes Stages 2--4, the universal-covers roadmap's induced-map and basepoint API,
and geometric topology's smooth-triangulation result for the manifold corollaries.

1. Extend cubical `HomotopyGroup` with pointed maps, functoriality, basepoint change, relative
   homotopy groups, and the long exact sequence of a based pair.  State relative groups for NDR
   pairs/cofibrations, rather than attaching them to arbitrary inclusions without hypotheses.
2. Following #42435, construct homotopy groups of Kan simplicial sets, prove
   `TopCat.toSSet.obj X` is Kan, and compare these groups naturally with cubical homotopy groups.
   Prove compatibility with induced maps, boundary maps, and basepoint change.
3. Construct the Hurewicz homomorphism.  Prove the absolute theorem: an `(n-1)`-connected pointed
   space has reduced integral homology zero below `n` and `pi_n(X) ~= H_n(X;Z)` for `n>=2`.
4. Prove relative Hurewicz for a based cofibration/NDR pair.  If `A` and `X` are simply connected
   and `pi_i(X,A)=0` for `i<n`, prove `H_i(X,A;Z)=0` below `n` and that relative Hurewicz is an
   isomorphism in degree `n`.  Derive the exact isomorphism and surjectivity range for
   `H_i(A)->H_i(X)` from the pair sequence.
5. Prove Whitehead's theorem for CW complexes using cellular approximation and skeletal
   induction.  Combine relative Hurewicz with the mapping cylinder to prove homological
   Whitehead for simply connected CW complexes, then extend both results to spaces of CW type.
6. Construct the pointed orientation-normalized homeomorphism from the cube modulo its boundary
   to Mathlib's metric sphere and prove compatibility with cubical representatives.
7. Prove that a compact Hausdorff second-countable smooth manifold is of finite CW type by
   consuming smooth triangulation.  As a reusable corollary, prove that a simply connected
   integral homology `n`-sphere, `n>=2`, is homotopy equivalent to the standard `S^n`.

Hatcher Section 4.1 gives the absolute Hurewicz and Whitehead arguments; Whitehead, Chapters
IV--VII, gives the relative and cellular forms.  May, *Simplicial Objects in Algebraic Topology*,
Chapters 3 and 12, supplies the Kan-group construction and comparison route.

## Dependency order

| Stage | Depends on | Can proceed alongside |
| --- | --- | --- |
| 1 van Kampen | current Mathlib and #41603's shape | 2--8 |
| 2 relative homology | current Mathlib and #41285/#38369's shapes | 1 |
| 3 subdivision/excision | 2 | 1 and 6's cochain foundations |
| 4 CW/cellular | 2--3 | 1 |
| 5 bundles/covers/finite covers | 2--4 | 1 |
| 6 cohomology/duality | 2, Stage 5 product maps, external orientation/collars | 1 |
| 7 Euler characteristic | 2--6 | 1 |
| 8 Hurewicz/Whitehead | 2--4 and the cited external roadmaps | 1, 5--7 |

In particular, Stage 1 is independent; the chain `2 -> 3 -> 4` is strict; Stages 2--4 all feed
Stage 5; and every stage from 2 through 6 feeds Stage 7.  No implementation may reverse one of
these arrows by assuming a downstream comparison theorem as input.

## Acceptance checks

- A two-open-set cover with disconnected intersection is handled by the groupoid colimit and
  yields the correct based theorem only after explicit basepoints are chosen.
- Relative homology of `(D^n,S^(n-1))` and the connecting morphism to the sphere generator have
  the pinned sign.
- Mayer--Vietoris is derived from excision and agrees with the map induced by inclusions; it is
  not supplied as an unrelated exact sequence.
- The cellular differential of a two-cell attachment of degree `m` is multiplication by `m`,
  and cellular homology compares naturally with singular homology.
- Transfer for a degree-`d` finite cover satisfies `p_* transfer = d * id`, including degree
  zero, and the torus calculation is natural under integer matrices.
- The Serre spectral sequence exposes the monodromy local system, specializes to the product
  calculation for trivial monodromy, and proves finite-CW bundle Euler multiplicativity.
- Poincare--Lefschetz duality uses the boundary orientation from the shared manifold API and
  produces the correct sign in the cap-product boundary formula.
- Euler characteristic gives the standard values on spheres, tori, and complex projective
  spaces and proves both additivity and finite-cover multiplicativity from earlier maps.
- Homological Whitehead produces a homotopy inverse to the given homology equivalence between
  simply connected CW-type spaces; it does not merely assert that some unrelated equivalence
  exists.

## References

- Ronald Brown, *Topology and Groupoids*, 3rd ed., Booksurge, 2006, Chapters 6--7.
- Samuel Eilenberg and Norman Steenrod, *Foundations of Algebraic Topology*, Princeton
  University Press, 1952, Chapters I--III.
- Allen Hatcher, [*Algebraic Topology*](https://pi.math.cornell.edu/~hatcher/AT/AT.pdf),
  Sections 0.4, 1.2, 2.1--2.2, 3.1--3.3, 3.B, 3.G--3.H, 4.1, and 4.G.
- George W. Whitehead, *Elements of Homotopy Theory*, Springer GTM 61, 1978,
  Chapters II--VII.
- Albrecht Dold, *Lectures on Algebraic Topology*, Springer, 1972, Chapters VII--VIII.
- J. Peter May, *Simplicial Objects in Algebraic Topology*, University of Chicago Press, 1967,
  for Kan complexes, simplicial homotopy groups, and comparison with realization.
- Jean-Pierre Serre, *Homologie singulière des espaces fibrés. Applications*, Annals of
  Mathematics 54 (1951), 425--505, for the homology spectral sequence of a fibration.
- John McCleary, *A User's Guide to Spectral Sequences*, 2nd ed., Cambridge University Press,
  2001, Chapters 1--2.

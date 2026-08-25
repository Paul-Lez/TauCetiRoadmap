# Roadmap: a complex structure on the six-sphere

The endpoint of this roadmap is an **integrable complex-manifold structure on the standard
smooth six-sphere**.  Following the
[construction paper](https://alpo.ge/s6.pdf), start with a family of complex two-tori over the
`(3,4,∞)` orbifold, fill its cusp by an infinite toric model, fill the two elliptic points by
logarithmic transforms, and glue the four pieces to a compact complex threefold `X`.  The twist
parameters `(ell_0, ell_1, ell_2) = (0, 1, -1)` make `X` simply connected with the integral
homology of `S^6`; smooth recognition then identifies `X` with the standard sphere.

This is a library roadmap.  It builds the reusable complex-manifold, quotient, gluing,
singular-homology, van Kampen, h-cobordism, and homotopy-sphere theory needed to make every arrow
in that argument a theorem.  Intermediate mathematical conclusions are exposed through standard
Mathlib and Tau Ceti objects and theorem statements, not through construction-specific contract
structures whose fields assume those conclusions.

Suggested homes:

- `TauCeti/Geometry/Manifold/Complex/` for realification and compatible open gluing;
- `TauCeti/Geometry/Manifold/Quotient/` for smooth and complex quotients by group actions;
- `TauCeti/Geometry/Toric/` for locally finite smooth complex fans and their analytic toric
  manifolds;
- `TauCeti/AlgebraicTopology/` for van Kampen, relative singular homology, excision,
  Mayer--Vietoris, cellular comparison, and the Hurewicz--Whitehead bridge;
- `TauCeti/Geometry/Manifold/HomotopySphere/` for smooth h-cobordism, homotopy spheres,
  `Theta_n`, and the Kervaire--Milnor calculation;
- `TauCeti/SphereSix/` only for the explicit monodromy, periods, fillings, four-piece assembly,
  and final calculation special to this construction.

## Scope and completion criterion

The mathematical scope is Sections 2--8 and the topological cell data in Appendices A--B of the
paper.  Sections 9--10 -- algebraic dimension, coherent cohomology, the global canonical bundle
and Chern numbers of `X`, automorphisms, and the comparison with Campana--Demailly--Peternell -- lie outside this
roadmap.  They are not prerequisites for a complex structure on `S^6` and would require a
separate complex-analytic and coherent-sheaf development.

The roadmap is complete when Tau Ceti proves all of the following without unproved
construction-specific axioms.

1. There is a type `X` with the ordinary Mathlib instances for a compact connected complex
   manifold of complex dimension three, and a holomorphic map `f : X -> P^1` obtained from the
   four stated pieces.  Over the thrice-punctured base its fibres are complex two-tori; the cusp
   and order-3 and order-4 fibres have the descriptions in the paper.
2. For the chosen twists, the canonical map-level calculations give `pi_1(X) = 0`,
   `H_0(X; Z) = Z`, `H_6(X; Z) = Z`, and `H_k(X; Z) = 0` for `k != 0,6`.  These are theorems
   about the constructed maps and spaces, not fields supplied to a record.
3. The Hurewicz and Whitehead machinery chooses a representative `S^6 -> X` of a generator of
   `pi_6(X)`, proves that this map induces the required homology isomorphisms, and produces a
   homotopy equivalence `X ~=_h S^6`.
4. A geometric construction of the group `Theta_n`, the smooth h-cobordism theorem, and the
   Kervaire--Milnor sequence prove `Theta_6 = 0` and hence a direct diffeomorphism from the
   compact Hausdorff second-countable smooth manifold `X` to the standard `S^6`.
5. The complex atlas on `X` is realified, recharted against Mathlib's standard real
   six-dimensional model, and transported across the resulting diffeomorphism.  Thus the final
   declaration equips Mathlib's actual `Metric.sphere (0 : EuclideanSpace R (Fin 7)) 1` with a
   complex atlas and proves it is a complex manifold.  An existential wrapper which merely
   stores an unspecified carrier and a claimed compatibility is not the endpoint.

## Ownership and dependencies

- The [geometric-topology roadmap](../GeometricTopology/README.md) owns manifolds with boundary,
  orientations, collars, general boundary gluing and handle attachment, general framed surgery,
  connected sum, cobordism foundations, and smooth triangulation.  This roadmap consumes those objects,
  contributes the open-gluing theorem for compatible structure-groupoid atlases, and owns Morse
  handle decompositions, the high-dimensional h-cobordism theorem, framed-surgery arguments for
  homotopy spheres, and the homotopy-sphere calculation needed for smooth recognition.  It does
  not define a second collar, handle, surgery operation, boundary-gluing, or triangulation API.
- The [universal-covers roadmap](../UniversalCovers/README.md) owns universal covers, deck groups,
  quotient covers, and induced maps on homotopy groups.  This roadmap consumes the corresponding
  Tau Ceti modules for the Fuchsian and torus quotients; it does not package another equivariant
  universal cover.
- The [conformal-mapping roadmap](../ConformalMapping/README.md) owns the Riemann mapping theorem,
  analytic continuation and Schwarz reflection; holomorphic logarithms and roots consume
  Mathlib's `Analysis/Complex/BranchLogRoot.lean` API.  The
  [modular-forms roadmap](../ModularForms/README.md) owns Mathlib-compatible modular forms,
  Hecke theory, analytic modular curves for congruence subgroups, and the normalized level-one
  `j`-function with its exact elliptic orders, the reusable Riemann-sphere atlas on `OnePoint C`,
  and `X(1) ≃ P^1`.  This roadmap consumes those libraries and owns the particular
  `(3,4,∞)` Fuchsian orbifold, its comparison with the level-one modular curve, and the three
  period functions required by this family.
- The [Hodge-structures roadmap](../HodgeStructures/README.md) concerns abstract pure and mixed
  Hodge structures.  Here the periods are an explicit weight-one rank-four family, so no general
  variation-of-Hodge-structure API is introduced.
- The [integral-lattices roadmap](../IntegralLattices/README.md) concerns lattices carrying
  rational symmetric bilinear forms and their discriminant forms.  The abstract monodromy module
  here is a free `Z`-module with a representation, and a fibre lattice is a discrete full
  `Submodule Z` of the underlying real vector space of `C^2`; neither is renamed as that
  roadmap's bilinear lattice.
- The [Heegaard Floer roadmap](../HeegaardFloer/README.md), Lanes M and F0, owns
  finite-dimensional Sard, Morse functions, stable and unstable manifolds, and Morse--Smale
  transversality.  Layer 9 consumes that substrate and owns the handle-decomposition,
  cancellation, Whitney, and h-cobordism consequences.  Heegaard Floer also owns general
  almost-complex and pseudoholomorphic-curve analysis; this roadmap constructs an integrable
  atlas by holomorphic charts and transition maps and does not duplicate that theory.

## Encoding conventions: standard public interfaces

These conventions are acceptance conditions for every layer.

- **Manifolds are types with standard instances.**  Use `TopologicalSpace`, `ChartedSpace`,
  `IsManifold`, `CompactSpace`, `ConnectedSpace`, and Mathlib's separation classes.  Do not expose
  a bespoke record containing a carrier, topology, atlas, compactness, and theorem fields.
- **Use structure groupoids for atlases.**  Cross-chart compatibility is expressed with
  `StructureGroupoid`, `HasGroupoid`, `Structomorph`, and `IsLocalDiffeomorph`.  Mathlib's
  `PartialDiffeomorph` is documented as an auxiliary implementation detail and is not a public
  interface.  A biholomorphism between open subspace types is a `Diffeomorph`; an unbundled local
  map carries `IsLocalDiffeomorph`.
- **Use Mathlib quotients and additive actions.**  A lattice acting by translations uses
  `AddAction`, `ProperlyDiscontinuousVAdd`, `ContinuousConstVAdd`,
  `AddAction.orbitRel.Quotient`, and `IsAddQuotientCoveringMap`.  Other group actions use the
  multiplicative counterparts.  Do not introduce a tagged copy of an orbit quotient, a
  choice-based quotient section, or an alias for `Quotient.mk`.
- **Use representations and duality functorially.**  The monodromy is a standard
  `Representation Z Delta V`.  Dual, exterior-power, invariant, coinvariant, and Wang actions
  are derived from the representation and Tau Ceti's representation-theory API.  Explicit
  matrices are coordinate theorems relative to a chosen `Basis`; they are not a parallel
  representation dialect.
- **Distinguish the two lattices.**  The monodromy lattice is a free module.  For each period
  point, the embedded period group is a `Submodule Z (EuclideanSpace C (Fin 2))`, discrete and an
  `IsZLattice R` after restriction of scalars.  Prove its rank, discreteness, closedness,
  cocompactness, and behaviour under the monodromy action.  Do not replace full rank by a record
  carrying a chosen continuous linear equivalence.
- **State bounds directly.**  A quantitative cusp bound has the form
  `exists C, forall z in U, norm (mu z) <= C`; a qualitative bounded image uses
  `Bornology.IsBounded`.  No new one-line predicate wrapper is added.
- **Homology is functorial.**  Use `TopCat.toSSet`, the singular chain and homology functors,
  `TopPair`/`SSetPair`, chain maps, exact triangles or `ShortComplex`, and natural
  transformations.  A comparison must be induced by a map or a chain homotopy equivalence.  A
  family of unrelated degreewise group equivalences is not a substitute, and desired homology
  conclusions are not packaged as record or typeclass fields.
- **Generic topology is proved as generic topology.**  Van Kampen is a colimit theorem for the
  fundamental groupoid functor on an open cover.  Excision and Mayer--Vietoris are statements for
  pairs and arbitrary coefficients at their natural level.  Hurewicz and Whitehead are not
  six-sphere-specific obligation predicates.
- **Recognition objects are geometric.**  `Theta_n` is formed from oriented smooth homotopy
  spheres and oriented h-cobordisms, with connected sum.  Its relation is not an arbitrary
  supplied `Setoid`, and the Kervaire--Milnor sequence is not a structure whose fields assume
  exactness.  `Theta_6 = 0` is a theorem about the constructed group.
- **Paper data stays at the leaves.**  Small structures may collect the explicit matrices,
  chosen twists, or a fan once their laws have been proved.  No structure may turn the final
  gluing, fundamental-group result, homology result, or recognition result into an input field.

## Inventory: consume Mathlib and Tau Ceti

The development starts from the following existing Mathlib APIs and explicitly cited outputs of
sibling Tau Ceti roadmaps.

- `TopCat.GlueData` in `Mathlib/Topology/Gluing.lean`, including the glued space, canonical open
  embeddings `D.toGlueData.ι i` with theorem `D.ι_isOpenEmbedding i`, the open-set criterion,
  and its colimit universal property.
- `ChartedSpace`, `StructureGroupoid`, `HasGroupoid`, `contDiffGroupoid`, `Diffeomorph`, and
  `IsLocalDiffeomorph`; Mathlib's charted-space instance for a free properly discontinuous
  quotient in `Geometry/Manifold/Instances/Quotient.lean`.
- `ProperlyDiscontinuousSMul`/`ProperlyDiscontinuousVAdd`,
  `IsQuotientCoveringMap`/`IsAddQuotientCoveringMap`, and Mathlib's quotient-cover theorems,
  together with the universal-cover roadmap's deck-transformation and quotient-cover targets.
- `UpperHalfPlane`, its complex-manifold and Moebius-action API, modular forms and cusp
  expansions, the normalized level-one Eisenstein series `ModularForm.E₄` and `ModularForm.E₆`, the
  modular discriminant, `ModularForm.discriminant_eq_E₄_cube_sub_E₆_sq`, and the discriminant's
  nonvanishing and `q`-expansion theorems; Mathlib's complex analytic functions, locally uniform
  convergence, and `BranchLogRoot` API; together with the conformal-mapping roadmap's
  analytic-continuation targets and the modular-forms roadmap's `j`-function and analytic
  modular-curve targets.
- `OnePoint C` and the underlying set equivalence `OnePoint.equivProjectivization` from
  `Mathlib/Topology/Compactification/OnePoint/ProjectiveLine.lean`; the modular-forms roadmap
  equips this carrier with the standard two-chart complex-manifold structure called `P^1`.
- `Submodule`, `Basis`, `Matrix`, `Representation`, `Monoid.Coprod`, exterior powers, and
  `IsZLattice` in `Mathlib/Algebra/Module/ZLattice/Basic.lean`; Mathlib's
  `Submodule.smithNormalForm`; Tau Ceti's
  `TauCeti.RepresentationTheory.ExteriorPower`, including `Representation.exteriorPower` and the
  functorial intertwining/equivalence maps; and
  `TauCeti.LinearAlgebra.Matrix.SmithNormalForm`.
- `PointedCone`, `PointedCone.FG`, `PointedCone.DualFG`, `PointedCone.IsFaceOf`, and
  `PointedCone.Face` in `Mathlib/Geometry/Convex/Cone/`; the toric layer extends these with
  integral rationality, fans, affine semigroups, and analytic realizations rather than defining
  a second cone theory.
- `TopCat.toSSet`, `SSet.chainComplex`, `singularChainComplexFunctor`,
  `singularHomologyFunctor`, `TopPair`, `TopPair.HomologyPretheory` and the existing
  `TopPair.HomologyPretheory.IsHomotopyInvariant` class, Mathlib's abstract and classical
  CW-complex APIs including `RelCWComplex.Subcomplex` and `RelCWComplex.skeletonLT`, fundamental
  groups/groupoids, covering spaces, and cubical homotopy groups.
- The manifold sphere instances and the intended smooth-recognition vocabulary in
  `Mathlib/Geometry/Manifold/PoincareConjecture.lean`, and
  `exists_embedding_euclidean_of_compact` from Mathlib's compact Whitney embedding theorem.
  The existing `ContinuousMap.HomotopyEquiv.NonemptyDiffeomorphSphere` proposition quantifies
  only over `ChartedSpace` and `IsManifold`; those classes do not supply Hausdorffness,
  second-countability, or compactness.  Layer 9 therefore proves the mathematically valid direct
  theorem with these hypotheses rather than claiming the unrestricted proposition.
- The geometric-topology roadmap's manifold-boundary, collar, handle, connected-sum, cobordism,
  orientation, and smooth-triangulation targets; the universal-covers roadmap's pointed induced
  homotopy-group maps.

The following Mathlib pull requests determine the target shape of interfaces not wholly available
at the dependency pin.  Import every declaration present at the pin; implement the remaining
interface locally in the same shape, and replace that implementation by imports when it lands.

- [mathlib4#40727](https://github.com/leanprover-community/mathlib4/pull/40727) extends the
  properly-discontinuous quotient instance from `ChartedSpace` to `IsManifold`.  The local
  version must use the same orbit quotient and hypotheses, and also prove the projection is a
  local diffeomorphism.
- [mathlib4#42847](https://github.com/leanprover-community/mathlib4/pull/42847) gives
  homeomorphism pullback/transport of charted spaces and structure groupoids.  Realification and
  atlas transport follow that direction.
- [mathlib4#35376](https://github.com/leanprover-community/mathlib4/pull/35376) develops
  `Manifold.Orientation`, `Orientable`, `OrientedManifold`, and `OrientationLift` using signs of
  `tangentCoordChange`.  Geometric topology Layer 1 builds that interface in the same shape;
  consume `OrientationLift.compatible_of_det` here to prove that a complex atlas induces its
  canonical real orientation, and do not retain a chart-list-specific orientation certificate.
- [mathlib4#31350](https://github.com/leanprover-community/mathlib4/pull/31350) proposes the
  intended shape of manifold bordisms and boundary identifications.  The geometric-topology
  roadmap owns the compatible collared bordism category; Layer 9 adds the h-cobordism property,
  theorem, and homotopy-sphere application rather than a competing bordism type.
- [mathlib4#41603](https://github.com/leanprover-community/mathlib4/pull/41603) develops the
  fundamental groupoid as a cosheaf and a van Kampen colimit theorem.  Tau Ceti builds the
  theorem in that shape rather than assuming it.
- [mathlib4#41285](https://github.com/leanprover-community/mathlib4/pull/41285) develops relative
  simplicial homology via `SSetPair`, while
  [mathlib4#38369](https://github.com/leanprover-community/mathlib4/pull/38369) determines the
  remaining Eilenberg--Steenrod axiom-class interfaces beyond the homotopy-invariance class
  already at the pin.  Relative singular homology and excision below adopt these shapes and
  instantiate Mathlib's existing `TopPair.HomologyPretheory` API.
- [mathlib4#28246](https://github.com/leanprover-community/mathlib4/pull/28246) proves spheres of
  dimension greater than one simply connected.  The target is the same general result rather
  than a private `S^6` version.
- [mathlib4#42435](https://github.com/leanprover-community/mathlib4/pull/42435) develops homotopy
  groups for Kan simplicial sets.  The topological road below also proves that singular
  simplicial sets are Kan and compares this construction with Mathlib's cubical
  `HomotopyGroup`; the pull request alone does not yet supply homotopy groups of spaces.
- [mathlib4#30109](https://github.com/leanprover-community/mathlib4/pull/30109) and
  [mathlib4#29792](https://github.com/leanprover-community/mathlib4/pull/29792) extend the existing
  CW-subcomplex and skeleton API with, respectively, the completely distributive lattice of
  subcomplexes and the categorical colimit universal property of the skeleta.  Layer 7 follows
  those actual CW structures when it adds cellular chains and the cellular-to-singular
  comparison.

## Layer 0: general complex-manifold transport, quotient, and open gluing

This layer provides the common atlas and quotient interfaces used by every later construction.

1. **Restriction of scalars for manifolds.**  For a boundaryless complex model `I` on a
   finite-dimensional complex normed space `E`, construct its underlying real model on the same
   carrier, prove that complex-differentiable coordinate changes are real smooth, and turn an
   `IsManifold I infinity M` instance into an `IsManifold I_R infinity M` instance.  Prove
   functoriality for holomorphic maps, biholomorphisms, products, open subspaces, and restrictions.
2. **Recharting.**  Transport a model and atlas along a real `ContinuousLinearEquiv`; prove the
   resulting identity map is a diffeomorphism and that recharting commutes with products and open
   restrictions.  Specialise the general theorem to identify the realification of
   `EuclideanSpace C (Fin 3)` with Mathlib's `EuclideanSpace R (Fin 6)`.
3. **Smooth quotients.**  Complete the API suggested by mathlib4#40727: a smooth free properly
   discontinuous action produces the standard orbit quotient with `IsManifold`; `Quotient.mk` is
   a covering map and local diffeomorphism; invariant smooth maps descend, and smooth maps out of
   the quotient are characterised after precomposition with the projection.  Give the additive
   translation-action version by `to_additive`.  Prove the analogous complex-manifold and
   holomorphic descent statements.
4. **Compatible atlases on `TopCat.GlueData`.**  Given manifold structures on every `D.U i` and
   structure-groupoid-compatible transition maps on every `D.V (i,j)`, construct one
   `ChartedSpace` on `D.toGlueData.glued`, prove `HasGroupoid` and `IsManifold`, and prove each
   canonical `D.toGlueData.ι i` is an open local diffeomorphism.  Establish uniqueness up to the
   identity diffeomorphism and functoriality under maps of gluing data.  Smooth and complex gluing
   are corollaries of this one structure-groupoid theorem.
5. **Holomorphic line bundles.**  Extend Mathlib's `FiberBundle`, `VectorBundle`, and
   `ContMDiffVectorBundle` APIs over a complex base with line bundles presented by holomorphic
   `C^*`-valued transition cocycles.  Prove cocycle gluing and change-of-trivialization,
   pullback, dual, tensor product and tensor powers, the trivial-bundle criterion, and the
   equivalence between cocycle isomorphisms and holomorphic bundle equivalences.  For a smooth
   complex hypersurface, construct its holomorphic normal line bundle from transverse charts and
   identify its transition cocycle; construct determinant bundles and the canonical line bundle
   from the holomorphic cotangent transition cocycle.  Layer 6 uses this API to state and prove
   the exact orders of the multiple fibres' normal and canonical bundles.
6. **Finite star gluings as an application.**  Express the four-piece star used below as an
   ordinary finite `TopCat.GlueData`.  Prove second countability from a finite index type and
   second-countable pieces, Hausdorffness from the closed-graph conditions on the generated
   equivalence relation, and connectedness from connected pieces whose nonempty-overlap graph is
   connected.  Separately prove that properness is local on the target of a continuous map to a
   Hausdorff space, using finite closed refinements over each compact subset, and that a proper map
   to a compact base has compact domain.  Layer 6 proves the local properness of the actual
   `f : X -> P^1`; compactness is not inferred merely from an open gluing.  These are generic
   finite-gluing and proper-map theorems, rather than a structure dedicated to four-piece gluing.

## Layer 1: the rank-four representation and its integral algebra

Fix `V = Fin 4 -> Z` with the ordered basis `(gamma,u,w,delta)`.  Define
`T_1,T_2 : V ≃ₗ[Z] V` by

`T_1(gamma)=gamma`, `T_1(u)=-u-w`, `T_1(w)=-6*gamma+u`,
`T_1(delta)=2*gamma+u+w+delta`,

`T_2(gamma)=gamma`, `T_2(u)=6*gamma+w`, `T_2(w)=-u`, and
`T_2(delta)=-3*gamma+u+delta`.

Make their matrices in the stated ordered basis coordinate theorems.  Use the convention
`(T_1*T_2)(v)=T_1(T_2(v))`, set `T_0 = (T_1*T_2)^(-1)`, and prove by computation:

- `det T_1 = det T_2 = 1`, exact orders `3` and `4`, `T_0 = 1+N`, and `N^2=0`; moreover
  `ker(T_0-1)=range(T_0-1)=span_Z{gamma,u}`,
  `ker(T_1-1)=span_Z{gamma,2*u+w+3*delta}`, and
  `range(T_1-1)=span_Z{-2*u-w,-6*gamma+u-w,2*gamma+u+w}`, while
  `ker(T_2-1)=span_Z{gamma,u+w+2*delta}` and
  `range(T_2-1)=span_Z{6*gamma-u+w,-u-w,-3*gamma+u}`;
- the abstract triangle group `Delta = C_3 * C_4`, its universal property, and the
  representation `rho_V : Representation Z Delta V` carrying the two generators to `T_1,T_2`;
- the dual representation on `Lambda = Module.Dual Z V`, with dual basis
  `(gammaHat,uHat,wHat,deltaHat)`, named
  `rho_Lambda : Representation Z Delta Lambda`, generator equivalences
  `A_j=rho_Lambda(g_j)`, and `M_0=rho_Lambda(g_0)`, the contragredient of `T_0`; define
  `gammaCoeff : Lambda ->ₗ[Z] Z` by
  `gammaCoeff(lambda)=lambda(gamma)`, and prove the coordinate matrices and the exact submodules
  `ker(A_1-1)=span_Z{epsilon,deltaHat}`,
  `range(A_1-1)=span_Z{6*uHat-6*wHat-2*deltaHat,-uHat-wHat+deltaHat,uHat-2*wHat}`,
  `ker(A_2-1)=span_Z{epsilon',deltaHat}`,
  `range(A_2-1)=span_Z{-6*wHat+3*deltaHat,-uHat+wHat,-uHat-wHat+deltaHat}`, and
  `ker(M_0-1)=range(M_0-1)=span_Z{wHat,deltaHat}`, together with the coinvariants, saturation,
  and Smith normal forms used in Sections 4 and 7;
- `Lambda_tor = ker(M_0-1) = range(M_0-1)`, the quotient
  `LambdaBar = Lambda ⧸ Lambda_tor`, the induced unimodular equivalence
  `B_0 : LambdaBar ≃ₗ[Z] Lambda_tor`, the factorization of `gammaCoeff` through
  `gammaBarCoeff : LambdaBar ->ₗ[Z] Z`, and the two vectors fixed by their respective elliptic
  stabilizers
  `epsilon=gammaHat+2*uHat-4*wHat` and
  `epsilon'=gammaHat+3*uHat-3*wHat`; prove
  `A_1(epsilon)=epsilon`, `A_2(epsilon')=epsilon'`, and
  `gammaCoeff(epsilon)=gammaCoeff(epsilon')=1`;
- the alternating form `Q_0` with matrix
  `[[0,0,0,1],[0,0,6,0],[0,-6,0,0],[-1,0,0,0]]` in the ordered basis, its invariance under
  `T_1,T_2`, its basis-independent invariance theorem, and the classification that every
  invariant integral alternating form is an integer multiple of `Q_0`;
- functorial induced actions on `ExteriorAlgebra`/exterior powers and all integer matrices used by
  the Wang, cellular, and Mayer--Vietoris calculations in Layers 7--8.

Apply Tau Ceti's exterior-power and Smith-normal-form APIs to prove the missing kernel,
coinvariant, cokernel, saturation, and finite-cyclic-homology consequences needed below; do not
rebuild either generic API.  Every explicit computation has a machine-checkable coordinate
theorem and a basis-independent statement.

## Layer 2: the `(3,4,∞)` Fuchsian orbifold

Use the modular-forms roadmap's `P^1`, whose carrier is `B = OnePoint C`, as the base throughout;
write `t` for its finite chart and `t_c=1/t` for its chart at infinity.

1. Use the action `[[a,b],[c,d]]*z=(a*z+b)/(c*z+d)` and the determinant-one lifts
   `g_1=[[-1,1],[-1,0]]` and `g_2=[[0,-1],[1,sqrt(2)]]`; thus
   `g_0=(g_1*g_2)^(-1)=[[1,-(1+sqrt(2))],[0,1]]`.  Prove their exact orders `3` and `4` in
   `PSL(2,R)`, the ping-pong/fundamental
   polygon theorem, and identify their image with the discrete Fuchsian triangle group of
   signature `(0;3,4;1)`.  Relate it to the abstract coproduct `Delta` from Layer 1 and prove the
   action on the upper half-plane is faithful and properly discontinuous.
2. Fix the elliptic points
   `z_1=1/2+i*sqrt(3)/2` and `z_2=-sqrt(2)/2+i*sqrt(2)/2`, prove that they are the respective
   fixed points in the upper half-plane, and define
   `H° = H \ (Delta·z_1 ∪ Delta·z_2)`, and prove that it is open and invariant, every
   stabilizer on it is trivial, and the restricted action is free and properly discontinuous.
   Construct its coarse quotient and complex charts, then add the two elliptic charts
   `w |-> w^3`, `w |-> w^4` and a cusp chart.  Compactify it to the Riemann sphere with marked
   points `p_1=0`, `p_2=1`, and `p_0=infinity`; prove the quotient map, stabilisers, ramification
   indices, and cusp width.  Instead of introducing a private orbifold type, identify `Delta`
   with the quotient of `pi_1(B \ {p_0,p_1,p_2})` by the meridian relations
   `a_1^3=a_2^4=1`, with `a_1*a_2*a_0=1`.  All three meridians are clockwise, and the associated
   deck generators act by `rho_Lambda`; record that reversing all meridians replaces every
   monodromy and twist exponent by its inverse or negative.
3. Consume the modular-forms roadmap's normalized `j`-function, its Laurent `q`-expansion, exact
   orders of `j` and `j-1728`, and biholomorphism `X(1) ≃ P^1`.  Construct the homomorphism from
   `Delta` to the level-one modular group used by the modular parameter and prove the normalized
   `(3,4,∞)` pullback/orbifold uniformization, including the induced elliptic ramification and
   `q`-coordinate at the cusp.
4. Prove orbit-local-finiteness and Hausdorff-separation lemmas for every properly discontinuous
   Fuchsian action.  For `Delta`, additionally construct explicit compact fundamental sets and
   cusp neighbourhoods and prove that their translates have the finiteness and overlap
   properties used in Layers 4--6.

## Layer 3: the equivariant period functions

Construct holomorphic functions `tau : H -> H` and `mu,beta : H -> C` satisfying Theorem 3.4 of
the paper, rather than assuming their existence as an axiom.

1. Lift the normalized modular parameter through `j`, normalized by
   `tau(z_1)=1/2+i*sqrt(3)/2` and `tau(z_2)=i`.  Prove existence, uniqueness with this
   normalization, ramification, the cusp expansion, and the exact laws
   `tau(g_1*z)=(tau(z)-1)/tau(z)`, `tau(g_2*z)=-1/tau(z)`, and
   `tau(g_0*z)=tau(z)-1`.
2. Prove that the pulled-back function `z |-> ModularForm.E₆ (tau z)` has double zeros exactly
   on the `Delta`-orbit of `z_2` and no other zeros.  Construct a holomorphic `r` with
   `r(z)^2=ModularForm.E₆(tau z)`, prove that its zeros on that orbit are simple, and determine
   the forced generator signs
   `r(g_1*z)=-tau(z)^3*r(z)`, `r(g_2*z)=tau(z)^3*r(z)`, and `r(g_0*z)=r(z)` before using it.
   Construct `mu`, prove
   `mu(g_1 z) = (1-mu z)/tau z` and `mu(g_2 z) = 1+mu z/tau z`, and prove an explicit norm bound
   on a cusp neighbourhood using direct quantified inequalities.  Also prove
   `mu(g_0*z)=mu(z)`.
3. Consume the modular-forms roadmap's analytic structure sheaf, divisor-twist, Cech-to-sheaf
   cohomology, Riemann--Roch, and high-degree `H^1`-vanishing interfaces.  Specialise them along
   `X(1) ≃ P^1` to prove `H^1(P^1,O(-1))=H^1(P^1,O)=0`, and extract the two-chart Laurent
   splitting of overlap cocycles needed for computation.  Prove the finite-orbifold descent and
   finite-jet interpolation theorem with frame orders `(2,1)` for `O(-1)`--value and first
   derivative at `z_1`, value at `z_2`--and `(0,0)` for `O`.  Interpret the affine transformation
   law for `beta` as an `O`-torsor cocycle, solve it by that theorem, and prove
   `beta(g_1*z)=beta(z)+2-6*(1-mu(z))^2/tau(z)`,
   `beta(g_2*z)=beta(z)-3-6*mu(z)^2/tau(z)`, and `beta(g_0*z)=beta(z)+1`.  Prove
   `beta+tau` has an explicit cusp bound.  Define the invariant Schur quantity
   `q(z)=Im(beta z)-6*(Im(mu z))^2/Im(tau z)`.  Prove it is bounded above on the cusp region and a
   compact set meeting every remaining orbit; choose an explicit real `c` strictly above the
   resulting global bound, replace `beta` by `beta-c*i`, and prove `q(z)<0` for every `z` (with
   `Im(tau z)>0` supplied by `tau : H -> H`).  This is a choice, not a uniqueness normalization;
   no second analytic sheaf or cohomology API is introduced.
4. Define
   `Z(z)=[[6*mu(z),tau(z)],[beta(z),mu(z)]]` and assemble
   `Pi(z)=[Z(z)|I]`.  For the generators fix
   `R_1(z)=[[-1/tau(z),0],[(1-mu(z))/tau(z),1]]`,
   `R_2(z)=[[1/tau(z),0],[-mu(z)/tau(z),1]]`, and `R_0(z)=I`.  Prove the order-three and
   order-four cocycle relations and extend these uniquely along `Delta=C_3*C_4` to `R_g(z)`.
   Prove
   the coordinate-free law
   `periodMap(g*z)(rho_Lambda(g)(lambda))=R_g(z)(periodMap(z)(lambda))` and its matrix form
   `Pi(g*z)*A_g=R_g(z)*Pi(z)`, where `A_g` is the matrix of `rho_Lambda(g)`.  Prove holomorphic
   dependence and show that `q(z)<0` makes the realified period map a linear equivalence
   `Lambda ⊗ R ≃ₗ[R] C^2`; deduce discreteness and `IsZLattice R` for its range.  Establish the
   cusp unit `u_1` by `exp(2*pi*i*tau)=t_c*u_1(t_c)`, choose
   `h=(2*pi*i)^(-1)*log(u_1)`, and set `s=tau-h(t_c)`.  Prove
   `exp(2*pi*i*s)=t_c`, `s(g_0*z)=s(z)-1`, and the cusp normal form
   `Pi=[s*B_0+C(t_c)|I]`, with `C` holomorphic at zero and the resulting phase action independent
   of the logarithm branch.

All descent results are theorems about analytic cocycles, sheaves, or quotient maps.  There are
no axioms asserting their existence and no structures whose fields assert these functions or
their transformation laws.

## Layer 4: complex tori and the regular family

1. Fix a complex manifold `Y`, a finite free `Z`-module `Lambda`, a finite-dimensional complex
   normed space `E`, and a map
   `Pi : Y -> (Lambda ->ₗ[Z] E)` such that each `z |-> Pi z lambda` is holomorphic and each
   `Pi z` is injective.  For every `z`, take `[DiscreteTopology (LinearMap.range (Pi z))]` and
   `IsZLattice R (LinearMap.range (Pi z))` after restriction of scalars as direct hypotheses of
   the generic constructor; they do not follow from injectivity alone.  Use these hypotheses
   directly rather than adding a record solely to bundle them.  Define the additive action
   `lambda +ᵥ (z,v) = (z,v+Pi z lambda)`, prove it is free and properly discontinuous, and form
   the standard orbit quotient.  Give its complex-manifold structure, prove the projection is a
   holomorphic submersion, prove compact-uniform fundamental-domain bounds over compact subsets of
   `Y`, and identify each fibre with the complex torus `E / range(Pi z)`.
2. Instantiate this with `Y=H°`, `E=EuclideanSpace C (Fin 2)`, and the restriction of Layer 3's
   period map; Layer 3's real-linear-equivalence theorem supplies discreteness and `IsZLattice`.
   Lift the `Delta` action using `R_g(z)`, prove it is a
   holomorphic action compatible with the lattice quotient, and form the second quotient over the
   thrice-punctured sphere.  Prove its marking, monodromy, local product charts, zero section,
   compact fibre, connectedness, and Hausdorff and second-countable instances.
3. Prove naturality of fundamental groups and singular homology for these torus bundles.  Derive
   the action on `H_1` from the dual representation `rho_Lambda` and the action in every degree
   from its exterior powers, rather than selecting bases independently in each degree.  Fix the
   covering convention so that the clockwise meridian represented by the deck generator `g`
   acts by `rho_Lambda(g)`; prove that counterclockwise meridians give the inverse action rather
   than silently changing conventions.

## Layer 5: locally finite toric manifolds and the cusp filling

Mathlib has no analytic toric-variety API from which the cusp model follows, so that theory is an
explicit part of the roadmap.

1. For a finite free lattice `N`, use Mathlib's `PointedCone R (N ⊗ R)`, `FG`, `DualFG`,
   `IsFaceOf`, and `Face` APIs.  Add the predicate that a finitely generated cone is rational with
   respect to `N`, the integral dual semigroup `dual(sigma) ∩ Module.Dual Z N`, its finite
   generation, and the associated monoid algebra and monomial maps.  Define locally finite
   rational fans and their morphisms using Mathlib faces and intersections.  For a regular cone,
   identify its complex analytic chart with `C^k x (C^*)^(n-k)`.
2. Glue the affine charts of a locally finite regular fan by their monomial biholomorphisms using
   Layer 0.  Prove the result is a Hausdorff second-countable complex manifold, construct its
   algebraic-torus action and character functions, and prove functoriality.  For a fan morphism
   `phi : Sigma -> Delta`, prove the toric properness criterion cone by cone:
   `phi_R⁻¹(tau)` is the support of the subfan of cones of `Sigma` mapped into `tau` for every
   `tau` in `Delta`.  Do not infer that the height map below is proper before taking the deck
   quotient; its nonzero fibre is `(C^*)^2`.
3. Put `N' = Lambda_tor ⊕ Z`.  In the basis `e_1,e_2`, use the unoriented triangulation
   directions `e_1`, `e_2-e_1`, and `-e_2`, so the cyclic hexagon rays are
   `e_1,e_2,e_2-e_1,-e_1,-e_2,e_1-e_2`; build the fan of cones over this `A_2` triangulation of
   `Lambda_tor ⊗ R x {1}`.  Prove local finiteness and regularity.  For
   `lambdaBar : LambdaBar`, define the homogenized integral shear
   `phi_lambdaBar(x,h)=(x+h*B_0(lambdaBar),h)`; prove it is a fan automorphism carrying the cone
   over `P` to the cone over `P+B_0(lambdaBar)`.  Define the height character
   `t_c=chi^(0,0,1)`, prove it is shear-invariant, and identify its punctured and central fibres.
4. Construct the holomorphic phase correction from `C(t_c)` and compose it with the homogenized
   shears to obtain the `LambdaBar`-action.  Prove the group law, holomorphy, freeness, proper
   discontinuity, orbit separation, and uniformly bounded representatives over every closed
   smaller disc.  Take the standard orbit quotient `N_0`; use those representative bounds to
   prove `N_0 -> disk` proper, and identify its punctured restriction biholomorphically with the
   regular period family through exponential coordinates.
5. Prove the polar--honeycomb phase-spreading theorem: the compact torus acting on the nonnegative
   part has an open quotient orbit map; the positive central fibre is equivariantly homeomorphic
   to the honeycomb dual to the `A_2` triangulation; its positive-part contraction preserves the
   torus stabilizer of every vertex, edge, and face stratum; and spreading that contraction over
   compact phases gives a `LambdaBar`-equivariant strong deformation retraction of the local
   toric carrier, hence of `N_0`, onto its central fibre `W`, fixed pointwise on `W`.  Prove that
   the descended height divisor is reduced and irreducible and that, at its smooth, double, and
   triple strata, a height coordinate has the respective normal-crossing forms
   `t_c=a*z_0`, `t_c=a*z_0*z_1`, and `t_c=a*z_0*z_1*z_2`, with `a` a holomorphic unit.  Identify
   `W`: its normalization is the analytic toric surface of the explicit smooth complete six-ray
   fan (classically the degree-six del Pezzo surface), opposite hexagon sides are identified, its
   double locus is three rational curves meeting in two triple points, and its Euler
   characteristic is `2`.  Construct the actual CW structure, inclusion, retraction, and collapse
   homotopy consumed by Layer 8.

## Layer 6: elliptic logarithmic-transform fillings and global gluing

1. Starting from the direct Layer-4 data
   `Pi : D -> (Lambda ->ₗ[Z] E)`--coordinatewise holomorphic, pointwise injective, with
   discrete `IsZLattice` ranges--a cyclic lift covering a rotation of the disc, and an equivariant
   fibrewise torsion section, develop the affine cyclic action on the total space of the varying
   torus family.  Prove a usable freeness criterion in terms of the torsion class in
   `coker(A-1)=Lambda ⧸ LinearMap.range(A-1)`, form the standard complex quotient, and prove the
   projection is a holomorphic multiple fibre.  The construction retains the varying period
   lattice; it does not replace the family by a product with one fixed torus.
2. For `v_1 in ker(A_1-1)` and `v_2 in ker(A_2-1)`, prove that the exact freeness conditions are
   `3` not dividing `gammaCoeff(v_1)` and `Odd (gammaCoeff(v_2))`.  Set
   `ell_1=gammaCoeff(v_1)` and `ell_2=gammaCoeff(v_2)`, construct the corresponding order-three
   and order-four fillings, and then specialize to `(v_1,v_2)=(epsilon,-epsilon')`, giving
   `(ell_1,ell_2)=(1,-1)`; retain `v_2=epsilon'` as the comparison sign choice.  For each quotient
   map `f_j`, prove `f_j⁻¹({p_j})=S_j` and, in every chart transverse to `S_j`,
   `t∘f_j=a*u^(m_j)` for a holomorphic unit `a`; this gives
   `normalBundle(S_j)^⊗m_j ≃ O`.  Separately identify the central abelian surface
   `A_0^(j)`, construct its explicit isogeny from a product of elliptic curves, and prove
   `S_j ≃ A_0^(j)/<sigma_j>` for the free affine cyclic generator `sigma_j`.  Prove that this is
   a smooth compact complex surface, that `H_1(S_j;Z) ≃ Z^2`, and that its canonical-bundle
   character has exact order `m_j`; this explicit quotient and these invariants are the formal
   target (classically, `S_j` is a Bagnera--de Franchis bielliptic surface).  Use the action's
   cyclic character and the exact torsion class to rule out
   every proper divisor of `m_j` and hence prove that the normal bundle has exact order `m_j`,
   without introducing a higher-dimensional divisor wrapper.
3. Construct the logarithmic gauges on punctured discs, prove branch changes act by lattice
   translations, and obtain canonical biholomorphisms from the punctured varying-family fillings
   to the ends of the regular family.  Compute the induced maps on `pi_1` and `H_1` from each
   punctured collar into its filling, including the meridian and fibre-period generators consumed
   by Layer 8.  Build compatible collars using the geometric-topology roadmap and prove the
   transition maps are holomorphic.
4. Classify the holomorphic punctured-cusp sections `sigma` compatible with `M_0`.  Define their
   connecting class `c(sigma) : LambdaBar` and
   `ell_0=gammaBarCoeff(c(sigma))`; prove that every integer occurs, and use `sigma` to define the
   cusp-collar regluing.  Track the clockwise meridian through this gluing, including the relation
   whose exponent is `ell_0`, and prove that simultaneous reversal of all meridians negates
   `(ell_0,ell_1,ell_2)`.
5. For every admissible datum `(sigma,v_1,v_2)` above, put the regular family, `N_0`, `N_1`, and
   `N_2` into a `TopCat.GlueData` and apply Layer 0 to construct `X(sigma,v_1,v_2)`.  Prove it is
   Hausdorff, second countable, compact, connected, and a complex three-manifold; construct the
   surjective holomorphic map `f : X(sigma,v_1,v_2) -> P^1`, describe all fibres, and prove it is
   proper by verifying local properness over the regular, cusp, and two elliptic base charts and
   applying Layer 0's properness-local theorem.  Deduce compactness from compactness of `P^1`, and prove
   independence up to biholomorphism over the base of radii, collars, logarithm branches, and
   linearizing coordinates with the period functions (including `c_0`) and
   `(sigma,v_1,v_2)` fixed.  The integers are invariants used by the topology calculation, not a
   claimed biholomorphism classification.  The headline manifold `X` uses
   `sigma=0`, `v_1=epsilon`, and `v_2=-epsilon'`; also construct the comparison manifold `X'`
   with `v_2=epsilon'`.

This layer produces the actual `X` consumed below; none of its geometric or topological
conclusions are supplied as data.

## Layer 7: van Kampen, relative homology, excision, and cellular comparison

This layer develops the required generic topology as standard, map-level APIs.

1. **Van Kampen.**  Following mathlib4#41603, prove that the fundamental-groupoid functor sends
   an open cover to a colimit, with naturality under refinement.  Derive the two-open-set pushout,
   based connected-space theorem, iterated finite-cover theorem, and group-presentation
   corollaries.  Include the groupoid form so disconnected intersections require no artificial
   path choices.
2. **Relative singular homology.**  Define the singular chain complex and homology of a
   `TopPair` by passage to `SSetPair`, with arbitrary coefficient ring/module at the natural
   level.  Prove functoriality, the long exact sequence of a pair, homotopy invariance, dimension,
   and additivity in the shape of mathlib4#41285 and #38369.
3. **Subdivision and excision.**  Construct affine and barycentric subdivision of singular
   simplices in all degrees, its chain homotopy to the identity, iterated small-simplex
   subdivision subordinate to an open cover, and the chain-homotopy equivalence with the small
   chain subcomplex.  Deduce excision and the natural Mayer--Vietoris long exact sequence for a
   binary open cover.
4. **CW and cellular homology.**  From Mathlib's actual `CWComplex`/`RelCWComplex` structures,
   construct cellular chains, boundary maps from attaching maps, and the natural cellular-to-
   singular comparison isomorphism.  Prove finite-CW Euler--Poincare and finite-generation
   results.  Prove relative CW inclusions are closed cofibrations with the homotopy-extension
   property; construct mapping cylinders, cellular approximation and skeletal induction; and
   prove that a cofibration which is a homotopy equivalence is a strong deformation retract.
   Bare records of cell counts are not substitutes for CW structures.
5. **Bundle and finite-cover tools.**  Derive the Wang exact sequence for a mapping torus and its
   naturality, transfer and invariants/coinvariants for finite covers, and homology of tori from
   exterior powers.  For an ordered finite open cover, construct the double complex
   `directSum_(i_0<...<i_p) C_q(U_(i_0...i_p);R)`, with the alternating chain maps induced by the
   inclusions obtained by dropping one index, and the singular differential; prove its augmented
   total complex is naturally quasi-isomorphic to singular chains by the small-chain theorem,
   and construct the first-quadrant spectral sequence, bounded in Cech degree by the cardinality
   of the cover,
   with `E^1_(p,q)=directSum H_q(U_(i_0...i_p);R)` and its natural convergence.
6. **Cohomology and manifold duality.**  From singular chains construct absolute and relative
   singular cochain complexes and cohomology functors, their pair long exact sequences, and the
   universal coefficient short exact sequence with its naturality and splitting consequences.
   Construct the Alexander--Whitney and Eilenberg--Zilber chain maps and chain homotopies; use them
   to define cup and cap products and prove their naturality, associativity, unit, graded-sign,
   and boundary formulas.  Consume geometric topology's orientation and boundary conventions,
   construct integral fundamental classes, and prove Poincare and Poincare--Lefschetz duality for
   compact oriented manifolds, including the top-degree and torsion consequences used here.
7. **Euler characteristic.**  Define Euler characteristic for finite-CW-type spaces and prove
   homotopy invariance, multiplicativity for fibre bundles with finite-CW base and fibre and for
   finite covers, and additivity for finite excisive decompositions and finite CW
   stratifications.  State the hypotheses on cofibrations and finiteness explicitly.  Derive the
   localization lemma used in Layer 8: pieces fibred by positive-dimensional tori or covered by
   such pieces contribute zero, so the global Euler characteristic is the contribution of the
   singular cusp fibre.

## Layer 8: calculate the topology of the four-piece manifold

All results in this layer refer to the concrete maps and inclusions constructed in Layers 4--6.

1. Use the zero section to identify the fundamental group of the regular piece as the semidirect
   product `Lambda semidirect pi_1(B^o)`, with the action obtained from `rho_Lambda` under the
   clockwise-meridian convention fixed in Layers 2 and 4.  Identify the three overlap and filling
   maps on generators.  Apply Layer 7 van Kampen and use Layer 1's Smith-normal-form calculation
   to prove

   `pi_1(X(sigma,v_1,v_2)) ~= Z / (12 ell_0 - 4 ell_1 - 3 ell_2) Z`.

   State the zero case with the usual infinite-cyclic convention and prove the absolute-value
   order corollary when the coefficient is nonzero.  Prove that simultaneous reversal sends the
   triple and `12 ell_0 - 4 ell_1 - 3 ell_2` to their negatives.  Deduce
   `SimplyConnectedSpace X` for `(0,1,-1)`.
2. Realize the cusp, elliptic-filling, collar, and intersection CW models.  Compute every local
   cellular boundary matrix and identify each geometric inclusion with the corresponding chain
   map.  Use the Wang and finite-cyclic calculations from Layers 1 and 7 to verify those
   identifications.
3. Apply the natural Mayer--Vietoris sequence to the actual finite open cover of `X`.  Compute the
   Smith normal forms of its integral boundary maps, including degrees zero and six and all
   torsion, and prove that the map-level result is naturally isomorphic to singular homology.
   Conclude `H_0(X;Z)=Z`, `H_6(X;Z)=Z`, and `H_k(X;Z)=0` for `k != 0,6`, using the dimension
   theorem above degree six.
4. Complete the finite-open-cover Cech spectral-sequence calculation built in Layer 7 and prove
   that it gives the same homology groups as Mayer--Vietoris.  This is a chain-level cross-check
   of the finite-cover calculation; it is not called the manuscript's sheaf-theoretic Leray
   proof.
5. Prove `chi(X)=2` both from homology and by applying Layer 7's localization theorem to the
   actual decomposition: regular torus-bundle and reduced elliptic-quotient pieces have Euler
   characteristic zero, finite-cover multiplicativity handles their quotients, and the cusp contributes
   `chi(W)=2`.  Identify the two results through Euler--Poincare.  This checks the central-fibre
   and global calculations against each other.

## Layer 9: Hurewicz, Whitehead, h-cobordism, and `Theta_6`

The final recognition theorem is a major library development in its own right.

### 9A. From a homology sphere to a homotopy sphere

1. Consume the pointed induced-map API owned by the universal-covers roadmap and extend
   Mathlib's cubical `HomotopyGroup` with relative groups and long exact sequences.  In parallel,
   follow mathlib4#42435 for Kan simplicial homotopy groups, prove `TopCat.toSSet X` is Kan, and
   compare its homotopy groups naturally with the cubical groups.  Construct the Hurewicz
   homomorphism in this common API.  For `n>=2`, prove that an `(n-1)`-connected pointed space has
   reduced homology zero below `n` and `pi_n(X) ~= H_n(X;Z)` by Hurewicz.  Prove the relative form:
   for a based cofibration `A -> X` (equivalently, the NDR-pair hypotheses used by the relative
   group API), when the basepoint lies in `A`, both `A` and `X` are simply connected, and
   `pi_i(X,A)=0` for `i<n`, then `H_i(X,A;Z)=0` for `i<n` and relative Hurewicz is an isomorphism
   in degree `n`; spell out from the pair exact sequence that `H_i(A)->H_i(X)` is an isomorphism
   for `i<n-1` and a surjection for `i=n-1`.  Construct the pointed, orientation-normalized
   homeomorphism `I^n / boundary(I^n) ~=_t S^n` and prove it identifies cubical representatives
   and pointed homotopy classes of maps from Mathlib's metric sphere.
2. Using Layer 7's cofibration/HEP, mapping-cylinder, cellular-approximation, and skeletal-
   induction API, prove Whitehead's theorem for CW complexes and the homological Whitehead
   theorem for simply connected CW complexes, then extend both to spaces of CW type.  Consume
   geometric topology's smooth-triangulation theorem and prove that a compact smooth manifold has
   finite CW type in a form that supplies an actual homotopy equivalence.
3. Compute the homology and simple connectivity of `S^n` for `n>1` generally.  For a compact
   Hausdorff second-countable boundaryless smooth manifold `M` that is simply connected and an
   integral homology six-sphere, first use the smooth-triangulation theorem from the preceding
   step to give `M` finite CW type.  Then use a least-nonzero-homotopy-degree induction and
   Hurewicz to prove `pi_i(M)=0` for `2<=i<=5`, and then
   `pi_6(M) ~= H_6(M;Z)`.  Via the cube-boundary quotient comparison, choose a map `S^6 -> M`
   representing a generator, prove that it induces an isomorphism on every integral homology
   group, and apply homological Whitehead to construct a homotopy equivalence with Mathlib's
   standard `S^6`.

### 9B. Geometric h-cobordism and homotopy spheres

1. Consume the oriented smooth collared-cobordism carrier, composition, identity cylinders, and
   connected sums of manifolds owned by geometric topology.  On that same collared-cobordism
   carrier, construct reversal and boundary connected sum.  Define the standard h-cobordism condition by
   requiring both boundary inclusions to be homotopy equivalences; prove it is preserved by those
   operations and induces an equivalence relation on closed oriented manifolds.  No second
   cobordism carrier or composition operation is introduced here.
2. Consume geometric topology's standard handles and boundary-attachment/gluing API together
   with Heegaard Floer Lanes M/F0's Morse-function, finite-dimensional Sard, stable-manifold, and
   Morse--Smale transversality theorems.  Build Morse handle decompositions and handle slides,
   trading, and cancellation.  First prove the local Whitney move: two intersections of opposite
   sign joined by an embedded framed Whitney disc whose interior misses both submanifolds are
   removed by an ambient isotopy.  In a simply connected level manifold, construct such a disc
   for complementary submanifolds of dimensions `p,q>=3`.  Separately state the exact complement-
   fundamental-group and piping hypotheses for the borderline `(p,q)=(2,3)` case in dimension
   five, and prove them for the attaching and belt spheres after handle trading.  This supplies
   the index-two/index-three cancellation in a six-dimensional cobordism; do not infer it from
   the `p,q>=3` theorem.  Use these results to prove the
   simply connected smooth h-cobordism theorem in cobordism dimension at least six.  Conclude that
   h-cobordant closed simply connected manifolds of dimension at least five are
   orientation-preservingly diffeomorphic.
3. Define oriented smooth homotopy `n`-spheres.  Instantiate geometric topology's connected-sum
   operation, prove closure on homotopy spheres, and descend its established choice-independence,
   associativity, commutativity, identity, and orientation-reversal laws to oriented
   h-cobordism classes.  Construct an h-cobordism from `Sigma # (-Sigma)` to the standard sphere,
   rather than treating orientation reversal alone as the inverse law, and obtain the
   commutative group `Theta_n` for `n>=5`.

### 9C. The Kervaire--Milnor sequence and the six-dimensional computation

1. Define suspension and stable homotopy groups as the stabilized colimit of sphere homotopy
   groups.  For `n>=2`, prove that suspension
   `pi_q(S^n) -> pi_(q+1)(S^(n+1))` is an isomorphism for `q<=2*n-2` and a surjection for
   `q=2*n-1`; in particular, the sixth stem has stabilized for representatives
   `pi_(n+6)(S^n)` with `n>=8`.  Build the cofiber/Puppe exact sequences, suspension--loop
   adjunction, Hopf construction, and the EHP exact sequence.  Define composition and Toda
   brackets with their indeterminacy and naturality; these are the inputs to the low-stem
   computation, not unexplained table lookups.
2. Define the inclusions `SO(r) -> SO(r+1)`, stable `SO` as their colimit, and the comparison from
   finite to stable orthogonal homotopy groups.  Prove the stable range and real Bott periodicity
   through the loop equivalences giving the eight-periodic homotopy table.  Construct stable `J`
   from the action of `SO(r)` on spheres and prove compatibility with both stabilization systems.
3. Define stable tangent and normal framings, framed bordism, and almost-framed bordism (a stable
   framing away from a disc).  Construct one-point compactifications and Thom spaces of vector
   bundles, the tubular-neighbourhood collapse map with independence and naturality, and the
   inverse regular-value construction using relative smooth approximation and transversality;
   use these to prove Pontryagin--Thom for framed bordism.  This consumes Mathlib's compact
   Whitney embedding theorem, geometric topology's tubular neighbourhoods, and Heegaard Floer
   F0's Sard/transversality substrate.  For `n>=5`, define `P_n` geometrically.  A cycle
   `(W,Sigma,phi)` is a compact oriented smooth `n`-manifold `W`, an orientation-preserving
   identification of `boundary W` with a homotopy `(n-1)`-sphere `Sigma`, and a stable tangent
   framing `phi` on the
   complement of the interior of a chosen disc, product-compatible on a fixed boundary collar.
   Two cycles are equivalent exactly when there is a compact oriented smooth `(n+1)`-manifold
   with corners whose horizontal boundary is `W_0 disjointUnion (-W_1)`, whose vertical boundary
   is an oriented h-cobordism `C : Sigma_0 -> Sigma_1`, with the specified corner and collar
   identifications, and which has a stable framing outside a tubular neighbourhood `D^n x I` of
   a properly embedded arc meeting the horizontal boundaries in exactly the two defect discs;
   the framing restricts, up to stable homotopy relative to the collars, to the cycle framings.
   Prove this relation is an equivalence relation and that boundary connected sum descends to a
   well-defined abelian-group operation on `P_n`.  For `n>=6`, define
   `P_n -> Theta_(n-1)` by sending a cycle to `[Sigma]`; prove it is a well-defined homomorphism
   using the vertical h-cobordism.  Interior surgery is not an additional quotient relation:
   Step 4 proves that the trace of every compatible framed surgery supplies a bordism of this
   stated kind.  Do not define `P_n` to be a Wall quadratic `L`-group; the comparison with its
   algebraic obstruction model is a theorem below.
4. Consume geometric topology's surgery operation on framed embedded spheres.  Prove its effect
   on stable normal framings, the trace cobordism, fundamental groups, and homology, and develop
   framed surgery below the middle dimension.  For an almost-framed `4k+2`-manifold made
   `2k`-connected, construct the nonsingular middle-dimensional mod-two intersection pairing and
   its quadratic refinement.  Prove that its Arf/Kervaire invariant is the obstruction in
   `P_(4k+2)`, is bordism invariant, and vanishes exactly when middle-dimensional surgeries turn
   the representative into a homotopy sphere.  Prove the corresponding intersection-form and
   signature obstruction in dimensions divisible by four, and construct the realization maps
   from the integral symmetric and mod-two quadratic obstruction data back to geometric `P_n`
   cycles.
5. Prove the geometric obstruction-group calculations in their surgery ranges:
   `P_n=0` for odd `n>=5`; for `k>=2`,
   `P_(4k) ≃ Z` by the exact normalization `[W] |-> signature(W)/8`; and for `k>=1`,
   `P_(4k+2) ≃ Z/2` by the Arf invariant.  This includes classification and realization of
   the even unimodular integral middle-dimensional forms arising in dimension `4k`, divisibility
   of signature by eight and an `E_8` realization, and classification of nonsingular `F_2`
   quadratic forms by Arf.  Define
   `bP_(n+1) <= Theta_n` as the subgroup represented by homotopy `n`-spheres bounding compact
   parallelizable `(n+1)`-manifolds, and prove subgroup closure by boundary connected sum and
   orientation reversal.
6. For an oriented smooth homotopy six-sphere, prove stable parallelizability directly: pull its
   stable tangent class to `S^6` and use the dimension-six Bott/KO obstruction
   `pi_5(SO)=0`.  Prove that changing a stable normal framing changes its Pontryagin--Thom class
   by `image(J_6)`.  Construct and prove exact, map by map, the dimension-six almost-framed
   surgery segment
   `P_7 -> Theta_6 -> coker(J_6) -> P_6 -> Theta_5`, identify the two boundary images with
   `bP_7` and `bP_6`, and derive
   `0 -> bP_7 -> Theta_6 -> coker(J_6) ->^KI Z/2 -> bP_6 -> 0`.
   This roadmap does not assume a general indexed sequence or store exactness in fields of a
   record.
7. Use EHP and Toda brackets to calculate through the sixth stable stem: construct the stable Hopf
   classes, prove `pi_6^S` is generated by `nu^2` with exact order two, and compute the Kervaire
   invariant of that framed generator as one.  Bott periodicity gives `pi_6(SO)=0`, so
   `coker(J_6)=Z/2` and `KI : coker(J_6) -> Z/2` is an isomorphism.  Since `P_7=0`, the boundary
   description gives `bP_7=0`; exactness then gives `Theta_6=0`.
8. Let `M` be a compact Hausdorff second-countable smooth six-manifold and let
   `h : M ~=_h S^6`.  Use `h` to prove connectedness and simple connectivity and to choose the
   integral fundamental-class generator and orientation.  Regard `M` as an element of `Theta_6`;
   combine `Theta_6=0` with the h-cobordism theorem to obtain a nonempty type of diffeomorphisms
   `M ~=_m S^6`.  Apply this direct theorem to `X` and the homotopy equivalence from 9A.  Do not
   claim Mathlib's unrestricted `ContinuousMap.HomotopyEquiv.NonemptyDiffeomorphSphere`, whose
   quantifiers omit the separation and compactness hypotheses used by the theorem.

For a smooth homotopy six-sphere this diffeomorphism theorem supplies the homeomorphism used in
the paper's recognition paragraph.  A separate topological marking and quotient of marked
smooth structures do not occur in the dependency spine.

## Layer 10: put the complex atlas on the standard `S^6`

Realify the Layer-6 complex atlas by Layer 0, rechart it to `EuclideanSpace R (Fin 6)`, and compare
that smooth structure with the one used by Layer 9.  Orient the standard `S^6` by the boundary
orientation of the unit seven-ball, with outward normal first, and choose the h-cobordism
diffeomorphism so the complex orientation of `X` transports to that orientation.  Transport the
complex charts across `X ~=_m S^6`; prove the transported transitions are holomorphic and the
underlying real atlas is the standard smooth sphere atlas up to the identity diffeomorphism.  If
the opposite orientation generator was chosen, precompose with the explicit coordinate
reflection of `S^6` and prove the resulting convention.  Record the resulting instances and the
theorem that the standard six-sphere admits this integrable complex structure.

Also transport `f` to a holomorphic map from the complex `S^6` to the Riemann sphere and retain
the descriptions of its regular, cusp, and multiple fibres.  This prevents the final transport
from discarding the geometric content of the construction.

## Dependency order and parallel work

| Track | Depends on | Feeds |
| --- | --- | --- |
| L0 atlas/quotient/gluing | Mathlib manifold and quotient APIs | L4--L6, L10 |
| L1 integral representation | Mathlib/Tau Ceti linear algebra | L3, L5--L6, L8 |
| L2 Fuchsian orbifold | conformal mapping, modular forms, universal covers | L3--L4 |
| L3 periods | L1--L2 | L4--L6 |
| L4 regular torus family | L0, L2--L3 | L6, L8 |
| L5 cusp filling | L0--L1, L3 | L6, L8 |
| L6 elliptic fillings and gluing | L0--L1, L3--L5, geometric topology | L8, L10 |
| L7 algebraic topology | Mathlib/Tau Ceti topology, geometric topology orientations | L8--L9 |
| L8 concrete topology | L1, L4--L7 | L9 |
| L9 smooth recognition | L7--L8, geometric topology, universal covers, Heegaard Floer M/F0 | L10 |
| L10 transported complex structure | L0, L6, L9 | headline |

L0, L1, L2, L7.1--L7.5, and the geometric foundations can proceed in parallel; L7.6 consumes the
orientation foundation from geometric topology.  The paper-specific construction then follows
L3 -> L4/L5 -> L6 -> L8, while smooth recognition follows universal covers and Heegaard Floer
M/F0 -> L7 -> L9; only L10 joins those two branches.

## Acceptance checks

- A rank-four period lattice is accepted by the generic complex-torus constructor using
  `Submodule`, `DiscreteTopology`, and `IsZLattice R`; no separate rank witness is required.
- The same quotient theorem constructs both an ordinary fixed-lattice complex torus and the
  varying period family, and its projection is a local diffeomorphism.
- Two- and four-chart test gluings acquire smooth and complex atlases from one
  `TopCat.GlueData` theorem, with the canonical inclusions as open local diffeomorphisms.
- The `A_2` fan builds a genuine locally finite analytic toric manifold, and its central fibre
  carries an actual CW structure whose cellular homology agrees naturally with singular homology.
- Van Kampen handles an open cover with disconnected pairwise intersections at the groupoid
  level and recovers the familiar based theorem in the connected case.
- Mayer--Vietoris is obtained from excision for `TopPair`/`SSetPair`, and the sequence used for
  `X` is an instance of that theorem rather than separately supplied exact data.
- The presentation calculation specializes to the trivial group at `(0,1,-1)` and to `Z/7Z`
  for the paper's comparison sign choice.
- `Theta_6=0` mentions the geometric `Theta_6`, `bP_7`, stable `J`, and Kervaire invariant
  constructed in L9; replacing any of them by arbitrary groups and maps does not discharge it.
- The final theorem talks about Mathlib's standard `Metric.sphere` and an integrable complex
  atlas, not only an unspecified type known to be diffeomorphic to it.

## References

- The construction paper, [*A compact complex threefold fibred by tori over the projective line,
  and the six-sphere*](https://alpo.ge/s6.pdf), Sections 2--8 and Appendices A--B.
- William Fulton, *Introduction to Toric Varieties*, Annals of Mathematics Studies 131, 1993;
  Tadao Oda, *Convex Bodies and Algebraic Geometry*, 1988; and Kempf--Knudsen--Mumford--Saint-
  Donat, *Toroidal Embeddings I*, LNM 339, for the fan and toroidal construction.
- Allen Hatcher, [*Algebraic Topology*](https://pi.math.cornell.edu/~hatcher/AT/AT.pdf), for
  van Kampen, singular/cellular homology, Hurewicz, and Whitehead.
- Stephen Smale, [*Generalized Poincare's Conjecture in Dimensions Greater Than
  Four*](https://doi.org/10.2307/1970239), *Annals of Mathematics* 74 (1961), 391--406.
- John Milnor, *Lectures on the h-Cobordism Theorem*, Princeton University Press, 1965.
- Raoul Bott, [*The stable homotopy of the classical
  groups*](https://doi.org/10.2307/1970106), *Annals of Mathematics* 70 (1959), 313--337.
- Hirosi Toda, *Composition Methods in Homotopy Groups of Spheres*, Annals of Mathematics
  Studies 49, Princeton University Press, 1962, for the low stable stems and the class `nu^2`.
- Michel Kervaire and John Milnor,
  [*Groups of Homotopy Spheres: I*](https://doi.org/10.2307/1970128), *Annals of Mathematics*
  77 (1963), 504--537, especially the exact sequence and the low-dimensional table.
- William Browder, [*The Kervaire invariant of framed manifolds and its
  generalization*](https://doi.org/10.2307/1970686), *Annals of Mathematics* 90 (1969), 157--186.
- Guozhen Wang and Zhouli Xu,
  [*The triviality of the 61-stem in the stable homotopy groups of
  spheres*](https://annals.math.princeton.edu/wp-content/uploads/annals-v186-n2-p03-p.pdf),
  *Annals of Mathematics* 186 (2017), 501--580, especially Theorem 1.7 for the indexed
  Kervaire--Milnor sequence.

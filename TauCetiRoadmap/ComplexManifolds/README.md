# Complex manifolds: transport, quotients, bundles, and gluing

This roadmap builds the reusable infrastructure for constructing complex manifolds from charts,
free group actions, and compatible open pieces. Its summit is a single structure-groupoid API
which supports restriction of scalars, transport of atlases, smooth and complex quotients,
holomorphic vector bundles, and open gluing without replacing Mathlib's carriers or manifold
classes.

Suggested homes are `TauCeti/Geometry/Manifold/Complex/`,
`TauCeti/Geometry/Manifold/Quotient/`, and
`TauCeti/Geometry/Manifold/VectorBundle/Holomorphic/`.

## Scope and completion criterion

The roadmap is complete when Tau Ceti has the following library, with the standard basic API for
every object it introduces.

1. A boundaryless finite-dimensional complex manifold can be realified functorially and recharted
   along a real continuous linear equivalence. Holomorphic maps and biholomorphisms become smooth
   maps and diffeomorphisms, and the construction commutes with products, open subspaces, and
   restrictions.
2. Mathlib's carrier `OnePoint ℂ` has a named two-chart complex atlas for the Riemann sphere, with
   compactness and separation inherited from its existing topology.
3. A free properly discontinuous action by biholomorphisms gives Mathlib's standard orbit quotient
   a complex-manifold structure. The orbit projection is a covering map and a local
   biholomorphism, and invariant holomorphic maps and sections descend with the expected universal
   property.
4. Compatible manifold atlases on the pieces of `TopCat.GlueData` give its existing glued carrier
   a smooth or complex atlas. The canonical inclusions are open local diffeomorphisms, and the
   construction is unique and functorial.
5. Holomorphic vector bundles, especially line bundles, can be built from holomorphic transition
   cocycles and manipulated through pullback, dual, tensor product, determinant, normal, and
   canonical-bundle constructions.
6. Finite open gluings have reusable Hausdorff, second-countability, connectedness, and proper-map
   criteria strong enough to establish global instances from local data.

The roadmap owns boundaryless atlas mechanics, free properly discontinuous smooth and complex
quotients, open gluing, and holomorphic bundle gluing. It does not own manifolds with boundary,
collars, handles, or boundary gluing; arbitrary covering-space classification; almost-complex or
pseudoholomorphic-curve theory; analytic toric geometry; complex-torus families; coherent sheaf
cohomology; or Riemann--Roch.

## Ownership and dependencies

- Mathlib owns `ChartedSpace`, `ModelWithCorners`, `StructureGroupoid`, `HasGroupoid`,
  `Structomorph`, `IsManifold`, `Diffeomorph`, `IsLocalDiffeomorph`, `TopCat.GlueData`,
  `FiberBundle`, `VectorBundle`, `ContMDiffVectorBundle`, and the standard orbit quotients. This
  roadmap extends those APIs and does not introduce replacement manifold, gluing, quotient, or
  bundle carriers.
- The [universal-covers roadmap](../UniversalCovers/README.md) owns universal covers, deck groups,
  quotient-cover classification, and lifting theory. This roadmap consumes
  `IsQuotientCoveringMap` and `IsAddQuotientCoveringMap` and adds the compatible manifold and
  holomorphic structure.
- The [geometric-topology roadmap](../GeometricTopology/README.md) owns manifolds with boundary,
  collars, handle attachment, connected sum, cobordisms, and boundary gluing. Open gluing of
  boundaryless structure-groupoid atlases is owned here.
- The [Heegaard Floer roadmap](../HeegaardFloer/README.md) owns the orientation API and general
  almost-complex and pseudoholomorphic analysis. This roadmap proves that a complex atlas has its
  canonical real orientation and supplies integrable atlas constructions.
- The [conformal-mapping roadmap](../ConformalMapping/README.md) owns one-variable analytic
  theorems such as Riemann mapping and Schwarz reflection. It consumes the Riemann-sphere manifold
  and transport interfaces from this roadmap.
- The complex-tori and analytic-toric-geometry roadmaps consume the quotient, bundle, and open
  gluing interfaces here. They own their geometric constructions and do not add competing general
  quotient theorems.

Coordination with the authors and reviewers of the cited Mathlib work and sibling roadmaps comes
before integrating overlapping implementations. Tau Ceti implements every target here at its
current dependency pin; an open Mathlib change determines API shape, never whether work proceeds.

## Mathlib inventory and target shape

Consume the following existing interfaces directly.

- `ChartedSpace`, `ModelWithCorners`, `StructureGroupoid`, `HasGroupoid`, `contDiffGroupoid`,
  `Structomorph`, `ContMDiff`, `Diffeomorph`, and `IsLocalDiffeomorph` from
  `Mathlib/Geometry/Manifold/`.
- `TopCat.GlueData`, its carrier `D.toGlueData.glued`, its canonical maps
  `D.toGlueData.ι i`, the theorem `D.ι_isOpenEmbedding i`, its open-set criterion, and its
  colimit universal property from `Mathlib/Topology/Gluing.lean`.
- `ProperlyDiscontinuousSMul`, `ProperlyDiscontinuousVAdd`, `IsQuotientCoveringMap`,
  `IsAddQuotientCoveringMap`, `MulAction.orbitRel.Quotient`, and
  `AddAction.orbitRel.Quotient`. The quotient carrier is never replaced by a tagged copy or a
  chosen quotient section.
- `FiberBundle`, `VectorBundle`, `VectorBundleCore`, `ContMDiffVectorBundle`, bundle
  trivializations, and the existing pullback and bundle-hom APIs.
- `OnePoint ℂ` and `OnePoint.equivProjectivization`, including the existing homogeneous-coordinate
  formulas. No topology or charted space is placed on a second projective-line carrier.

Two open Mathlib pull requests fix the intended form of missing interfaces.

- [mathlib4#40727](https://github.com/leanprover-community/mathlib4/pull/40727) extends the
  properly-discontinuous quotient from `ChartedSpace` to `IsManifold`. Implement the missing
  results in Tau Ceti in that PR's orbit-quotient vocabulary, including the local-diffeomorphism
  and descent API, and replace them by imports when available.
- [mathlib4#42847](https://github.com/leanprover-community/mathlib4/pull/42847) develops transport
  of charted spaces and structure groupoids along homeomorphisms. Atlas transport and
  realification follow that design, with local implementations at the dependency pin.

## Encoding conventions

- A complex manifold is a type with the ordinary `TopologicalSpace`, `ChartedSpace`,
  `HasGroupoid`, and `IsManifold` instances. Do not collect its carrier, topology, atlas, and
  properties in a new record.
- Use `contDiffGroupoid ∞ 𝓘(ℂ, E)` for a complex atlas. `PartialDiffeomorph` is an implementation
  tool, not a public compatibility condition.
- A group action used in a complex quotient must preserve the complex structure groupoid. In
  direct function language, require
  `∀ g, ContMDiff 𝓘(ℂ, E) 𝓘(ℂ, E) ∞ (g • ·)`. Applying the same hypothesis to `g⁻¹` proves that
  every action map is a biholomorphism. Continuity alone, or smoothness only after realification,
  is insufficient.
- Keep the orbit projection and any later bundle projection distinct. For an action on `M`,
  `M → MulAction.orbitRel.Quotient G M` is the covering map and local biholomorphism. A map from
  that quotient to another base can be a submersion, but is not thereby a covering map.
- Transported atlases are named definitions. Supply local or scoped instances at their use sites;
  do not install unrestricted global instances when several transported atlases can inhabit the
  same carrier.
- Bundle transition data use functions into continuous linear equivalences and Mathlib's cocycle
  equations. A line bundle is the rank-one case of this API, not a separate bespoke carrier.

## Milestone 1: restriction of scalars and atlas transport

Fix a finite-dimensional complex normed vector space `E` and the boundaryless model
`𝓘(ℂ, E)`.

1. Construct the underlying real model on the same carrier from restriction of scalars. Prove
   that membership in the complex `contDiffGroupoid` implies membership in the real smooth
   groupoid. Derive a named real `ChartedSpace` and `IsManifold` structure from a complex one.
2. Prove functoriality for holomorphic maps, biholomorphisms, products, open subspaces,
   restrictions, tangent maps, and bundle charts. Show that the real derivative agrees with the
   restricted complex derivative.
3. Transport models, atlases, and structure groupoids along a `ContinuousLinearEquiv` and along a
   homeomorphism of carriers. Prove that the identity map between the original and transported
   structures is a diffeomorphism and prove composition and inverse laws for transport.
4. Prove that realification commutes, up to the canonical identity diffeomorphism, with recharting,
   products, open restrictions, quotient atlases, and compatible open gluing.
5. Construct the standard coordinate equivalence between the realification of
   `EuclideanSpace ℂ (Fin n)` and `EuclideanSpace ℝ (Fin (2 * n))`, and prove its compatibility
   with the preceding transport API.

The source spine is Kobayashi--Nomizu, *Foundations of Differential Geometry*, Volume I,
Chapter I, for atlases and compatible transformations, together with Huybrechts,
*Complex Geometry*, Chapter 1, for complex manifolds and their underlying real manifolds.

## Milestone 2: the Riemann sphere

On Mathlib's existing carrier `OnePoint ℂ`, construct a named two-chart complex atlas.

1. The finite chart has source `OnePoint ℂ \ {∞}` and sends `coe z` to `z`. The chart at infinity
   has source `OnePoint ℂ \ {coe 0}`, sends `∞` to `0`, and sends `coe z` to `z⁻¹`.
2. Prove the exact source, target, inverse, and overlap formulas. The transition on `ℂ \ {0}` is
   inversion; prove it and its inverse holomorphic.
3. Establish `ChartedSpace`, `HasGroupoid`, and `IsManifold` for the named atlas and retain the
   existing compact, Hausdorff, connected, and second-countable topology.
4. Relate the atlas to `OnePoint.equivProjectivization` through Mathlib's existing formulas and
   prove the standard Möbius transformations are biholomorphisms.

Forster, *Lectures on Riemann Surfaces*, Sections 1--2, supplies the two-chart source and the
holomorphic transition calculation.

## Milestone 3: smooth and complex quotients

Fix a group `G` acting freely and properly discontinuously on a manifold `M`.

1. Complete the smooth API in the form of mathlib4#40727. Equip
   `MulAction.orbitRel.Quotient G M` with `IsManifold`, prove that
   `Quotient.mk (MulAction.orbitRel G M)` is a covering map and local diffeomorphism, and give the
   additive version through the existing additive action API.
2. Prove the corresponding structure-groupoid theorem: if every action map and hence every
   inverse action map is a structomorphism, the quotient atlas has the same groupoid. Specialize
   this once to smooth actions and once to biholomorphic actions.
3. For an invariant map `f : M → N`, construct its quotient descent on the standard quotient.
   Prove continuity, smoothness, or holomorphy exactly when the pullback along the quotient
   projection has that property. Prove uniqueness, composition, products, and naturality under
   equivariant maps.
4. Develop the corresponding descent of maps into fibers and of invariant sections of pulled-back
   bundles. Prove that equivariant bundle maps descend and that descent commutes with pullback,
   dual, tensor product, and determinant.
5. Prove Hausdorffness, second countability, connectedness, compactness under cocompactness, and
   the expected local-chart formulas under their exact standard hypotheses.

Lee, *Introduction to Smooth Manifolds*, supplies the free proper-action quotient argument;
Forster, Sections 4--5, supplies the analytic-covering and holomorphic descent pattern. The
Mathlib pull request above is normative for Lean-level names and carriers.

## Milestone 4: compatible open gluing

Let `D : TopCat.GlueData` and give every piece `D.U i` a charted-space structure for one model
and structure groupoid.

1. State overlap compatibility using the structomorph property of the transition maps on
   `D.V (i, j)`. Prove symmetry, restriction, and cocycle lemmas from `GlueData` rather than
   copying the gluing relation into a new record.
2. Construct a `ChartedSpace` on `D.toGlueData.glued`, prove `HasGroupoid` and `IsManifold`, and
   prove every `D.toGlueData.ι i` is an open local diffeomorphism. Smooth and complex gluing are
   corollaries of this one theorem.
3. Prove uniqueness up to the identity diffeomorphism, compatibility with restriction to a
   subfamily of pieces, functoriality under maps of gluing data, and compatibility with products
   and atlas transport.
4. Verify the API on two-chart and finite-star gluings. These are tests of the general theorem,
   not separate gluing constructions.

The topology is already encoded by `TopCat.GlueData`; Lee's atlas-gluing arguments and
Kobayashi--Nomizu's pseudogroup formulation supply the manifold proof spine.

## Milestone 5: finite-gluing topology and proper maps

1. For a finite index type, prove second countability of the glued carrier from second-countable
   pieces.
2. Give a closed-graph or closed-equivalence-relation criterion which proves the glued carrier is
   Hausdorff, and show how the criterion reduces to pairwise overlap data in a finite gluing.
3. Prove connectedness from connected pieces whose nonempty-overlap graph is connected.
4. Prove that properness is local on the target for continuous maps to a Hausdorff space, using
   finite closed refinements over compact subsets. Deduce that a proper map to a compact target has
   compact domain.
5. Prove that all four results are preserved by isomorphisms of gluing data and agree with the
   corresponding Mathlib typeclasses.

Bourbaki, *General Topology*, Chapter I, supplies the quotient-separation and proper-map
criteria; the formal statements remain in Mathlib's topology vocabulary.

## Milestone 6: holomorphic vector and line bundles

1. Starting with a complex base and a family of complex normed vector spaces, extend
   `VectorBundleCore` and `ContMDiffVectorBundle` with the theorem that holomorphic transition
   functions produce a holomorphic vector bundle. Prove the converse description in local
   trivializations.
2. Prove cocycle gluing, change of trivialization, bundle equivalence, pullback, direct sum, dual,
   tensor product, tensor powers, exterior powers, and determinant. Supply identity, composition,
   and naturality lemmas for each operation.
3. Develop the rank-one specialization without a second line-bundle carrier. Prove the
   trivial-bundle criterion by a nowhere-zero holomorphic section and identify cocycle
   isomorphisms with holomorphic bundle equivalences.
4. For a smooth complex hypersurface, construct its normal holomorphic line bundle from transverse
   charts and identify its transition cocycle. Construct the holomorphic cotangent bundle,
   determinant bundle, and canonical line bundle from the same general API.
5. Prove that finite-order transition characters induce torsion tensor powers and give criteria
   for exact order. Keep these as bundle isomorphism statements, not as numerical fields of a
   divisor record.

Huybrechts, *Complex Geometry*, Chapters 1--2, supplies the analytic vector-bundle and canonical-
bundle development; Steenrod, *The Topology of Fibre Bundles*, supplies the transition-function
and change-of-trivialization spine.

## Dependency order

Milestones 1 and 2 start from Mathlib. Milestone 3 uses Milestone 1. Milestone 4 uses Milestone 1
and Mathlib's `TopCat.GlueData`. Milestone 5 uses Milestone 4's canonical maps only for its gluing
applications and can develop its general topology in parallel. Milestone 6 uses Milestones 1 and
4. The quotient descent part of Milestone 6 uses Milestone 3.

## Acceptance checks

- The quotient of `ℂ` by integer translations is constructed on
  `AddAction.orbitRel.Quotient ℤ ℂ`; its orbit projection is a covering map and local
  biholomorphism.
- A free properly discontinuous action by non-holomorphic diffeomorphisms does not satisfy the
  complex quotient theorem merely because its underlying real quotient is smooth.
- The orbit projection `M → M/G` is never called the projection of a manifold bundle over an
  unrelated base.
- The finite and infinity charts make `OnePoint ℂ` a complex manifold and have transition
  `z ↦ z⁻¹` on the exact punctured overlap.
- Two-chart and four-chart examples acquire complex atlases from the same `TopCat.GlueData`
  theorem, and every canonical inclusion is an open local biholomorphism.
- A cocycle for a trivial line bundle and a nontrivial finite-order character both pass through
  the same holomorphic-line-bundle constructor.
- Two atlases transported to the same carrier remain available as named values without creating
  competing unrestricted global instances.

## References

- Shoshichi Kobayashi and Katsumi Nomizu, *Foundations of Differential Geometry*, Volume I,
  Chapter I.
- John M. Lee, *Introduction to Smooth Manifolds*, second edition, for atlases, smooth maps,
  quotients by free proper actions, and smooth bundles.
- Otto Forster, *Lectures on Riemann Surfaces*, for the Riemann sphere, analytic coverings, and
  holomorphic descent.
- Daniel Huybrechts, *Complex Geometry: An Introduction*, Chapters 1--2, for complex manifolds,
  their underlying real manifolds, and holomorphic vector bundles.
- Norman Steenrod, *The Topology of Fibre Bundles*, for transition functions and bundle gluing.
- Nicolas Bourbaki, *General Topology*, Chapter I, for quotient separation and proper maps.

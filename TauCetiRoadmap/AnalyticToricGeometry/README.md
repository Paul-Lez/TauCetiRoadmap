# Roadmap: analytic toric geometry

This roadmap constructs the complex-analytic manifolds attached to regular rational fans.  Its
starting point is the algebraic and combinatorial toric vocabulary developed in
[Yaël Dillies's Toric project](https://github.com/YaelDillies/Toric) and Mathlib: lattices,
rational cones, faces, fans, dual semigroups, monoid algebras, toric schemes, and toric
morphisms.  Its own work begins with complex points and ends with analytic charts, gluing,
torus actions, orbit strata, normal-crossings boundary divisors, properness, and comparison
with the algebraic construction.

The defining design constraint is that Tau Ceti does not acquire a second toric dialect.
There is one cone, one fan, one affine semigroup, and one algebraic toric variety in the public
API.  Analytic realization is a functorial layer on those objects.  A contributor must
coordinate with the Toric authors before copying or adapting code, follow the public shapes in
that project, and record any provenance in module documentation rather than in new wrapper
structures.

Suggested home: `TauCeti/Geometry/Toric/Analytic/`.

## Scope and completion criterion

The scope is smooth complex toric geometry for finite and countable locally finite regular
rational fans.  Singular toric analytic spaces, general analytification of finite-type schemes,
coherent toric sheaves, intersection theory, and symplectic moment-map theory are outside this
roadmap.  The algebraic objects required here remain part of the common Toric/Mathlib
infrastructure; this roadmap integrates them as dependencies and does not redesign them.

The roadmap is complete when Tau Ceti supplies all of the following.

1. Every regular rational cone has a complex analytic affine chart on the complex-point
   carrier of its algebraic affine toric scheme.  A basis extending the primitive ray
   generators identifies that chart biholomorphically with
   `C^k × (C^*)^(n-k)`, and changing the extending basis gives the same atlas.
2. A countable locally finite regular fan has a Hausdorff second-countable complex manifold
   obtained by gluing its affine analytic charts along face localizations.  The chart
   inclusions, character functions, and torus action are holomorphic.
3. Faces and cones correspond naturally to torus orbits and orbit closures.  For a regular
   fan, the complement of the dense torus is a simple normal-crossings divisor whose
   components are indexed by rays.
4. A morphism of lattices compatible with two fans induces a holomorphic toric map.  Identity,
   composition, products, open subfans, and restrictions agree definitionally or by named
   natural isomorphisms.  The cone-by-cone support criterion characterizes proper toric maps.
5. For a finite regular fan, the analytic manifold is naturally biholomorphic, as a toric
   space, to the complex points of the algebraic toric variety supplied by the shared algebraic
   API.  This comparison commutes with affine charts, characters, orbit strata, and toric maps.
6. A finite regular fan is complete exactly when its analytic realization is compact.  The
   standard fans for affine space, the algebraic torus, projective space, products, and a toric
   blow-up satisfy the expected comparison and compactness theorems.

## Ownership and dependencies

- **The Toric project and Mathlib own the algebraic vocabulary.**  In particular, this roadmap
  consumes the chosen types and laws for lattices, rational cones, faces, fans, fan morphisms,
  dual affine semigroups, monoid algebras, affine toric schemes, gluing of toric schemes, and
  algebraic toric morphisms.  The Toric project follows Cox--Little--Schenck and carries
  Mathlib-shaped prerequisites in its `Toric/Mathlib` subtree.  Tau Ceti follows those shapes.
- **Mathlib owns convex cones.**  Use `PointedCone`, `PointedCone.FG`,
  `PointedCone.DualFG`, `PointedCone.IsFaceOf`, and `PointedCone.Face`.  Rationality adds an
  integral-lattice condition to this vocabulary; it is not a competing cone structure.
- **The complex-manifolds roadmap owns analytic atlas transport, open gluing, and compatible
  structure-groupoid atlases.**  This roadmap supplies the toric affine charts and verifies the
  hypotheses of those generic theorems.  It does not define another gluing quotient or another
  notion of biholomorphism.
- **Algebraic-curves and adic-spaces roadmaps own their own geometric categories.**  No scheme
  is reconstructed from its complex points here, and no non-archimedean analytification is
  introduced.
- **General scheme analytification is not claimed.**  The comparison layer below is toric and
  chartwise: it identifies the complex points of affine semigroup schemes, proves compatibility
  on localizations, and glues.  Its public theorems are phrased so a general analytification
  functor can replace the chartwise implementation without changing consumers.

When a required algebraic declaration is present in Toric but absent from the Tau Ceti pin,
coordinate with the Toric authors, reproduce its public shape in Tau Ceti, and prove the needed
laws there.  This is never a reason to pause analytic work, and opening a Mathlib pull request is
not a target of this roadmap.

## Pinned conventions

These conventions are acceptance conditions.

- A lattice is the finite free `Z`-module used by the shared algebraic toric API.  Its real
  scalar extension is the ambient vector space for `PointedCone R`; its character lattice is
  the `Z`-linear dual.  A chosen basis appears only in coordinate theorems.
- A rational cone and a fan use the shared Toric definitions.  Face inclusion is expressed by
  `PointedCone.IsFaceOf`; intersections use the existing lattice operations on cones.  Do not
  store a list of generators as the cone itself.
- Regularity means that the primitive ray generators of each cone extend to a basis of the
  lattice.  The theorem producing that basis is part of the algebraic input.  The analytic
  layer consumes the witness but proves independence from its choice.
- The dense complex torus with character lattice `M` is represented by the shared torus object
  or, at the point-set boundary, by group homomorphisms `M -> C^*`.  Do not identify it with a
  coordinate product until a basis has been chosen.
- Affine charts use the complex points of the algebraic affine semigroup scheme.  Their topology
  is the subspace topology under a finite monomial embedding; independence from the chosen
  semigroup generators is a theorem.
- Holomorphicity uses Mathlib's complex `StructureGroupoid`, `ChartedSpace`, `IsManifold`,
  `Diffeomorph`, and `ContMDiff`/`MDiff` vocabulary.  A basis-dependent coordinate map is not a
  replacement for a global complex atlas.
- Gluing uses `TopCat.GlueData` and the generic compatible-atlas theorem.  The glued carrier is
  the existing colimit carrier, not a tagged quotient made specifically for toric varieties.
- Fan morphisms are integral linear maps satisfying the shared cone-containment condition.
  Analytic maps are derived from them.  Matrices record a map in chosen bases and do not define
  a parallel morphism category.
- The support of a fan is the union of its cones in the real scalar extension.  Properness is
  stated by inverse images of supports cone by cone, with all local-finiteness hypotheses
  explicit.
- Locally finite fans are indexed by a countable type.  Local finiteness supplies the topological
  separation arguments; countability supplies second countability.  Neither conclusion is
  inferred from regularity alone.

## Existing foundations to consume

At the Mathlib pin, the following anchors already exist.

- The ordered-cone hierarchy in `Mathlib/Geometry/Convex/Cone/`, including cone hulls, maps,
  duals, finite generation, simpliciality, faces, and the face lattice.
- `Submodule`, `Basis`, tensor products, finite free modules, `Module.Dual`, `Finsupp`, matrices,
  monoid algebras, localizations, and affine schemes.
- Complex differentiability, finite products, open subspaces, complex manifolds, local
  diffeomorphisms, and structure groupoids.
- `TopCat.GlueData`, its canonical open embeddings, its open-set criterion, and its colimit
  universal property.
- Proper maps, compactness, local compactness, quotient maps, and locally finite families of
  sets.

The shared Toric development supplies the missing algebraic layer.  Before implementing an item,
search that repository, its blueprint, Mathlib, and open Mathlib pull requests.  Import what is
available and preserve the external public shape for what Tau Ceti must carry itself.

## Layer 0: integrate the algebraic toric input

This layer is a dependency contract, not an invitation to invent algebraic replacements.

1. Establish the exact import boundary with the Toric maintainers.  Record the modules providing
   lattices, rational cones, faces, regularity, fans and fan morphisms, dual semigroups, monoid
   algebras, affine toric schemes, torus actions, and algebraic toric morphisms.
2. For each imported object, provide the lemmas needed by the analytic layer: functorial scalar
   extension, primitive ray generators, face localization of dual semigroups, compatibility of
   monoid-algebra maps, and the affine open immersion associated to a face.
3. Prove that regularity yields a lattice basis whose first vectors are the primitive generators
   of the cone.  Pin the ordering convention and prove that two such choices differ by a block
   integral linear automorphism preserving the cone.
4. Relate the algebraic torus's complex points to `MonoidHom M C^*` and, after choosing a basis,
   to a finite product of `C^*`.  Prove naturality under lattice maps.
5. Add no analytic fields to algebraic structures.  Analytic topology, charts, and comparison
   live in the namespaces and modules of the following layers.

**Source spine:** Cox--Little--Schenck, Chapters 1 and 3; Fulton, §§1.2--1.4 and §2.1; the
Toric blueprint and source modules implementing those definitions.

## Layer 1: characters and monomial maps

1. Define evaluation of an integral character on the complex torus without choosing a basis.
   Prove the multiplicative laws, separation of points, compatibility with lattice maps, and the
   coordinate Laurent-monomial formula in a basis.
2. For a homomorphism of affine semigroups, construct the induced map on complex points.  Prove
   it is continuous and holomorphic after finite monomial embeddings, independent of chosen
   generators, and contravariantly compatible with monoid-algebra maps.
3. Prove the calculus of monomial maps: identity, composition, products, restriction to faces,
   inversion on the dense torus, Jacobian formula, and biholomorphicity for unimodular exponent
   matrices.
4. Prove that localizing a dual semigroup along a face gives an open complex subspace and that
   the localization map is a biholomorphism onto its image.  Verify the cocycle equations for
   successive face inclusions.

**Source spine:** Cox--Little--Schenck, §§1.1--1.3 and §3.1; Fulton, §§1.2--1.3.

## Layer 2: affine analytic charts of regular cones

1. Put the finite-monomial-embedding topology on the complex-point carrier of the affine toric
   scheme of a cone.  Prove independence from the finite generating set, Hausdorffness, local
   compactness, and second countability.
2. For a regular cone of dimension `k` in a rank-`n` lattice, use a basis extending its primitive
   generators to construct a biholomorphism with `C^k × (C^*)^(n-k)`.  Prove its coordinate
   functions are the expected characters.
3. Use this biholomorphism to install a named complex `ChartedSpace` and prove `IsManifold`.
   Prove that changing the extending basis yields the identical complex structure through a
   monomial biholomorphism.  The implementation may use local instances internally; it must not
   export one unrestricted global atlas for every possible choice.
4. Identify the dense torus as an open submanifold and the orbit associated to every face as a
   locally closed complex submanifold.  Compute its complex dimension and closure relation.
5. Prove that a face localization is an open holomorphic embedding of affine charts and that the
   resulting map agrees on carriers with the algebraic open immersion's complex points.

**Source spine:** Fulton, §§1.2 and 2.1; Cox--Little--Schenck, §§1.2, 3.1, and 3.3.

## Layer 3: finite and locally finite fan gluing

1. For a regular fan, form the diagram of affine charts and pairwise face-localization overlaps.
   Verify the `TopCat.GlueData` symmetry and cocycle equations from the fan intersection axiom.
2. Apply the complex-manifold gluing theorem to the existing glued carrier.  Prove every affine
   chart inclusion is an open holomorphic embedding and every cone-orbit chart agrees on
   overlaps.
3. Prove Hausdorffness by the fan intersection property and closedness of the generated gluing
   relation.  The proof must separate points in noncommon faces, not appeal to a claimed
   separation field in a fan record.
4. Prove second countability for countable fans and local finiteness of the chart cover for
   locally finite fans.  Prove local compactness and finite-dimensionality.
5. Establish invariance under equivalence of fan presentations and functoriality for open
   subfans.  A subdivision gives a holomorphic map to the original realization; it is not
   silently identified with an isomorphism.
6. For finite fans, prove compactness exactly when the support is the whole real vector space.
   For countable locally finite fans, prove the corresponding properness statement with the
   support condition and local finiteness stated directly.

**Source spine:** Fulton, §§1.4 and 2.4; Cox--Little--Schenck, §§3.1 and 3.4; Oda, Chapter I.

## Layer 4: torus actions, strata, and boundary divisors

1. Glue the affine torus actions and prove the group law, joint continuity, holomorphy, and
   equivariance of every chart inclusion and character function.
2. Prove the orbit--cone correspondence as an order-reversing equivalence between cones and
   torus orbits, with face inclusion corresponding to orbit-closure inclusion.  Compute
   stabilizers and quotient tori using sublattices rather than coordinate choices.
3. For each ray, construct the invariant prime hypersurface.  For a regular fan, prove that the
   union of these hypersurfaces is exactly the complement of the dense torus.
4. In a regular affine chart, identify the boundary with the union of coordinate hyperplanes.
   Deduce simple normal crossings, transversality, local defining equations, and the intersection
   formula indexed by cones.
5. Prove naturality of strata and boundary components under fan isomorphisms, products, and open
   subfans.

**Source spine:** Fulton, §§2.1--2.2 and §3.1; Cox--Little--Schenck, §§3.2--3.3 and §4.1.

## Layer 5: analytic toric morphisms and properness

1. From an integral linear map compatible with two fans, glue the affine monomial maps to a
   holomorphic toric map.  Prove identity and composition, compatibility with products, and
   uniqueness from the restriction to the dense torus.
2. Describe the preimage of every affine toric chart and every orbit stratum cone by cone.  Prove
   base-change and restriction results for open subfans.
3. Prove the analytic properness criterion: for every cone `tau` in the target fan, the inverse
   image of `tau` under the real linear map equals the support of the subfan of source cones
   mapped into `tau`.  Establish both directions using compact subsets and locally finite chart
   refinements.
4. Deduce that the realization of a complete finite fan is compact, that a fan is complete when
   the structure map to a point is proper, and that subdivisions induce proper maps when their
   supports agree.
5. Prove that a fan isomorphism induces a biholomorphism and conversely that the analytic map
   attached to an inverse fan morphism is the inverse biholomorphism.

**Source spine:** Fulton, §2.4; Cox--Little--Schenck, §3.3 and Theorem 3.4.11.

## Layer 6: comparison with algebraic toric varieties

1. For a regular rational cone, identify its analytic affine chart with the complex points of
   the shared algebraic affine toric scheme, equipped with the topology from a finite monomial
   embedding.  Prove independence from semigroup generators.
2. Prove that face localization on the analytic side agrees with complex points of the algebraic
   open immersion.  Check this equality before gluing; a carrier equivalence without map
   compatibility is insufficient.
3. For a finite regular fan, glue the affine comparisons to a torus-equivariant biholomorphism
   between the analytic realization and the complex-point realization of the algebraic toric
   variety.
4. Prove naturality for fan morphisms, characters, products, orbit inclusions, and boundary
   divisors.  The comparison sends analytic compactness to algebraic completeness through the
   common support criterion.
5. Expose the comparison as named maps and naturality theorems.  Do not put an `analyticSpace`
   field into the algebraic toric-variety structure.

**Source spine:** Cox--Little--Schenck, Chapters 1 and 3; Fulton, Chapters 1--2; Gunning--Rossi,
Chapter I, for the analytic-manifold gluing and holomorphic-map principles used in the
chartwise comparison.

## Dependency order and parallel work

| Track | Depends on | Feeds |
| --- | --- | --- |
| L0 algebraic integration | Mathlib and Toric | every analytic layer |
| L1 monomial calculus | L0, Mathlib complex analysis | L2, L5--L6 |
| L2 affine regular charts | L0--L1, complex manifolds | L3--L6 |
| L3 fan gluing | L2, complex-manifold gluing | L4--L6 |
| L4 orbit and boundary theory | L2--L3 | L6 and downstream geometry |
| L5 morphisms and properness | L1--L3 | L6 and compactness applications |
| L6 algebraic comparison | L0--L5 | reusable analytic realization |

L1 can proceed while L0's remaining imports are integrated.  Within L2, topology and the
regular-coordinate calculation can proceed in parallel.  L4 and L5 can proceed independently
after L3.  L6 joins those two tracks.

## Acceptance checks

- The affine line cone produces `C`, the zero cone produces `C^*`, and their face localization
  is the ordinary inclusion `C^* -> C`.
- A rank-`n` regular cone of dimension `k` produces a chart biholomorphic to
  `C^k × (C^*)^(n-k)`, and two extending bases give the same atlas.
- The fan with one zero cone produces the coordinate-free complex torus.  A basis identifies it
  with `(C^*)^n`, and changing basis acts by the corresponding Laurent monomial map.
- The standard complete fan produces complex projective space with its standard affine charts;
  the comparison respects homogeneous-coordinate monomials.
- Product fans realize as products of complex manifolds, with character and orbit formulas
  agreeing under the product equivalence.
- A star subdivision gives the expected proper toric map, and the inverse-image-of-support
  criterion proves properness without assuming compactness of individual noncompact charts.
- A countable locally finite regular fan gives a Hausdorff second-countable complex manifold.
  Dropping countability does not produce a second-countability theorem.
- The toric boundary of a regular fan is proved simple normal crossings in the existing
  manifold vocabulary; a record carrying that conclusion as a field does not satisfy the target.
- The algebraic comparison is natural on every affine chart and overlap.  An unrelated
  homeomorphism of the final carriers does not satisfy the target.
- No public declaration introduces a competing cone, fan, semigroup, toric scheme, orbit
  quotient, or biholomorphism type.

## References and coordination

- Yaël Dillies et al., [*Toric varieties in Lean*](https://github.com/YaelDillies/Toric),
  including its blueprint and `Toric/Mathlib` prerequisites.  Coordinate with its maintainers
  before integrating source material.
- David Cox, John Little, and Henry Schenck, *Toric Varieties*, Graduate Studies in Mathematics
  124, American Mathematical Society, 2011.
- William Fulton, *Introduction to Toric Varieties*, Annals of Mathematics Studies 131,
  Princeton University Press, 1993.
- Tadao Oda, *Convex Bodies and Algebraic Geometry*, Ergebnisse der Mathematik 15,
  Springer, 1988.
- George Kempf, Finn Knudsen, David Mumford, and Bernard Saint-Donat,
  *Toroidal Embeddings I*, Lecture Notes in Mathematics 339, Springer, 1973.
- Robert Gunning and Hugo Rossi, *Analytic Functions of Several Complex Variables*,
  Prentice-Hall, 1965, Chapter I.

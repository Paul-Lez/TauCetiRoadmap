# Roadmap: Fuchsian groups and orbifold Riemann surfaces

This roadmap develops discrete subgroups of `PSL(2,R)`, their action on the upper half-plane,
the quotient Riemann surfaces and orbifold points produced by elliptic stabilizers, and the
compactification produced by adjoining cusp orbits.  It exposes the actual group action,
stabilizers, quotient maps, local coordinates, and compact Riemann surface.  Orbifold signatures
and presentations are theorems derived from those objects, not substitutes for constructing
them.

The main reusable endpoint is a compactification theorem for cofinite Fuchsian groups.  A
second endpoint applies it to the level-one modular group in the mathematically correct order:
first construct the compact Riemann surface, then descend and extend the normalized modular
`j`-function, then prove that map has degree one, and only then identify the surface
biholomorphically with the Riemann sphere.

Suggested homes: `TauCeti/Analysis/Complex/Fuchsian/` for groups, polygons, and cusps, and
`TauCeti/Geometry/RiemannSurface/Orbifold/` for quotient charts and compactification.

## Scope and completion criterion

The scope is orientation-preserving Fuchsian groups acting on the upper half-plane, with special
attention to cofinite groups, finite elliptic stabilizers, cusp compactification, triangle
groups, orbifold fundamental groups, and descent of invariant meromorphic functions.

Teichmüller theory, general Kleinian groups, higher-dimensional locally symmetric spaces,
automorphic representations, and the classification of all two-dimensional orbifolds are
outside this roadmap.  Congruence-subgroup arithmetic, Hecke operators, modular-form dimension
formulas, and the construction and q-expansion of modular forms remain with the modular-forms
roadmap.

The roadmap is complete when Tau Ceti proves the following.

1. `PSL(2,R)` has its effective continuous faithful holomorphic action on Mathlib's
   `UpperHalfPlane`.  Discrete subgroups act properly discontinuously, and all stabilizers are
   finite.
2. The free locus has the standard orbit quotient, covering projection, and complex-manifold
   structure.  At an elliptic point of stabilizer order `m`, a linearizing coordinate identifies
   the local quotient with `z |-> z^m`; the quotient surface remains smooth and the quotient map
   has ramification index `m`.
3. Parabolic fixed points, cusps, widths, precisely invariant horodiscs, and q-coordinates are
   constructed intrinsically.  For a cofinite group there are finitely many cusp orbits.
4. Adjoining those cusp orbits to the coarse quotient gives a compact Hausdorff
   second-countable Riemann surface.  The inclusion of the uncompactified quotient is open, and
   the q-coordinate gives every cusp chart.
5. Invariant holomorphic and meromorphic functions descend through the quotient and extend
   across cusps under exact q-expansion or growth hypotheses.  Local orders upstairs and
   downstairs account for elliptic ramification and cusp widths.
6. Finite holomorphic maps between compact connected Riemann surfaces have a map-level degree
   theory, and a degree-one map is a biholomorphism.
7. Fundamental polygons and the Poincaré polygon theorem produce the expected presentations,
   orbifold signatures, genus formula, and triangle-group examples.
8. The level-one modular quotient is constructed and compactified before any identification
   with `P^1`; the descended normalized `j`-map has degree one and supplies that identification.

## Ownership and dependencies

- **Mathlib owns the upper half-plane and matrix action.**  Consume `UpperHalfPlane`,
  `SL(2,R)`, the Möbius action, fixed-point classification, continuous and proper actions, and
  the theorem that a discrete subgroup of `SL(2,R)` acts properly discontinuously.
- **This roadmap owns the effective projective action.**  Factor the `SL(2,R)` action through
  its center to `PSL(2,R)`, install the quotient topology and topological-group structure, and
  prove faithfulness and holomorphy.  A subgroup of `PSL(2,R)` is the public Fuchsian-group
  input; no bespoke structure repeats a subgroup, topology, action, and discreteness fields.
- **The complex-manifolds roadmap owns `P^1`, general free complex quotients, compatible atlas
  gluing, and the underlying complex-manifold vocabulary.**  This roadmap applies its free
  quotient theorem on the free locus and supplies the elliptic and cusp charts needed beyond
  that theorem.
- **The universal-covers roadmap owns universal covers, deck groups, lifting criteria, and
  induced maps on homotopy groups.**  This roadmap identifies the upper-half-plane quotient as
  an instance of that theory and contributes the Fuchsian and orbifold presentations.
- **The conformal-mapping roadmap owns the Riemann mapping theorem, analytic continuation, and
  Schwarz reflection.**  These are consumed in polygon uniformization and local extension
  arguments.
- **The modular-forms roadmap owns modular forms and functions before descent, including the
  normalized level-one `j`-function, modular invariance, q-expansion, and exact elliptic orders;
  it also owns congruence-subgroup arithmetic, Riemann--Roch applications, and dimension
  formulas.**  This roadmap owns the generic Fuchsian quotient and cusp-compactification
  substrate.  The level-one example consumes the stated `j` results and does not reconstruct
  modular forms.
- **The algebraic-curves roadmap owns algebraic curves and their function fields.**  This
  roadmap constructs analytic Riemann surfaces.  It proves no GAGA equivalence and creates no
  algebraic curve by declaration.

## Pinned conventions

These conventions prevent silent inversions and non-effective actions.

- `PSL(2,R)` means Mathlib's `Matrix.ProjectiveSpecialLinearGroup (Fin 2) R`, the quotient of
  `SL(2,R)` by its center.  The action on `UpperHalfPlane` is the factor of Mathlib's `SL(2,R)`
  action.  Results about stabilizers use this effective action, not an `SL(2,R)` lift containing
  a central element that fixes every point.
- A Fuchsian group is a `Subgroup PSL(2,R)` with the inherited topology and a proof of
  discreteness.  Proper discontinuity is obtained as a theorem or typeclass from that input.
- Hyperbolic area on `UpperHalfPlane` is the measure with density `y⁻² dx dy`, identified with
  the Riemannian volume of the hyperbolic metric and proved invariant under `PSL(2,R)`.  The
  covolume of a Fuchsian group is the area of a measurable fundamental domain, proved independent
  of that domain.  A group is cofinite exactly when this covolume is finite.
- Quotients are `MulAction.orbitRel.Quotient`; projections are the ordinary quotient maps.  The
  free-locus projection is a covering and local biholomorphism.  The full coarse quotient is not
  falsely claimed to be a covering at elliptic points.
- Stabilizers are `MulAction.stabilizer Γ z`.  Elliptic order is the finite cardinality of that
  subgroup, proved cyclic from the derivative action in a local disc coordinate.
- A cusp is an orbit of a parabolic fixed point in Mathlib's boundary carrier `OnePoint ℝ`.
  Width is the positive
  translation length after an explicitly normalized conjugation taking the cusp to infinity.
  Changing that conjugation has a proved effect on the q-coordinate.
- The normalized cusp coordinate is `q(z)=exp(2*pi*i*z/w)` for positive width `w`.  Positive
  translation by `w` fixes `q`.  Meridians are counterclockwise-positive around `q=0`; prove the
  associated deck-generator convention and its orientation-reversal law.
- Elliptic charts use a coordinate centered at the fixed point in which a generator acts by a
  primitive `m`th root of unity.  The quotient coordinate is `u=z^m`.  Ramification order is
  defined from this map-level local normal form.
- The compactified carrier is built from the coarse quotient and the finite set of cusp orbits,
  with topology and charts subsequently proved.  It is not defined to be a known compact
  Riemann surface.
- Orbifold signature is derived from the genus of the compactification, the list of elliptic
  stabilizer orders, and the number of cusp orbits.  Public theorems continue to expose those
  underlying objects.
- A finite holomorphic map's degree is the sum of local multiplicities over a fibre, proved
  independent of the chosen regular value.  Degree is not a field supplied to a map record.
- `P^1` is the Riemann sphere supplied by the complex-manifolds roadmap.  A quotient becomes
  `P^1` only through a named biholomorphism proved after the quotient has been compactified.

## Existing foundations to consume

The development starts from the following material.

- `Mathlib/Analysis/Complex/UpperHalfPlane/`: the topology and complex manifold on
  `UpperHalfPlane`, the Möbius action of `SL(2,R)`, fixed points, and properness of the action.
- `Mathlib/Topology/Algebra/Group/DiscontinuousSubgroup.lean` and
  `ProperlyDiscontinuousSMul`, including finiteness of stabilizers and local separation.
- `MulAction.orbitRel.Quotient`, quotient topology, quotient-covering maps on the free locus,
  and Mathlib's charted-space construction for free properly discontinuous quotients.
- Mathlib's complex analytic functions, isolated zeros, removable singularities, power series,
  exponential, winding and argument principles, and one-point compactification.
- Mathlib's measure, integration, change-of-variables, and Riemannian-volume APIs; this roadmap
  constructs the invariant hyperbolic area measure and quotient covolume from them.
- The complex-manifolds roadmap's Riemann sphere, complex quotient theorem, atlas gluing, and
  holomorphic local-diffeomorphism/descent APIs.
- The universal-covers roadmap's covering and deck-transformation results.
- The conformal-mapping roadmap's Riemann mapping and Schwarz-reflection results.
- The modular-forms roadmap's normalized level-one `j`, its invariance, q-expansion, and exact
  orders at elliptic points.

## Layer 0: the effective projective Möbius action

1. Equip `PSL(2,R)` with the quotient topology from `SL(2,R)` and prove it is a Hausdorff
   second-countable topological group.  Relate the quotient map to Mathlib's algebraic quotient
   by the center.
2. Factor the `SL(2,R)` Möbius action through the center to a named monoid homomorphism
   `PSL(2,R) -> Equiv.Perm UpperHalfPlane`.  Prove the factor is well defined, continuous,
   faithful, and acts by biholomorphisms.
3. Prove that a discrete subgroup `Γ <= PSL(2,R)` acts properly discontinuously.  Relate this
   theorem to Mathlib's result for discrete subgroups of `SL(2,R)` through projective lifts,
   without forcing a choice of lift into the public interface.
4. Prove finiteness of every stabilizer.  Classify a nontrivial stabilizer as finite cyclic,
   generated by an elliptic element, and identify its order with the order of the derivative in
   a disc coordinate.
5. Define the free locus by `stabilizer Γ z = bot`; prove it is open and invariant.  Apply the
   generic quotient theorem there and prove the projection is a covering and local
   biholomorphism.

**Source spine:** Beardon, Chapters 7--8; Katok, §§2.1--2.4; Mathlib's
`UpperHalfPlane/ProperAction.lean` and `UpperHalfPlane/FixedPoints.lean`.

## Layer 1: elliptic points and coarse quotient charts

1. For an elliptic fixed point `z` of order `m`, construct an invariant disc whose translates
   are disjoint outside its stabilizer.  Conjugate the stabilizer action holomorphically to
   multiplication by the `m`th roots of unity.
2. Prove the finite cyclic quotient theorem for a disc: `u -> u^m` is the orbit map, its target
   is a disc, it is a local biholomorphism away from zero, and its local multiplicity at zero is
   exactly `m`.
3. Glue these elliptic quotient charts to the free quotient atlas.  Prove the full coarse
   quotient is Hausdorff, second countable, and a Riemann surface; the quotient projection is
   holomorphic and ramified exactly at elliptic orbits.
4. Prove independence from the invariant discs, linearizing coordinates, and stabilizer
   generators.  Record the exact transition law under replacement of a generator by another
   primitive generator.
5. Prove descent and pullback criteria for holomorphic and meromorphic functions, with the local
   order formula
   `ord_z(f upstairs) = m * ord_[z](f descended)` at a point of stabilizer order `m`.

**Source spine:** Farkas--Kra, Chapter I §§4--5; Miranda, Chapter III §§3--4; Katok, §2.4.

## Layer 2: hyperbolic polygons and cofinite groups

1. Construct the hyperbolic area form and its associated measure on `UpperHalfPlane`; prove the
   density formula `y⁻² dx dy`, local finiteness, and invariance under the effective projective
   action.  Define measurable fundamental domains, prove their areas agree, define covolume and
   cofiniteness, and derive the Gauss--Bonnet area formula for finite hyperbolic polygons.
2. Develop geodesics, half-planes, convex hyperbolic polygons, sides, vertices, side pairings,
   cycles, and angles using Mathlib's upper-half-plane metric and topology.  Prove the local
   finiteness facts required for translated polygons.
3. Prove the Poincaré polygon theorem for a finite-sided polygon with explicit side-pairing,
   cycle, angle, and no-overlap hypotheses.  Construct the generated discrete subgroup,
   fundamental-set theorem, and group presentation.
4. Prove the converse finite-area polygon theorem for a cofinite Fuchsian group and the
   equivalence between finite hyperbolic covolume and a finite-sided fundamental polygon with
   finitely many ideal vertices.
5. Extract elliptic cycles, parabolic cycles, cusp orbits, genus, and the standard presentation
   from the polygon.  Prove the relation between orientation of the boundary word and orientation
   of meridians in the quotient.
6. Construct hyperbolic triangle groups from polygon reflections and their
   orientation-preserving subgroups.  For parameters satisfying the hyperbolic inequality,
   prove discreteness, faithfulness of the presentation, the elliptic orders, and the number of
   cusps.  Treat `(p,q,infinity)` as one theorem family rather than separate hard-coded groups.

**Source spine:** Beardon, Chapters 9--11; Katok, Chapters 3--4; Stillwell, Chapter 5.

## Layer 3: cusps and q-coordinates

1. Classify parabolic elements and their unique boundary fixed points.  Define cusp orbits in
   `OnePoint ℝ` and prove finiteness for cofinite groups.
2. For each cusp, choose and normalize a projective transformation taking it to infinity.
   Prove that its stabilizer is infinite cyclic modulo the effective action and has a unique
   positive width `w`.
3. Construct sufficiently high horodiscs which are precisely invariant under the cusp
   stabilizer.  Prove distinct cusp-orbit horodiscs have disjoint images after shrinking and that
   the complement of their images in a finite-area fundamental polygon is compact.
4. Define `q(z)=exp(2*pi*i*z/w)`.  Prove invariance under translation by `w`, identify the
   punctured-disc quotient biholomorphically, prove `q -> 0` along the cusp, and calculate the
   effect of changing the normalized cusp representative.
5. Prove the Laurent/q-expansion criterion: an invariant holomorphic function descends on the
   punctured cusp; boundedness gives a removable singularity, polynomial exponential growth gives
   a pole of controlled order, and decay gives a zero of controlled order.

**Source spine:** Diamond--Shurman, §§2.3--2.4; Katok, §§3.4 and 4.2; Forster, §19.

## Layer 4: compactified quotient Riemann surfaces

The construction order in this layer is normative.

1. Form the carrier by adjoining one point for each cusp orbit to the coarse quotient.  Define
   cusp neighbourhoods from the precisely invariant horodiscs and prove the topology is
   independent of all height choices.
2. Prove the carrier is Hausdorff and second countable.  For a cofinite group, use the compact
   truncated fundamental polygon plus finitely many cusp discs to prove compactness.
3. Extend the quotient atlas with the q-coordinate at every new point.  Verify transitions with
   free and elliptic charts, then prove `ChartedSpace` and `IsManifold 𝓘(ℂ, ℂ) ∞`.
4. Prove that the original quotient is an open dense submanifold and that the compactifying
   points are exactly the complement.  Prove functoriality for conjugate groups and finite-index
   subgroup inclusions.
5. Derive the orbifold signature from the compact surface, elliptic stabilizer orders, and cusp
   set.  Prove the orbifold Euler-characteristic and area formula, including all factors of
   `2*pi` and the effective `PSL` convention.

No step identifies the carrier with `P^1`, a torus, or another classified surface by definition.

**Source spine:** Katok, Chapter 4; Diamond--Shurman, §§2.4--2.5; Forster, §§18--19.

## Layer 5: maps, ramification, and degree

1. Prove that a `Γ`-invariant holomorphic or meromorphic function descends uniquely to the
   coarse quotient.  Combine the elliptic local-order formula and cusp q-expansion criterion to
   extend it to the compactification.
2. Develop local multiplicity for nonconstant holomorphic maps of Riemann surfaces from the
   local power-series normal form.  Prove positivity, multiplicativity under composition, and
   discreteness of branch points.
3. For a nonconstant holomorphic map between compact connected Riemann surfaces, prove that each
   fibre is finite and that the sum of local multiplicities is independent of the target point.
   Define degree from this common sum and prove functoriality.
4. Prove that degree one implies bijectivity and a holomorphic inverse, hence a biholomorphism.
   Prove the corresponding divisor pullback and local-order statements consumed by modular
   functions.
5. Prove Riemann--Hurwitz at the map level.  Coordinate its declaration shape with the
   modular-forms compact-Riemann-surface development, and use one shared theorem family rather
   than creating competing degree and ramification APIs.

**Source spine:** Forster, §§10, 17, and 19; Miranda, Chapter III §§3--4; Farkas--Kra,
Chapter II §4.

## Layer 6: the level-one modular quotient, in construction order

This layer consumes the modular-forms roadmap's normalized `j`-function, modular invariance,
q-expansion, and exact elliptic orders.

1. Apply Layers 0--4 to the effective level-one modular group.  Construct its coarse quotient,
   elliptic charts, unique cusp, and compact Riemann surface `X(1)`.  Prove its signature from
   the standard fundamental polygon.
2. Descend the normalized `j : UpperHalfPlane -> C` to the uncompactified quotient.  Use its
   q-expansion to extend it meromorphically over the cusp and its elliptic orders to compute all
   local multiplicities on `X(1)`.
3. Regard the extension as a holomorphic map `X(1) -> P^1`.  Prove it has a single simple pole
   over infinity, equivalently degree one, using Layer 5's fibre-counting theorem.
4. Apply the degree-one theorem to obtain a named biholomorphism `X(1) ≃ P^1`.  Normalize it by
   the cusp and elliptic images and prove that this biholomorphism is the descended `j`-map.
5. Transfer no atlas backward by fiat: every statement about `P^1` is obtained through this
   proved biholomorphism after the compact quotient already exists.

**Source spine:** Diamond--Shurman, §§2.3--2.5; Serre, Chapter VII; the modular-forms roadmap's
`j` targets.

## Dependency order and parallel work

| Track | Depends on | Feeds |
| --- | --- | --- |
| L0 effective action and free locus | Mathlib, complex manifolds | L1--L4 |
| L1 elliptic charts | L0, complex-manifold gluing | L4--L6 |
| L2 polygons and presentations | L0, conformal mapping | L3--L4, L6 |
| L3 cusps and q-coordinates | L0, L2 | L4--L6 |
| L4 compactification | L1--L3 | L5--L6 |
| L5 degree theory | complex analysis, compact Riemann surfaces | L6 |
| L6 level-one example | L0--L5, modular forms | normalized `X(1) ≃ P^1` |

L1 and L2 can proceed in parallel after L0.  The local q-coordinate calculation in L3 can
proceed while the global polygon results are completed.  L5's local multiplicity theory can
proceed independently; its global fibre-counting theorem uses compact Riemann surfaces from L4.

## Acceptance checks

- The projective action is effective: an element acting trivially on `UpperHalfPlane` is the
  identity in `PSL(2,R)`.
- A discrete subgroup's stabilizer is finite.  The free-locus quotient projection is a covering,
  while an elliptic point of order `m` has local quotient map `z |-> z^m` and is not mislabeled a
  covering point.
- A cyclic rotation of a disc yields a smooth disc quotient with ramification index equal to the
  group order.
- A width-`w` parabolic translation has q-coordinate invariant under `z |-> z+w`; reversing the
  meridian convention has an explicit proved effect rather than a silent inverse.
- A finite-sided cofinite polygon produces a compact surface after one point is adjoined for each
  cusp orbit, with compactness proved from a truncated fundamental polygon.
- The triangle-group theorem handles all hyperbolic `(p,q,infinity)` parameters from one API and
  derives the presentation and signature from side pairings.
- Invariant functions descend through `MulAction.orbitRel.Quotient`; no choice-based quotient
  section occurs in the public construction.
- Local orders downstairs multiply by elliptic stabilizer order on pullback.  Cusp orders use the
  normalized q-coordinate and cusp width.
- The level-one compact quotient is a compact Riemann surface before the normalized `j`-function
  is descended.  The proof of `X(1) ≃ P^1` passes through the theorem that the descended map has
  degree one.
- A structure whose fields assert compactness, the orbifold signature, degree, or the final
  biholomorphism does not satisfy the roadmap.

## References

- Alan Beardon, *The Geometry of Discrete Groups*, Graduate Texts in Mathematics 91,
  Springer, 1983, especially Chapters 7--11.
- Svetlana Katok, *Fuchsian Groups*, Chicago Lectures in Mathematics, University of Chicago
  Press, 1992, especially Chapters 2--4.
- Fred Diamond and Jerry Shurman, *A First Course in Modular Forms*, Graduate Texts in
  Mathematics 228, Springer, 2005, §§2.3--2.5.
- Otto Forster, *Lectures on Riemann Surfaces*, Graduate Texts in Mathematics 81,
  Springer, 1981, especially §§10 and 17--19.
- Hershel Farkas and Irwin Kra, *Riemann Surfaces*, Graduate Texts in Mathematics 71,
  Springer, second edition, 1992.
- Rick Miranda, *Algebraic Curves and Riemann Surfaces*, Graduate Studies in Mathematics 5,
  American Mathematical Society, 1995, Chapter III.
- Jean-Pierre Serre, *A Course in Arithmetic*, Graduate Texts in Mathematics 7,
  Springer, 1973, Chapter VII.
- John Stillwell, *Geometry of Surfaces*, Universitext, Springer, 1992, Chapter 5.

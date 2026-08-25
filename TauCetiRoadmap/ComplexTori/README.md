# Complex tori: varying lattices and logarithmic transforms

This roadmap develops complex tori and holomorphic families of them from period lattices, then
builds cyclic affine quotients and logarithmic transforms at their natural generality. The
resulting library keeps the period lattice visible, distinguishes quotient coverings from family
projections, and classifies cyclic affine actions through their norm and cokernel data.

Suggested homes are `TauCeti/Geometry/ComplexTorus/`,
`TauCeti/Geometry/Manifold/Fibration/Torus/`, and
`TauCeti/Geometry/Manifold/LogTransform/`.

## Scope and completion criterion

The roadmap is complete when Tau Ceti proves all of the following.

1. A full discrete lattice in a finite-dimensional complex normed vector space gives the standard
   orbit quotient a compact connected complex Lie-group structure, functorially in complex linear
   maps preserving lattices.
2. A coordinatewise-holomorphic family of full period lattices over a complex manifold gives a
   complex manifold whose map to the base is a holomorphic submersion with complex-torus fibres.
   The map from the product before quotienting is separately a covering map and local
   biholomorphism.
3. Equivariant period data descend through properly discontinuous actions on the base, with local
   product charts, monodromy, marked homology, and natural base change.
4. A finite cyclic affine action has a complete algebraic API: the iterate formula, the norm-sum
   order condition, translation-conjugacy and cokernel classes, and an exact fixed-point and
   freeness criterion for every nonidentity power.
5. Cyclic affine actions over a rotated disc produce holomorphic multiple fibres and logarithmic
   transforms while retaining the varying lattice. Their multiplicity, normal-bundle character,
   canonical character, punctured-disc gauges, and change-of-choice laws are proved.
6. Fundamental-group and homology maps induced by the punctured collar and filling are derived
   from the actual quotient and bundle maps, ready for use by geometric constructions without
   construction-specific theorem records.

This roadmap owns complex-torus quotients, varying period families, their equivariant descent,
cyclic affine actions, and analytic logarithmic transforms. It does not own general complex-
manifold quotient or gluing theorems, universal-cover classification, Fuchsian groups, period-
function existence, analytic toric geometry, general singular homology, manifold collars, or a
specific global assembly.

## Ownership and dependencies

- The complex-manifolds roadmap owns realification, free properly discontinuous smooth and
  complex quotients, holomorphic descent, holomorphic bundles, and compatible open gluing. This
  roadmap consumes those results on the standard orbit quotient and adds the torus-family and
  cyclic-affine geometry.
- The [universal-covers roadmap](../UniversalCovers/README.md) owns covering spaces, deck groups,
  and lifting. This roadmap uses its quotient-cover and monodromy interfaces; it does not package
  another equivariant universal cover.
- The algebraic-topology roadmap owns general fundamental groups, singular homology, Wang
  sequences, transfer, and homology of tori. This roadmap proves which maps arise from a torus
  family or logarithmic transform and applies that generic theory.
- The [geometric-topology roadmap](../GeometricTopology/README.md) owns collars and boundary
  gluing. This roadmap constructs the analytic punctured-disc gauges and proves their boundary
  maps are smooth and holomorphic where appropriate.
- The analytic-toric-geometry roadmap owns fan constructions and toric degenerations. This
  roadmap treats smooth period-lattice families and finite cyclic multiple fibres; a toric
  degeneration consumes both roadmaps.
- The Fuchsian-groups roadmap owns orbifold bases and their quotient uniformization. An orbifold
  torus family supplies its period representation and then consumes this roadmap's equivariant
  descent.

Coordinate with those roadmaps before integrating an overlapping implementation. Mathlib owns
the shape of its quotient, manifold, lattice, and bundle APIs; Tau Ceti implements missing
results at the dependency pin rather than waiting for another repository.

## Mathlib inventory

Use the following objects without replacement wrappers.

- `Submodule ℤ E`, `LinearMap.range`, `DiscreteTopology`, and `IsZLattice ℝ L` for a period
  lattice. `IsZLattice` supplies full real rank; do not add a second rank witness.
- `AddAction.orbitRel.Quotient` for every translation quotient,
  `ProperlyDiscontinuousVAdd`, `IsAddQuotientCoveringMap`, and the complex-quotient theorem from
  the complex-manifolds roadmap.
- `LinearMap`, `LinearEquiv`, `ContinuousLinearMap`, `ContinuousLinearEquiv`, `Representation`,
  `Module.Dual`, exterior powers, and quotient modules for period maps and monodromy.
- `ContMDiff`, `IsLocalDiffeomorph`, `ContMDiffMap`, `FiberBundle`, `VectorBundle`, and
  `ContMDiffVectorBundle` for the manifold and fibration interfaces.
- Mathlib's `AddCircle`, finite cyclic groups, `Finset.range`, quotient modules, kernels, ranges,
  and cokernels for the cyclic affine calculation.

The complex quotient work in
[mathlib4#40727](https://github.com/leanprover-community/mathlib4/pull/40727) determines the
orbit-quotient shape consumed here. Build the missing manifold theorem locally in the complex-
manifolds roadmap and replace it by imports when available.

## Encoding conventions

- Fix a finite free ℤ-module `Λ`, a finite-dimensional complex normed vector space `E`, and a
  complex manifold `Y`. A period family is stated directly as
  `Π : Y → (Λ →ₗ[ℤ] E)`, together with coordinatewise holomorphy
  `∀ λ, ContMDiff I 𝓘(ℂ, E) ∞ (fun y ↦ Π y λ)`, pointwise injectivity, and the hypotheses
  `[DiscreteTopology (LinearMap.range (Π y))]` and
  `[IsZLattice ℝ (LinearMap.range (Π y))]` for each `y`. Do not bundle these propositions merely
  to give the constructor a custom input record.
- The lattice acts on `Y × E` by
  `λ +ᵥ (y, v) = (y, v + Π y λ)`. The total space is the standard
  `AddAction.orbitRel.Quotient Λ (Y × E)` for this action, not a tagged quotient.
- Write `q : Y × E → (Y × E)/Λ` for the orbit projection. It is a covering map and local
  biholomorphism. Write `p : (Y × E)/Λ → Y` for the map descended from `Prod.fst`. It is a
  holomorphic submersion with compact torus fibres. These are different maps with different
  local models; no theorem calls `p` a local diffeomorphism when `E` has positive dimension.
- Monodromy acts on the single lattice `Λ`; actions on homology are derived functorially from it.
  A choice of basis yields coordinate lemmas, not a second matrix-valued representation.
- A logarithmic transform retains the varying period family. Replacing it by a product with one
  fixed torus is not an admissible intermediate API.
- Clockwise and counterclockwise meridians are separate conventions. Once one is selected, prove
  that reversing it inverts monodromy and negates additive twist data.

## Milestone 1: fixed complex tori

Let `L : Submodule ℤ E` have its subtype topology, `[DiscreteTopology L]`, and
`[IsZLattice ℝ L]`.

1. Construct the translation action on `E`, prove it free and properly discontinuous, and use the
   standard additive orbit quotient. Apply the complex-manifold quotient theorem to prove that the
   quotient is a complex manifold and the orbit map is a local biholomorphism.
2. Descend addition, negation, and zero and prove the complex Lie-group laws. Prove compactness
   from a lattice fundamental domain, connectedness, Hausdorffness, and second countability.
3. For a complex linear map `f : E →ₗ[ℂ] E'` satisfying `f '' L ≤ L'`, construct the induced
   holomorphic homomorphism of tori. Prove identity, composition, products, kernels under the
   standard closedness hypotheses, and the equivalence criterion for continuous linear
   equivalences carrying one lattice onto the other.
4. Identify the universal covering and deck action through the universal-covers roadmap. Consume
   the algebraic-topology roadmap to identify `π₁` and integral homology with the lattice and its
   exterior powers, naturally in induced maps.

Birkenhake--Lange, *Complex Abelian Varieties*, Chapter 1, supplies the quotient, morphism, and
period-lattice source spine. The roadmap treats all compact complex tori, without assuming a
polarization or algebraicity.

## Milestone 2: holomorphic families from varying periods

Use the direct period-family hypotheses fixed above.

1. Prove the period translation is an `AddAction Λ (Y × E)`, is free, and is properly
   discontinuous. The proof must be uniform over compact subsets of `Y`: construct bounded
   fundamental representatives and prove orbit-local finiteness there.
2. Give the standard orbit quotient its complex-manifold structure. Prove that
   `q : Y × E → (Y × E)/Λ` is a covering map and local biholomorphism.
3. Descend `Prod.fst` to `p : (Y × E)/Λ → Y`. Prove that `p ∘ q = Prod.fst`, that `p` is a
   holomorphic submersion, and that its local charts have product form. Identify the fibre over
   `y` biholomorphically with `E / LinearMap.range (Π y)`.
4. Prove fibre compactness, total-space Hausdorffness and second countability, existence and
   holomorphy of the zero section, and naturality under base change.
5. Define markings as isomorphisms from the local system of first integral homology groups to the
   constant lattice local system. Prove change-of-marking and monodromy laws through the local-
   system or covering API, not through unrelated matrices at each fibre.

For the analytic family construction use Birkenhake--Lange, Chapter 8, on families and period
data, together with the quotient-manifold source spine in the complex-manifolds roadmap.

## Milestone 3: equivariant descent and monodromy

Let a discrete group `Γ` act properly discontinuously by biholomorphisms on `Y`. Let
`ρ : Representation ℤ Γ Λ` and a holomorphic family of complex linear equivalences
`R_g(y) : E ≃L[ℂ] E` satisfy the exact cocycle and period-equivariance laws.

1. Lift the action to `Y × E` by `(y, v) ↦ (g • y, R_g(y) v)`. Prove the group law from the
   cocycle and prove that it normalizes the period translation action using
   `Π (g • y) (ρ g λ) = R_g(y) (Π y λ)`.
2. Descend the action to the varying torus family, prove it biholomorphic and properly
   discontinuous under explicit orbit-local-finiteness hypotheses, and form the standard second
   quotient.
3. Descend the family projection to `Y/Γ`, prove local product charts over the free locus, and
   identify its monodromy with `ρ`. Derive the action on homology through exterior powers.
4. Prove naturality under equivariant base change, conjugation of the marking, and reversal of
   loop orientation.

The universal-covers roadmap supplies deck and monodromy foundations; this milestone owns only
their application to period-lattice families.

## Milestone 4: cyclic affine algebra

Fix `m > 0`, an additive automorphism `A : Λ ≃+ Λ`, and translation data. The order and freeness
hypotheses must be theorem arguments, not fields whose intended consequences are assumed.

1. Define `affineEquiv A t : Λ ≃ Λ` by `x ↦ A x + t` and
   `cyclicNorm A k t = ∑ i ∈ Finset.range k, (A ^ i) t`. Prove for every `k`

   `((affineEquiv A t)^[k]) x = (A ^ k) x + cyclicNorm A k t`.

2. Under `A ^ m = 1`, prove that the affine generator has `m`-th power equal to the identity
   exactly when `cyclicNorm A m t = 0`. Prove the divisor and exact-order criteria, rather than
   deriving an action of `ZMod m` from `A ^ m = 1` alone.
3. Prove the translation-conjugacy formula

   `T_b ∘ affine(A,t) ∘ T_b⁻¹ = affine(A, t + (1-A)b)`.

   Classify normalized translations by the corresponding cokernel class. For lattice
   `m`-division data `v/m` with `A v = v`, prove that changing the normalized lift changes `v` by
   `LinearMap.range (A - 1)`, so the invariant is the actual class of `v` in
   `Λ ⧸ LinearMap.range (A - 1)`. Supply the induced norm and change-of-representative lemmas.
4. On a torus `T`, prove

   `affine(A,t)^k` has a fixed point
   `↔ cyclicNorm A k t ∈ LinearMap.range (1 - A^k)`.

   Thus a `C_m`-action is free exactly when this membership fails for every `k` with
   `0 < k < m`. State and prove the prime-order simplification and the specialization to fixed
   `m`-division data. Testing the generator alone is not accepted for composite `m`.
5. Prove functoriality under equivariant homomorphisms, products, restriction to subgroups, and
   base change. Relate the norm, invariant, and coinvariant groups to the standard cyclic-group
   cohomology calculation.

Brown, *Cohomology of Groups*, Chapter VI, Section 2, supplies the cyclic norm, invariants,
coinvariants, and periodic cohomology spine. The fixed-point criterion follows directly from the
affine iterate equation and is proved in the torus quotient, not asserted as a freeness field.

## Milestone 5: cyclic quotients and multiple fibres

Let `D` be a complex disc with a rotation `r` of exact order `m`, and let a varying torus family
over `D` carry compatible period monodromy and affine translation data from Milestone 4.

1. Construct the generator on the total torus family, prove it biholomorphic, and prove its
   `m`-th power is the identity from `A ^ m = 1` and the translation norm equation. Use the exact
   fixed-point criterion to prove that the action is free.
2. Take the standard complex quotient and descend the base map `z ↦ z^m`. Prove this map is a
   holomorphic submersion away from the central fibre and has a multiple central fibre of
   multiplicity exactly `m`.
3. In every transverse chart prove the local normal form `t = a u^m`, with `a` a nowhere-zero
   holomorphic unit. Identify the reduced fibre and its quotient by the central affine action.
4. Use the complex-manifolds roadmap's holomorphic-line-bundle API to prove that the normal bundle
   of the reduced fibre has `m`-th tensor power trivial. Identify its character and prove exact
   order from the exact affine class and faithful base rotation.
5. Compute the canonical-bundle character from the derivative of the affine generator and give an
   exact-order criterion. Prove smoothness, compactness, and complex-manifold instances for the
   reduced quotient under their explicit hypotheses.

Barth--Hulek--Peters--Van de Ven, *Compact Complex Surfaces*, second edition, Chapter V, the
section “Logarithmic Transformations” (beginning on p. 216), supplies the local cyclic-quotient
model. The statements here allow higher-dimensional torus fibres.

## Milestone 6: logarithmic gauges and regluing

1. Over a punctured disc, construct logarithmic gauges from a chosen branch of logarithm. Prove
   that changing the branch acts by the corresponding lattice translation and therefore gives the
   same descended biholomorphism.
2. Identify the punctured restriction of the cyclic quotient with the original varying torus
   family after the prescribed base change. Prove the forward and inverse formulas and their
   holomorphy.
3. Construct compatible smooth collars through the geometric-topology roadmap and prove that the
   punctured gauge restricts to the collar map used for regluing. Apply the complex-manifolds
   roadmap's open-gluing theorem to the analytic pieces.
4. Prove independence, up to biholomorphism over the base, of disc radius, collar width, logarithm
   branch, and linearizing coordinate while holding the period family and affine cokernel class
   fixed. State separately how changing the cokernel class changes the gluing map.
5. Compute the induced maps on fundamental groups and first homology from the actual collar and
   quotient maps. Record fibre lattice generators and the selected meridian convention, and prove
   the inversion law under orientation reversal.

The logarithmic-transform section of Barth--Hulek--Peters--Van de Ven gives the local proof spine.

## Dependency order

Milestone 1 consumes the complex-manifolds, universal-covers, and algebraic-topology roadmaps.
Milestone 2 uses Milestone 1 and the compact-uniform part of the lattice theory. Milestone 3 uses
Milestone 2 and the universal-covers roadmap. Milestone 4 is algebraic and can proceed in parallel
with Milestones 1--3. Milestone 5 uses Milestones 2 and 4 together with the complex-manifolds
roadmap's holomorphic-line-bundle API. Milestone 6 uses Milestone 5 together with the
complex-manifolds and geometric-topology gluing APIs.

## Acceptance checks

- A lattice range is accepted through `Submodule`, `DiscreteTopology`, and `IsZLattice ℝ`; a
  constructor which requires a chosen basis or a custom full-rank certificate does not discharge
  the target.
- In a varying family, `q : Y × E → (Y × E)/Λ` is proved a local biholomorphism while
  `p : (Y × E)/Λ → Y` is proved a holomorphic submersion. For `E ≠ 0`, no result claims that `p`
  is a local diffeomorphism.
- The fibre over `y` is identified with the standard orbit quotient by
  `LinearMap.range (Π y)`, not with a tagged complex-torus type.
- A cyclic action cannot be constructed from `A ^ m = 1` without the translation norm equation.
- The iterate theorem computes every power, translation conjugacy changes the twist by
  `(1-A)b`, and the normalized lattice twist is stored in the actual cokernel of `A-1`.
- For composite `m`, freeness checks every `0 < k < m` using
  `cyclicNorm A k t ∉ range(1-A^k)`. A proposition which checks only the generator is rejected.
- The cyclic quotient retains the varying period lattice and proves the local equation
  `t = a u^m`; it is not replaced by a product with a fixed torus.
- Branch changes in the punctured logarithmic gauge are proved to be lattice translations, and
  induced `π₁` and `H₁` maps come from the constructed maps.

## References

- Christina Birkenhake and Herbert Lange, *Complex Abelian Varieties*, second edition, Chapters
  1 and 8, for complex tori, period lattices, morphisms, and families.
- Kenneth S. Brown, *Cohomology of Groups*, Chapter VI, Section 2, for cyclic norm and cokernel
  calculations.
- Wolf P. Barth, Klaus Hulek, Chris A. M. Peters, and Antonius Van de Ven,
  *Compact Complex Surfaces*, second edition, Chapter V, “Logarithmic Transformations”.

;; SPDX-License-Identifier: AGPL-3.0-or-later
;; ROADMAP.f0.scm - Foundational phase (f0) roadmap
;;
;; Phase f0: Establish verifiable workflow skeleton for the playground.
;; This is a downstream playground; all language semantics live upstream.

(define roadmap-f0
  '((schema . "hyperpolymath.roadmap/1")
    (phase . "f0")
    (phase-name . "Foundation")
    (date-created . "2026-01-01")
    (target-tier . "bronze")

    (objectives
      . ((primary
           . ("Establish machine-readable anchor schema"
              "Define verification workflow contract"
              "Create minimal offline demo that verifies something concrete"
              "Build example corpus with valid/invalid cases"))
         (secondary
           . ("Document threat model pointers"
              "Clarify README installation story as illustrative"))))

    (deliverables
      . ((.machine_read/LLM_SUPERINTENDENT.scm
           . ((status . "done")
              (description . "Anchor schema defining project identity and constraints")))
         (.machine_read/ROADMAP.f0.scm
           . ((status . "done")
              (description . "This foundational phase roadmap")))
         (.machine_read/SPEC.playground.scm
           . ((status . "done")
              (description . "Verification workflow contract, threat model, demo corpus layout")))
         (just-demo-target
           . ((status . "done")
              (description . "`just demo` runs offline verification of example artifacts")))
         (example-corpus
           . ((status . "planned")
              (description . "At least 2 valid + 2 invalid .obl examples with stable error messages")))))

    (constraints
      . ((no-network . "Demo must work offline")
         (no-runtime-fetch . "No pulling arbitrary toolchains at runtime")
         (downstream-only . "No production compiler work; that belongs upstream")))

    (exit-criteria
      . ((just-list-works . "`just --list` shows available targets")
         (just-demo-works . "`just demo` verifies a concrete artifact offline")
         (just-test-works . "`just test` runs example corpus, 2+ invalid cases fail with stable errors")
         (readme-honest . "README installation section explicitly marked as illustrative")))

    (upgrade-path
      . ((next-phase . "f1")
         (f1-requirements
           . ("Pinned toolchain (Guix channel or Nix flake)"
              "Verification harness with property-based tests"
              "CI integration for smoke tests"))
         (target-tier-after-f1 . "silver")))))

;; end of roadmap-f0

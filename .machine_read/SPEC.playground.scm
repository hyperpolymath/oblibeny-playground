;; SPDX-License-Identifier: AGPL-3.0-or-later
;; SPEC.playground.scm - Verification workflow contract
;;
;; Defines: inputs/outputs, threat model pointers, demo corpus layout.
;; This playground demonstrates verifiable workflows for Oblíbený examples.

(define spec-playground
  '((schema . "hyperpolymath.spec/1")
    (kind . "playground-spec")
    (date . "2026-01-01")

    ;; ─────────────────────────────────────────────────────────────────────
    ;; VERIFICATION WORKFLOW CONTRACT
    ;; ─────────────────────────────────────────────────────────────────────
    (verification-workflow
      . ((description . "Offline verification of Oblíbený example artifacts")

         (inputs
           . ((source-files
                . ((pattern . "examples/*.obl")
                   (format . "Oblíbený source")
                   (required . #t)))
              (constraints-files
                . ((pattern . "examples/*.constraints")
                   (format . "Verification constraints (optional)")
                   (required . #f)))
              (proof-stubs
                . ((pattern . "examples/*.proof")
                   (format . "Proof stub for verified functions")
                   (required . #f)))))

         (outputs
           . ((verification-result
                . ((format . "exit-code + stderr")
                   (success . "exit 0, no output")
                   (failure . "exit 1, error message to stderr")))
              (proof-check-result
                . ((format . "text summary")
                   (description . "Reports which proof obligations were checked")))))

         (invariants
           . ("All verification runs offline (no network)"
              "Invalid inputs produce stable, deterministic error messages"
              "Valid inputs produce exit 0 with no stderr output"))))

    ;; ─────────────────────────────────────────────────────────────────────
    ;; THREAT MODEL POINTERS
    ;; ─────────────────────────────────────────────────────────────────────
    (threat-model
      . ((scope . "playground demonstration only")
         (upstream-reference . "hyperpolymath/oblibeny (authoritative threat model)")

         (playground-specific-threats
           . ((demo-tampering
                . ((description . "Malicious modification of demo artifacts")
                   (mitigation . "Signed commits, pre-commit hooks")))
              (toolchain-substitution
                . ((description . "Attacker substitutes verification toolchain")
                   (mitigation . "No runtime toolchain fetch; pinned in f1")))
              (example-injection
                . ((description . "Malicious .obl file in corpus")
                   (mitigation . "Examples are static, reviewed, committed")))))

         (out-of-scope
           . ("Production compiler security (upstream)"
              "Hardware-level attacks"
              "Supply chain beyond this repository"))))

    ;; ─────────────────────────────────────────────────────────────────────
    ;; DEMO CORPUS LAYOUT
    ;; ─────────────────────────────────────────────────────────────────────
    (demo-corpus
      . ((location . "examples/")

         (structure
           . ((valid-examples
                . ((directory . "examples/")
                   (naming . "NN_name.obl where NN is numeric prefix")
                   (minimum-count . 2)
                   (examples
                     . ("01_authenticate.obl"
                        "02_memory_safe.obl"))))
              (invalid-examples
                . ((directory . "examples/invalid/")
                   (naming . "NN_name.obl with expected error in NN_name.expected")
                   (minimum-count . 2)
                   (examples
                     . ("01_buffer_overflow.obl"
                        "02_timing_leak.obl"))))))

         (test-expectations
           . ((valid-cases . "Must pass verification with exit 0")
              (invalid-cases . "Must fail with stable error message matching .expected file")))

         (corpus-invariants
           . ("All examples are self-contained (no external dependencies)"
              "Error messages are deterministic across runs"
              "No example requires network access"))))

    ;; ─────────────────────────────────────────────────────────────────────
    ;; ENTRY POINTS
    ;; ─────────────────────────────────────────────────────────────────────
    (entry-points
      . ((just-demo
           . ((command . "just demo")
              (behavior . "Verifies valid examples, reports summary")
              (exit-code . "0 on success, 1 on any failure")))
         (just-test
           . ((command . "just test")
              (behavior . "Runs full corpus including invalid cases")
              (exit-code . "0 if invalid cases fail as expected")))))))

;; end of spec-playground

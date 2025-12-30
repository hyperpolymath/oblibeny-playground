;; SPDX-License-Identifier: AGPL-3.0-or-later
;; META.scm - Project metadata and architecture decisions

(define project-meta
  `((version . "1.0.0")
    (name . "oblibeny-playground")
    (architecture-decisions
      ((adr-001
         ((status . "accepted")
          (date . "2025-12-30")
          (context . "Need language for security-critical embedded systems")
          (decision . "Combine formal verification with memory safety")
          (consequences . "Compile-time security guarantees for embedded")))))
    (development-practices
      ((code-style . "rust-standard")
       (security . "openssf-scorecard")
       (testing . "property-based")
       (versioning . "semver")
       (documentation . "asciidoc")
       (branching . "trunk-based")))
    (design-rationale
      ((why-embedded . "Security-critical systems need safety")
       (why-formal . "Proofs for correctness guarantees")
       (why-memory-safe . "No buffer overflows or use-after-free")))))

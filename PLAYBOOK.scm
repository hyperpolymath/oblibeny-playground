;; SPDX-License-Identifier: AGPL-3.0-or-later
;; PLAYBOOK.scm - Operational runbook

(define playbook
  `((version . "1.0.0")
    (project . "oblibeny-playground")
    (procedures
      ((build
         (("setup" . "cargo build")
          ("test" . "cargo test")
          ("check" . "cargo check")))
       (verify
         (("security" . "cargo run -- --security-check src/main.obl")
          ("memory" . "cargo run -- --memory-check src/main.obl")
          ("proofs" . "cargo run -- --verify src/main.obl")))
       (flash
         (("arm" . "cargo run -- --target=arm-cortex-m4 --flash firmware.obl")))))
    (alerts ())
    (contacts ())))

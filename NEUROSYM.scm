;; SPDX-License-Identifier: AGPL-3.0-or-later
;; NEUROSYM.scm - Neurosymbolic integration config

(define neurosym-config
  `((version . "1.0.0")
    (project . "oblibeny-playground")
    (symbolic-layer
      ((type . "scheme")
       (reasoning . "deductive")
       (verification . "formal")
       (language-specific
         ((security . "formal-proofs")
          (memory . "static-analysis")
          (semantics . "operational")))))
    (neural-layer
      ((embeddings . #f)
       (fine-tuning . #f)
       (inference . #f)))
    (integration
      ((ai-assisted-development . "duet-style")
       (security-hints . #t)))))

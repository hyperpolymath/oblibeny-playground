;; SPDX-License-Identifier: AGPL-3.0-or-later
;; ECOSYSTEM.scm - Ecosystem positioning

(ecosystem
  (version . "1.0.0")
  (name . "oblibeny-playground")
  (type . "language-playground")
  (purpose . "Security-critical embedded systems programming")

  (position-in-ecosystem
    ((parent . "language-playgrounds")
     (grandparent . "nextgen-languages")
     (category . "security-critical-languages")))

  (related-projects
    ((anvomidav-playground
       ((relationship . "sibling-standard")
        (description . "Real-time verification, timing focus")))
     (ephapax-playground
       ((relationship . "sibling-standard")
        (description . "Linear types for resource management")))
     (ada-spark
       ((relationship . "inspiration")
        (description . "Formal verification for safety-critical")))))

  (what-this-is
    ("Security-critical embedded language"
     "Formal verification for security"
     "Memory-safe systems programming"))

  (what-this-is-not
    ("General purpose language"
     "Web development"
     "High-level scripting")))

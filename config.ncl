# SPDX-License-Identifier: AGPL-3.0-or-later
# config.ncl - Oblíbený Playground Configuration
# Type-safe configuration using Nickel
# See: https://nickel-lang.org

{
  # Project metadata
  project = {
    name = "oblibeny-playground",
    version = "0.1.0",
    description = "Teaching playground for Oblíbený - security-critical embedded systems",
    license = "AGPL-3.0-or-later",
    author = "Jonathan D.A. Jewell",
    repository = "https://github.com/hyperpolymath/oblibeny-playground",
  },

  # Language configuration
  language = {
    name = "Oblíbený",
    extension = ".obl",
    paradigm = "systems",
    focus = "embedded-security",
    features = [
      "formal-verification",
      "memory-safety",
      "timing-guarantees",
      "secure-by-default",
      "no-heap-allocation",
    ],
  },

  # Security annotations
  annotations = {
    required = [
      "@security_level",
      "@verified",
      "@no_heap",
      "@timing_bound",
    ],
    levels = [
      "critical",
      "high",
      "medium",
      "low",
    ],
  },

  # Verification settings
  verification = {
    wcet_analysis = true,
    memory_bounds = true,
    stack_analysis = true,
    timing_verification = true,
  },

  # Development settings
  development = {
    watch_dirs = [
      "src",
      "examples",
      "test",
    ],
    test_pattern = "test/**/*.obl",
    lint_ignore = [
      "node_modules",
      "lib",
    ],
  },

  # Deployment configuration
  deployment = {
    container = {
      enabled = true,
      registry = "ghcr.io/hyperpolymath",
      image = "oblibeny-playground",
      base_image = "alpine:latest",
    },
    platforms = [
      "linux/amd64",
      "linux/arm64",
    ],
  },
}

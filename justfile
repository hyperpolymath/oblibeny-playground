# SPDX-License-Identifier: AGPL-3.0-or-later
# Oblibeny Playground justfile

default:
    @just --list

# Build the project
build:
    cargo build

# Run tests
test:
    cargo test

# Type check only
check:
    cargo check

# Security analysis
security-check file:
    cargo run -- --security-check {{file}}

# Memory safety analysis
memory-check file:
    cargo run -- --memory-check {{file}}

# Verify proofs
verify file:
    cargo run -- --verify {{file}}

# Run an example
run example="authenticate":
    cargo run -- examples/{{example}}.obl

# Flash to embedded target
flash target file:
    cargo run -- --target={{target}} --flash {{file}}

# Clean build artifacts
clean:
    cargo clean

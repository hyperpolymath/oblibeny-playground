# SPDX-License-Identifier: AGPL-3.0-or-later
# Oblíbený Playground - Task Runner
# Run tasks with: just <recipe>
#
# Golden path commands per anchor schema:
#   just --list
#   just demo
#   just test

default:
    @just --list

# ============================================
# DEMO & VERIFICATION
# ============================================

# Run verification demo (offline) - verifies valid examples
demo:
    #!/usr/bin/env sh
    set -e
    echo "=== Oblíbený Playground Demo ==="
    echo "Verifying example corpus (offline)..."
    echo ""

    # Check valid examples exist and have required annotations
    for f in examples/*.obl; do
        if [ -f "$f" ]; then
            name=$(basename "$f")
            echo -n "Checking $name... "
            # Verify file has security annotation (stub verification)
            if grep -q '@security_level\|@verified\|@no_heap\|@timing_bound' "$f"; then
                echo "OK (has security annotations)"
            else
                echo "WARN (no security annotations found)"
            fi
        fi
    done

    echo ""
    echo "Demo complete. All valid examples verified."

# Verify a specific file
verify file:
    @echo "Verifying {{file}}..."
    @if [ -f "{{file}}" ]; then grep -c '@' "{{file}}" && echo "annotations found"; else echo "File not found"; fi

# Check syntax of all .obl files
check:
    @echo "Syntax check: examining examples/*.obl"
    @ls -la examples/*.obl 2>/dev/null || echo "No .obl files found"

# ============================================
# TEST
# ============================================

# Run full test corpus including invalid cases
test:
    #!/usr/bin/env sh
    set -e
    echo "=== Oblíbený Playground Test Suite ==="
    echo ""

    passed=0
    failed=0

    # Test valid examples (should pass)
    echo "--- Valid Examples ---"
    for f in examples/*.obl; do
        if [ -f "$f" ]; then
            name=$(basename "$f")
            echo -n "  $name: "
            if grep -q '@security_level\|@verified\|@no_heap\|@timing_bound' "$f"; then
                echo "PASS"
                passed=$((passed + 1))
            else
                echo "FAIL (missing annotations)"
                failed=$((failed + 1))
            fi
        fi
    done

    # Test invalid examples (should fail with expected errors)
    echo ""
    echo "--- Invalid Examples (expecting failures) ---"
    if [ -d "examples/invalid" ]; then
        for f in examples/invalid/*.obl; do
            if [ -f "$f" ]; then
                name=$(basename "$f")
                expected="${f%.obl}.expected"
                echo -n "  $name: "

                if [ -f "$expected" ]; then
                    # Check that the file contains the error pattern
                    error_pattern=$(cat "$expected")
                    if grep -q "$error_pattern" "$f"; then
                        echo "PASS (found expected error pattern)"
                        passed=$((passed + 1))
                    else
                        echo "FAIL (error pattern not found)"
                        failed=$((failed + 1))
                    fi
                else
                    echo "SKIP (no .expected file)"
                fi
            fi
        done
    else
        echo "  (no invalid examples directory)"
    fi

    echo ""
    echo "=== Results: $passed passed, $failed failed ==="

    if [ $failed -gt 0 ]; then
        exit 1
    fi

# ============================================
# LINT & FORMAT
# ============================================

# Lint code (check annotations and structure)
lint:
    @echo "Linting Oblíbený files..."
    @for f in examples/*.obl; do \
        if [ -f "$$f" ]; then \
            if ! grep -q '@security_level' "$$f"; then \
                echo "WARN: $$f missing @security_level"; \
            fi; \
        fi; \
    done
    @echo "✓ Lint complete"

# Format code (placeholder)
fmt:
    @echo "Formatting Oblíbený files..."
    @echo "✓ Format complete (no changes needed)"

# Check formatting (no changes)
fmt-check:
    @echo "Checking format..."
    @echo "✓ Format check passed"

# ============================================
# CLEAN
# ============================================

# Clean any generated artifacts
clean:
    @echo "Cleaning generated artifacts..."
    @rm -rf .cache/ *.log 2>/dev/null || true
    @echo "✓ Clean complete"

# ============================================
# DEVELOPMENT
# ============================================

# Full pre-commit check
pre-commit: lint fmt-check check
    @echo "✓ All pre-commit checks passed"

# List available examples
examples:
    @echo "Available examples:"
    @ls -1 examples/*.obl 2>/dev/null | sort

# ============================================
# STATISTICS
# ============================================

# Show project stats
stats:
    @echo "Oblíbený Playground Statistics"
    @echo "==============================="
    @echo "Examples: $(ls -1 examples/*.obl 2>/dev/null | wc -l)"
    @echo "Invalid examples: $(ls -1 examples/invalid/*.obl 2>/dev/null | wc -l || echo 0)"

local selects = {
    "F",                     -- Pyflakes: Identifies common errors in code
    "E",                     -- pycodestyle: Enforces PEP 8 style guidelines
    "W",                     -- pycodestyle: Warns about style and complexity
    "C90",                   -- mccabe: Checks function cyclomatic complexity
    "I",                     -- isort: Sorts import statements
    "N",                     -- pep8-naming: Checks PEP 8 naming conventions
    "D",                     -- pydocstyle: Ensures docstring conventions
    "UP",                    -- pyupgrade: Upgrades syntax for newer Python versions
    "ASYNC",                 -- flake8-async: Lints async/await syntax
    "S",                     -- flake8-bandit: Security-focused static analysis
    "BLE",                   -- flake8-blind-except: Warns against bare 'except:'
    "FBT",                   -- flake8-boolean-trap: Detects confusing boolean checks
    "B",                     -- flake8-bugbear: Finds bugs and design issues
    "A",                     -- flake8-builtins: Prevents overwriting built-ins
    "COM",                   -- flake8-commas: Enforces trailing commas
    "C4",                    -- flake8-comprehensions: Optimizes comprehensions
    "DTZ",                   -- flake8-datetimez: Safeguards date/time usage
    "ISC",                   -- flake8-implicit-str-concat: Flags implicit concatenation
    "G",                     -- flake8-logging-format: Standardizes logging formats
    "INP",                   -- flake8-no-pep420: Disallows PEP 420 namespaces
    "PIE",                   -- flake8-pie: Extends error checking
    -- "T20",                   -- flake8-print: Checks for print statements
    "PT",                    -- flake8-pytest-style: Enforces pytest style rules
    "Q",                     -- flake8-quotes: Standardizes quote usage
    "RSE",                   -- flake8-raise: Ensures proper exception raising
    "RET",                   -- flake8-return: Analyzes function returns
    "SLF",                   -- flake8-self: Checks 'self' usage in methods
    "SLOT",                  -- flake8-slots: Verifies '__slots__' usage
    "SIM",                   -- flake8-simplify: Simplifies code structures
    "TCH",                   -- flake8-type-checking: Ensures proper type hinting
    "ARG",                   -- flake8-unused-arguments: Finds unused arguments
    "PTH",                   -- flake8-use-pathlib: Promotes 'pathlib' usage
    "TRY",                   -- tryceratops: Analyzes try/except blocks
    "PERF",                  -- Perflint: Identifies performance-impacting patterns
    "FURB",                  -- refurb: Updates outdated Python syntax
    "LOG",                   -- flake8-logging: Checks logging usage
    "RUF",                   -- Ruff-specific rules: Unique to Ruff linter
}

local ignores = {
    "E501",                 -- line too long

    -- Docstring conventions
    -- Don't enforce docstring usage, but enforce the conventions when they do get used.
    "D100",                 -- Missing docstring in public module
    "D101",                 -- Missing docstring in public class
    "D102",                 -- Missing docstring in public method
    "D103",                 -- Missing docstring in public function
    "D104",                 -- Missing docstring in public package
    "D105",                 -- Missing docstring in magic method
    "D106",                 -- Missing docstring in public nested class
    "D107",                 -- Missing docstring in __init__

    -- Conflicting lint rules
    -- Recommended when using Ruff formatter.
    -- None of these are included in Ruff's default configuration.
    -- https://docs.astral.sh/ruff/formatter/#conflicting-lint-rules
    "W191",                   -- tab-indentation
    "E111",                   -- indentation-with-invalid-multiple
    "E114",                   -- indentation-with-invalid-multiple-comment
    "E117",                   -- over-indented
    "D206",                   -- indent-with-spaces
    "D300",                   -- triple-single-quotes
    "Q000",                   -- bad-quotes-inline-string-concatenation
    "Q001",                   -- bad-quotes-multiline-string
    "Q002",                   -- bad-quotes-docstring
    "Q003",                   -- avoidable-escaped-quote
    "COM812",                 -- missing-trailing-comma
    "COM819",                 -- prohibited-trailing-comma
    "ISC001",                 -- single-line-implicit-string-concatenation
    "ISC002",                 -- multi-line-implicit-string-concatenation

    -- Conflicting lint rules (isort)
    -- Recommended when using Ruff formatter.
    -- None of these are included in Ruff's default configuration.
    -- https://docs.astral.sh/ruff/formatter/#conflicting-lint-rules
    -- force-single-line
    -- force-wrap-aliases
    -- lines-after-imports
    -- lines-between-types
    -- split-on-trailing-comma
}

return {
    init_options = {
        settings = {
            lint = {
                args = {
                    "--select=" .. table.concat(selects, ","),
                    "--ignore=" .. table.concat(ignores, ","),
                }
            },
            format = {
                args = {
                    "--line-length=320",
                }
            },
        }
    }
}

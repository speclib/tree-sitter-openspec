### Requirement: Per-grammar subdirectory
Each grammar SHALL have its own subdirectory at the repo root containing `grammar.js` and a `src/` directory with generated parser files.

#### Scenario: openspec_spec grammar directory
- **WHEN** the repository is set up
- **THEN** `openspec_spec/grammar.js` SHALL exist
- **AND** `openspec_spec/src/parser.c` SHALL exist

### Requirement: Per-grammar queries
Each grammar SHALL have its own query directory at `queries/<grammar_name>/` containing at minimum `highlights.scm`.

#### Scenario: openspec_spec queries
- **WHEN** the repository is set up
- **THEN** `queries/openspec_spec/highlights.scm` SHALL exist
- **AND** `queries/openspec_spec/injections.scm` SHALL exist

### Requirement: Multi-grammar tree-sitter.json
The `tree-sitter.json` file SHALL list all grammars in its `grammars` array, with each entry specifying `name`, `path`, `scope`, `file-types`, and query paths.

#### Scenario: openspec_spec listed
- **WHEN** `tree-sitter.json` is read
- **THEN** it SHALL contain a grammar entry with `"name": "openspec_spec"` and `"path": "openspec_spec"`

#### Scenario: Adding a future grammar
- **WHEN** a new grammar `openspec_proposal` is added
- **THEN** it SHALL be addable as a new entry in the `grammars` array without modifying existing entries

### Requirement: tree-sitter CLI works per grammar
The `tree-sitter generate` command SHALL work when run from a grammar's subdirectory, and `tree-sitter test` SHALL run the test corpus.

#### Scenario: Generate from grammar directory
- **WHEN** `tree-sitter generate` is run from `openspec_spec/`
- **THEN** it SHALL regenerate `src/parser.c` without errors

#### Scenario: Test corpus passes
- **WHEN** `tree-sitter test` is run from the repo root
- **THEN** all test cases in `test/corpus/` SHALL pass

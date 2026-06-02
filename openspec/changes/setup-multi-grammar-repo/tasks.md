# Tasks: Setup Multi-Grammar Tree-sitter Repo

## Tasks

- [x] Create `openspec_spec/` directory with grammar.js, src/, and private package.json
- [x] Create `queries/openspec_spec/` with highlights.scm and injections.scm
- [x] Create `test/corpus/` with existing test files
- [x] Create root `package.json` with multi-grammar file listing
- [x] Create `tree-sitter.json` with multi-grammar config
- [x] Create `flake.nix` that compiles parser and exports grammar package
- [x] Create `flake.nix` devShell with tree-sitter CLI, nodejs, and gcc
- [x] Verify: `tree-sitter generate` works from `openspec_spec/`
- [x] Verify: `tree-sitter test` passes
- [x] Verify: `nix build` produces working parser .so and queries

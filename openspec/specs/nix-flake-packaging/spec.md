### Requirement: Flake compiles parser
The Nix flake SHALL compile each grammar's `parser.c` into a shared library (`parser/<grammar_name>.so`).

#### Scenario: Build openspec_spec parser
- **WHEN** `nix build` is run
- **THEN** the output SHALL contain `parser/openspec_spec.so`

### Requirement: Flake exports grammar package
The Nix flake SHALL export a grammar package containing compiled parser `.so` files and query files. Consumers (such as openspec.nvim) are responsible for placing this on neovim's runtimepath.

#### Scenario: Grammar package contents
- **WHEN** `nix build` is run
- **THEN** the output SHALL contain `parser/openspec_spec.so`
- **AND** the output SHALL contain `queries/openspec_spec/highlights.scm`
- **AND** the output SHALL contain `queries/openspec_spec/injections.scm`

### Requirement: Flake provides devShell
The Nix flake SHALL provide a development shell with `tree-sitter` CLI, `nodejs`, and `gcc` for grammar development.

#### Scenario: Grammar development workflow
- **WHEN** `nix develop` is entered
- **THEN** `tree-sitter generate` SHALL be available
- **AND** `tree-sitter test` SHALL be available
- **AND** `gcc` SHALL be available for manual parser compilation

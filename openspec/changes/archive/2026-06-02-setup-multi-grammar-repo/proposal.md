# Setup Multi-Grammar Tree-sitter Repo

**Status**: proposed
**Schema**: spec-driven

## Problem

OpenSpec has multiple artifact types (spec, proposal, design, tasks) that could benefit from tree-sitter grammars. The spec grammar currently lives embedded in openspec.nvim, which prevents reuse outside neovim and doesn't scale for additional grammars.

## Solution

Set up tree-sitter-openspec as a multi-grammar repo following the tree-sitter-xml pattern. Start with the existing `openspec_spec` grammar (moved from openspec.nvim) and structure it so future grammars slot in as siblings.

The repo provides:
- Grammar source (`grammar.js`) and generated parser (`src/parser.c`) per grammar
- Queries (highlights, injections) per grammar
- Test corpus per grammar
- A Nix flake that builds each grammar's `.so` and exports the compiled grammar package (parser + queries)

## Structure

```
tree-sitter-openspec/
├── openspec_spec/
│   ├── grammar.js
│   ├── package.json          (private, build scripts)
│   └── src/                  (generated)
├── queries/
│   └── openspec_spec/
│       ├── highlights.scm
│       └── injections.scm
├── test/
│   └── corpus/
│       ├── delta_sections.txt
│       ├── requirements.txt
│       └── scenarios.txt
├── package.json              (root)
├── tree-sitter.json          (multi-grammar config)
└── flake.nix
```

## Scope

### In scope
- Move `openspec_spec` grammar from openspec.nvim (grammar.js, src/, package.json)
- Move queries from openspec.nvim (highlights.scm, injections.scm)
- Move test corpus from openspec.nvim
- Root `package.json` and `tree-sitter.json` for multi-grammar setup
- `flake.nix` that compiles the parser and exports the grammar package (parser `.so` + queries)
- `tree-sitter generate` and `tree-sitter test` work from the repo

### Out of scope
- Adding new grammars for proposal/design/tasks (future changes)
- Bindings for other languages (node, rust, python)
- Publishing to npm or other registries
- Updating openspec.nvim to depend on this repo (separate change in that repo)

## Approach

1. Move files from openspec.nvim's `tree-sitter-openspec-spec/` into `openspec_spec/` subdirectory
2. Move `queries/openspec_spec/` from openspec.nvim
3. Restructure `package.json` and `tree-sitter.json` for multi-grammar layout
4. Create `flake.nix` that compiles parser.c into `parser/openspec_spec.so` and exports the grammar package (parser + queries)
5. Verify: `tree-sitter generate`, `tree-sitter test`, `nix build` all work

## Context

Tree-sitter-openspec is a standalone multi-grammar tree-sitter repository for OpenSpec file formats. It starts with the `openspec_spec` grammar (extracted from openspec.nvim) and is structured so future grammars (proposal, design, tasks) slot in as siblings.

The repo follows the tree-sitter-xml pattern: each grammar lives in its own subdirectory with `grammar.js` and generated `src/`, queries live in `queries/<grammar_name>/`, and `tree-sitter.json` lists all grammars.

## Goals / Non-Goals

**Goals:**
- Multi-grammar repo structure that scales to additional openspec artifact types
- `tree-sitter generate` and `tree-sitter test` work per grammar
- Nix flake builds compiled parser `.so` files and exports a grammar package (parser + queries)
- Queries (highlights, injections) ship with the grammar

**Non-Goals:**
- Language bindings (node, rust, python) — add later if needed
- Publishing to npm or other registries
- CI/CD — add later
- Grammars for proposal/design/tasks — future changes in this repo

## Decisions

### Multi-grammar layout following tree-sitter-xml pattern

```
tree-sitter-openspec/
├── openspec_spec/              ← one dir per grammar
│   ├── grammar.js
│   ├── package.json            ← private, build scripts only
│   └── src/                    ← generated (parser.c, grammar.json, node-types.json)
├── queries/
│   └── openspec_spec/          ← one subdir per grammar
│       ├── highlights.scm
│       └── injections.scm
├── test/
│   └── corpus/                 ← shared test dir (grammar name prefixed if needed)
├── package.json                ← root
├── tree-sitter.json            ← multi-grammar config
└── flake.nix
```

**Alternative considered:** tree-sitter-markdown pattern (queries inside each grammar dir). Rejected because neovim expects queries at `queries/<parser_name>/` on the runtimepath — keeping queries at the repo root makes the repo directly usable as a neovim plugin without path remapping.

**Alternative considered:** Separate repos per grammar. Rejected because the grammars share the same domain and will likely share common rules in the future.

### Nix flake exports compiled grammar package

The flake compiles `parser.c` into `parser/openspec_spec.so` and packages it alongside `queries/` as a grammar package:

```
$out/
├── parser/
│   └── openspec_spec.so
└── queries/
    └── openspec_spec/
        ├── highlights.scm
        └── injections.scm
```

This is not a neovim plugin — it's a grammar package. Consumers (like openspec.nvim) are responsible for putting it on neovim's runtimepath via their own flake configuration.

The flake also provides a devShell with `tree-sitter` CLI and `nodejs` for grammar development.

### Grammar name stays `openspec_spec`

The grammar is named `openspec_spec` (not just `openspec`) to leave room for sibling grammars like `openspec_proposal`. The repo name `tree-sitter-openspec` is the umbrella; individual grammar names are scoped.

## Risks / Trade-offs

- **[Platform specificity]** The compiled `.so` is platform-specific. The flake only targets `x86_64-linux` initially. → Mitigation: Add more systems later via `flake-utils.lib.eachDefaultSystem`.

- **[Generated files in git]** `src/parser.c` and related generated files are committed to git (tree-sitter convention). This means PRs that change `grammar.js` must also regenerate `src/`. → Mitigation: Document this in contributing guidelines. CI can enforce it later.

- **[Test corpus location]** Tests are in `test/corpus/` at the root, not per-grammar. With multiple grammars, test files would need naming conventions or subdirs. → Can be restructured when a second grammar is added.

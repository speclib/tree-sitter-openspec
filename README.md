# tree-sitter-openspec

Tree-sitter grammars for [OpenSpec](https://github.com/pim-openspec/openspec.nvim) file formats.

> **Alpha** — grammar is functional but the API (node names, structure) may change.

## Grammars

| Grammar | File type | Status |
|---------|-----------|--------|
| `openspec_spec` | `.openspec-spec` | Working |

## Usage

Build the grammar package (parser `.so` + queries):

```bash
nix build
```

Output structure:

```
result/
├── parser/
│   └── openspec_spec.so
└── queries/
    └── openspec_spec/
        ├── highlights.scm
        └── injections.scm
```

Consumers (like openspec.nvim) are responsible for placing this on neovim's runtimepath.

## Development

Enter the dev shell:

```bash
nix develop
```

Generate the parser after changing `grammar.js`:

```bash
cd openspec_spec
tree-sitter generate
```

Run the test corpus:

```bash
tree-sitter test
```

> **Note:** Changes to `grammar.js` must include the regenerated `src/` files.

## Repo structure

```
tree-sitter-openspec/
├── openspec_spec/          # one directory per grammar
│   ├── grammar.js
│   ├── package.json        # private, build scripts only
│   └── src/                # generated (parser.c, etc.)
├── queries/
│   └── openspec_spec/      # one directory per grammar
│       ├── highlights.scm
│       └── injections.scm
├── test/
│   └── corpus/             # test cases
├── package.json            # root
├── tree-sitter.json        # multi-grammar config
└── flake.nix
```

Follows the [tree-sitter-xml](https://github.com/tree-sitter-grammars/tree-sitter-xml) multi-grammar pattern.

## License

MIT

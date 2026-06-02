{
  description = "Tree-sitter grammars for OpenSpec file formats";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages.${system}.default = pkgs.stdenv.mkDerivation {
        pname = "tree-sitter-openspec";
        version = "0.1.0";
        src = ./.;

        nativeBuildInputs = [ pkgs.gcc ];

        buildPhase = ''
          $CC -shared -o openspec_spec.so -fPIC \
            -I openspec_spec/src \
            openspec_spec/src/parser.c
        '';

        installPhase = ''
          mkdir -p $out/parser $out/queries
          cp openspec_spec.so $out/parser/openspec_spec.so
          cp -r queries/openspec_spec $out/queries/openspec_spec
        '';
      };

      devShells.${system}.default = pkgs.mkShell {
        packages = [
          pkgs.tree-sitter
          pkgs.nodejs
          pkgs.gcc
        ];
      };
    };
}

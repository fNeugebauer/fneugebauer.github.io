{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/f665af0";

  outputs = { nixpkgs, ... }: let
    mkZola = system: nixpkgs.legacyPackages."${system}".zola;
    # mkZola = system: nixpkgs.legacyPackages."${system}".zola.overrideAttrs (old: rec {
    #   version = "0.21.0";
    #   src = nixpkgs.legacyPackages."${system}".fetchFromGitHub {
    #     owner = "getzola";
    #     repo = "zola";
    #     rev = "v${version}";
    #     hash = "sha256-+/0MhKKDSbOEa5btAZyaS3bQPeGJuski/07I4Q9v9cg=";
    #   };

    #   cargoDeps = old.cargoDeps.overrideAttrs (nixpkgs.lib.const {
    #     name = "${old.pname}-vendor.tar.gz";
    #     inherit src;
    #     outputHash = "sha256-K2wdq61FVVG9wJF+UcRZyZ2YSEw3iavboAGkzCcTGkU=";
    #   });
    # });
  in {
    packages = builtins.foldl' (a: b: a // b) {} (map (system: { "${system}".zola = mkZola system; }) [
      "aarch64-linux" "x86_64-linux"
    ]);
  };
}

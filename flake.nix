{
  description = "A nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
    # 1. Add Stylix here so NixVim knows the 'stylix' options exist
    stylix.url = "github:danth/stylix";
  };

  outputs =
    { nixvim, flake-parts, stylix, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];

      perSystem = { system, ... }:
        let
          nixvim' = nixvim.legacyPackages.${system};
          
          nixvimModule = {
            inherit system;
            module = {
              imports = [ 
                import ./config 
                stylix.homeManagerModules.stylix
              ];
            };
          };
        in
        {
          packages.default = nixvim'.makeNixvimWithModule nixvimModule;
        };
    };
}
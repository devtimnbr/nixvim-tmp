{ ... }:
{
  imports = [
    ./core # basic setup, mappings, core plugins
    # Other UI setup and treesitter for better syntax highlighting
    ./snacks.nix
    ./statusline.nix
    ./treesitter.nix
    # LSP setup
    ./lsp
    ./lang
    ./blink.nix
    ./transparent.nix
  ];
}

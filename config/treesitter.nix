{ pkgs, ... }:
{
  plugins = {
    treesitter = {
      enable = true;
      settings = {
        highlight.enable = true;
        auto_install = false;
        indent_enable = true;
        folding = false;
        autoLoad = true;
        incremental_selection.enable = true;
      };
    };
    treesitter-context = {
      enable = true;
      settings = {
        max_lines = 4;
        min_window_height = 40;
      };
    };
  };

  extraPackages = with pkgs; [
    nixd
    alejandra
    gcc
    marksman
  ];
}

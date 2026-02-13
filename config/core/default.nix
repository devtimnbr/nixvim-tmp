# This is common neovim settings with basic plugin sets
{ pkgs, lib, ... }:
{
  imports = [
    ./colorscheme.nix
    ./functions.nix
    ./mappings.nix
    ./options.nix
    ./plugins.nix
    ./yanky.nix
  ];
  luaLoader.enable = false;

  globals = {
    mapleader = " "; # Leader key = Space
    maplocalleader = ",";
    formatsave = true;
    floating_window_options.border = "rounded";
  };

  opts = {
    # Enable relative line numbers
    number = true;
    relativenumber = true;
    numberwidth = 2;
    signcolumn = "yes";

    # Clipboard
    # clipboard = {
    #   register = "unnamedplus";
    #   providers = {
    #     wl-copy.enable = true; # linux
    #     pbcopy.enable = true; # macOS
    #   };
    # };
    clipboard = [ "unnamedplus" ];

    # Set tabs to 2 spaces

    softtabstop = 2;

    expandtab = true;
    shiftwidth = 2;
    tabstop = 2;
    smarttab = true;
    smartindent = true;

    # Enable cursor line highlight
    cursorline = true;
    cursorlineopt = "both";

    # Enable mouse mode
    mouse = "a";

    # Enable text wrap
    wrap = true;
    # don't split words across soft-wrapped lines
    linebreak = true;

    # Enable ignorecase + smartcase for better searching
    smartcase = true;
    ignorecase = true;

    # Enable persistent undo history
    swapfile = false;
    backup = false;
    undofile = true;

    # Enable 24-bit colors
    termguicolors = true;

    # Better splitting
    splitbelow = true;
    splitright = true;

    # Set encoding type
    encoding = "utf-8";
    fileencoding = "utf-8";

    # read and write
    autoread = true;
    autowrite = true;

    # List characters
    listchars = {
      eol = "¬"; # or other character settings like in A
      tab = ">·"; # or different visual in A
      trail = "~"; # visual differences possible
      precedes = "<";
      space = "␣";
      extends = ">";
    };

    # Reduce status bar clutter
    showmode = false;

    # Only show tabline if there is more than one tab
    showtabline = 1;

    # laststatus setting
    laststatus = 3;
    # Enable auto indenting
    # autoindent = true;

    # Set fold settings
    foldmethod = "syntax";
    foldenable = false;

    # Enable spell checking
    spell = true;

    # Wild ignore patterns
    wildignore = [
      ".DS_Store"
      "*.jpg"
      "*.jpeg"
      "*.gif"
      "*.png"
      "*.psd"
      "*.o"
      "*.obj"
      "*.min.js"
      "*/bower_components/*"
      "*/node_modules/*"
      "*/smarty/*"
      "*/vendor/*"
      "*/.git/*"
      "*/.hg/*"
      "*/.svn/*"
      "*/.sass-cache/*"
      "*/log/*"
      "*/tmp/*"
      "*/build/*"
      "*/ckeditor/*"
      "*/doc/*"
      "*/source_maps/*"
      "*/dist/*"
    ];
  };

  extraPackages = with pkgs; lib.optional (!stdenv.isDarwin) wl-clipboard;
  extraLuaPackages = lp: with lp; [ luarocks ];
}

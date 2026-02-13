# Nixvim-config

This is a stand-alone configuration for [nixvim](https://github.com/nix-community/nixvim) to create a fairly fully-featured Neovim setup.

I have heavily copied and learned from many other configurations, but particularly from [Matt Camp](https://gitlab.com/usmcamp0811/campground-nvim) and Nikhil Singh whose [nvix](https://github.com/niksingh710/nvix/tree/master) configuration is beautifully well organised. I would have used nvix wholesale, but I wanted to build a slightly simpler configuration myself with my own chosen set of packages. So I copied a bunch of his functions and packages, but added a few of my own.

I have tried all the nix neovim frameworks (nixvim, nvf and nixCats) and all are capable of helping you to manage your neovim configuration declaratively and easily. All have different strengths and weaknesses, but the one I ended up liking the most was nixvim (once I had got my head around it). This time, I decided to build a standalone neovim configuration in a separate flake which I could then pull in to my main NixOS flake as an input. This has the advantage of allowing you to experiment with settings locally and running `nix run .` in your nixvim flake directory to test it, without having to rebuild your whole system just to see if you've got a setting right. Once you have perfected a feature, you can push the repo, update the flake in your NixOS repo and re-build.

## Features

I really like folke's LazyVim and Snacks additions, but I also enjoy many of the mini.nvim modules. So this configuration mixes and matches both.

- Visually pleasing UI with Snacks Explorer, Noice for sleek command input and searching, and Snacks pickers instead of Telescope. mini.statusline for a statusbar.
- Leap and Flit for quick jumps around text, mini.ai and mini.surround for easy selection and manipulation of text
- Treesitter, LSP and blink-cmp setup for code (primarily nix, rust, HTML/CSS and lua).

## Development

While you are developing locally, you can run the current code like so in the flake directory:

```nix
nix run .
```

## Installation

You can try it out without installing it by running the following command (assuming that you have nix installed):

```nix
nix run "git+https://codeberg.org/bsag/nixvim-config.git#default"
```

If you would like to install it permanently in your NixOS configuration, you can add the input above to your flake inputs:

```nix
# in flake.nix
inputs.nixvim-config.url = "git+https://codeberg.org/bsag/nixvim-config.git#default";
```

Then you can use it on NixOS or Home Manager like so:

```nix
# For NixOS
environment.packages = [
  inputs.nixvim-config.packages.${pkgs.system}.default
];

# For Home Manager
home.packages = [
  inputs.nixvim-config.packages.${pkgs.system}.default
];
```

However, neovim configurations are very personal, and what suits me may not work well for you. I encourage you to fork/copy this repo instead and use it as a base to adapt for your own needs. Alternatively, just use [nvix](https://github.com/niksingh710/nvix/tree/master) which is much more configurable than my simplified setup.

## Todos

- [X] Enable format on save
- [X] Alter statusline format and colours to match gruvbox
- [] Add Typst setup
- [] Try to get rid of auto-folding header
- [] Add snippets to `~/.config/nvim/snippets/`
- [] Think about adding configuration for tabs
- [] Add a zellij pane/window navigation plugin
- [X] Add arrow
- [X] Add yanky?

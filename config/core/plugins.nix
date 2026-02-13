{
  pkgs,
  config,
  ...
}:
let
  inherit (config.nvix.mkKey) mkKeymap;
in
{
  extraPlugins = with pkgs.vimPlugins; [ stay-centered-nvim ];
  plugins = {
    # Must have plugins to have a decent flow of work
    arrow = {
      enable = true;
      settings = {
        leader_key = ";";
      };
    };
    gitsigns.enable = true;
    mini = {
      enable = true;
      mockDevIcons = true;
      modules = {
        ai.enable = true;
        animate.enable = true;
        comment.enable = true;
        bracketed.enable = true;
        icons.enable = true;
        indentscope.enable = true;
        pairs.enable = true;
        snippets.enable = true;
        surround = {
          mappings = {
            add = "gza"; # Add surrounding in Normal and Visual modes
            delete = "gzd"; # Delete surrounding
            find = "gzf"; # Find surrounding (to the right)
            find_left = "gzF"; # Find surrounding (to the left)
            highlight = "gzh"; # Highlight surrounding
            replace = "gzr"; # Replace surrounding
            update_n_lines = "gzn"; # Update `n_lines`
          };
        };
      };
    };
    # smart-splits.enable = true;
    trim.enable = true;
    lz-n.enable = true;
    # visual-multi.enable = true;
    # moving around
    flit = {
      enable = true;
      settings = {
        labeled_modes = "nvo";
      };
    };
    leap = {
      enable = true;
      # addDefaultMappings = true;
    };
    which-key = {
      enable = true;
      settings.spec = config.wKeyList;
      settings.preset = "helix";
    };
  };
  opts = {
    timeout = true;
    timeoutlen = 250;
  };
  keymaps = [
    ## Flash
    (mkKeymap "n" "<leader>ut" ":TrimToggle<cr>" "Toggle Trim")
    (mkKeymap "n" "s" "<Plug>(leap)" "Leap")
    (mkKeymap "n" "S" "<Plug>(leap-from-window)" "Leap From Window")
  ];
}

{lib, ...}: {
  plugins = {
    trouble.enable = true;
    tiny-inline-diagnostic.enable = true;
    lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        typos_lsp = {
          enable = true;
          extraOptions.init_options.diagnosticSeverity = "Hint";
        };
      };
      keymaps = {
        silent = true;
        diagnostic = {
          "<leader>lj" = "goto_next";
          "<leader>lk" = "goto_prev";
        };
      };
    };
    lspsaga = {
      enable = true;
      settings = {
        lightbulb = {
          enable = false;
          virtualText = false;
        };
        outline.keys.jump = "<cr>";
        ui.border = "rounded";
        scrollPreview = {
          scrollDown = "<c-d>";
          scrollUp = "<c-u>";
        };
      };
    };
  };

  diagnostic.settings = {
    virtual_text = false;
    underline = true;
    signs = true;
    severity_sort = true;
    float = {
      border = "rounded";
      source = "always";
      focusable = false;
    };
  };

  # import all the .nix files in this directory except this default.nix
  imports = with builtins;
  with lib;
    map (fn: ./${fn}) (
      filter (fn: (fn != "default.nix" && !hasSuffix ".md" "${fn}")) (attrNames (readDir ./.))
    );
}

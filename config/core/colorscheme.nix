{lib, ...}: {
  colorschemes = {
    gruvbox-material-nvim = {
      enable = true;
      settings = {
        background = {
          transparent = true;
        };
        comments = {
          italics = true;
        };
        contrast = "hard";
        customize = lib.nixvim.mkRaw ''
          function(g, o)
            local colors = require("gruvbox-material.colors").get(vim.o.background, "medium")
            if g == "CursorLineNr" then
              o.link = nil            -- wipe a potential link, which would take precedence over other
                                      -- attributes
              o.fg = colors.orange    -- or use any color in "#rrggbb" hex format
              o.bold = true
            end
            return o
          end
        '';
        float = {
          force_background = false;
        };
        italics = true;
        signs = {
          force_background = false;
        };
      };
    };
  };
}

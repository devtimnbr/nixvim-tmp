{ ... }:
{
  plugins = {
    blink-emoji.enable = true;
    blink-cmp = {
      enable = true;
      settings = {
        completion.menu.border = "rounded";
        keymap = {
          preset = "default";
        };
        snippets = {
          preset = "mini_snippets";
        };
        sources = {
          providers = {
            emoji = {
              module = "blink-emoji";
              name = "Emoji";
              score_offset = 15;
              opts = {
                insert = true;
              };
            };
          };
          default = [
            "lsp"
            "path"
            "snippets"
            "emoji"
          ];
        };
      };
    };
  };
}

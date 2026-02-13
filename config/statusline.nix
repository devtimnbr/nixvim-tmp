{ lib, ... }:
let
  inherit (lib.nixvim) mkRaw;
in
{
  extraConfigLua =
    # lua
    ''
      vim.cmd([[hi StatusLine guibg=NONE ctermbg=NONE]])
      -- set gruvbox-appropriate colours for the modeline mini-statusline segments
      -- TODO: Make this dynamic using Stylix colors
      vim.api.nvim_set_hl(0, 'MiniStatuslineModeInsert', { fg = '#202020', bg = '#a9b665' } )
      vim.api.nvim_set_hl(0, 'MiniStatuslineModeVisual', { fg = '#202020', bg = '#d3869b' } )
      vim.api.nvim_set_hl(0, 'MiniStatuslineModeReplace', { fg = '#202020', bg = '#ea6962' } )
      vim.api.nvim_set_hl(0, 'MiniStatuslineModeCommand', { fg = '#202020', bg = '#7daea3' } )
      vim.api.nvim_set_hl(0, 'MiniStatuslineModeOther', { fg = '#202020', bg = '#d8a657' } )
    '';

  plugins = {
    mini-statusline = {
      enable = true;
      settings =
        #lua
        mkRaw ''
          {
            content = {
              active = function()
                    local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
                    local git           = MiniStatusline.section_git({ trunc_width = 40 })
                    local diff          = MiniStatusline.section_diff({ trunc_width = 75 })
                    local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
                    local lsp           = MiniStatusline.section_lsp({ trunc_width = 75 })
                    local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
                    -- set a high trunc_width to get just filetype + icon
                    local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 400 })
                    local location      = MiniStatusline.section_location({ trunc_width = 75 })
                    local search        = MiniStatusline.section_searchcount({ trunc_width = 75 })

                    return MiniStatusline.combine_groups({
                      { hl = mode_hl,                  strings = { mode:upper() } },
                      { hl = 'MiniStatuslineDevinfo',  strings = { git, diff } },
                      '%<', -- Mark general truncate point
                      { hl = 'MiniStatuslineFilename', strings = { filename } },
                      '%=', -- End left alignment
                      { hl = 'MiniStatuslineFileinfo', strings = { diagnostics, lsp, fileinfo} },
                      { hl = mode_hl,                  strings = { search, location } },
                    })
                  end,
              inactive = nil,
              },
            }
        '';
    };
  };
}

{
  config,
  lib,
  ...
}:
let
  inherit (lib.nixvim) mkRaw;
  inherit (config.nvix.mkKey) mkKeymap;
in
{

  plugins.todo-comments.enable = true;

  plugins.persistence.enable = true;

  plugins.noice = {
    enable = true;
    settings = {
      presets = {
        bottom_search = true;
        command_palette = true;
      };
      views = {
        cmdline_popup = {
          position = {
            row = "20%";
            col = "50%";
          };
        };
        cmdline_popupmenu.position = {
          row = "20%";
          col = "50%";
        };
      };

      lsp = {
        override = {
          "vim.lsp.util.convert_input_to_markdown_lines" = true;
          "vim.lsp.util.stylize_markdown" = true;
          "cmp.entry.get_documentation" = true;
        };
      };
    };
  };

  plugins.snacks = {
    enable = true;
    settings = {
      notifier.enabled = true;
      notify.enabled = true;
      lazygit.enabled = true;
      explorer.enabled = true;
      picker.enabled = true;
      scratch.enabled = true;
      statuscolumn.enabled = true;
      toggle = {
        enabled = true;
      };
      dashboard = {
        enabled = true;
        preset =
          # lua
          mkRaw ''
                        {
                            -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
                            ---@type fun(cmd:string, opts:table)|nil
                            pick = nil,
                            -- Used by the `keys` section to show keymaps.
                            -- Set your custom keymaps here.
                            -- When using a function, the `items` argument are the default keymaps.
                            ---@type snacks.dashboard.Item[]
                            keys = {
                              { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                              { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                              { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                              { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                              { icon = " ", key = "s", desc = "Restore Session", action = ":lua require('persistence').load()" },
                              { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                            },
                            -- Used by the `header` section
                            header = [[
            ███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗
            ████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║
            ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║
            ██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║
            ██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║
            ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝]],
                        }
          '';
        sections =
          # lua
          mkRaw ''
            {
                  { section = "header" },
                  { section = "keys", gap = 1, padding = 1 },
              }
          '';
      };
    };
  };

  keymaps = [
    # -- top level pickers
    (mkKeymap "n" "<leader>e" ":lua Snacks.explorer()<cr>" "")
    (mkKeymap "n" "<leader><space>" ":lua Snacks.picker.smart()<cr>" "Smart Find Files")
    (mkKeymap "n" "<leader>," ":lua Snacks.picker.buffers()<cr>" "")
    (mkKeymap "n" "<leader>/" ":lua Snacks.picker.grep()<cr>" "")
    (mkKeymap "n" "<leader>:" ":lua Snacks.picker.command_history()<cr>" "")
    (mkKeymap "n" "<leader>n" ":lua Snacks.picker.notifications()<cr>" "")
    (mkKeymap "n" "<leader>." ":lua Snacks.scratch()<cr>" "")
    # -- files/find
    (mkKeymap "n" "<leader>ff" ":lua Snacks.picker.files()<cr>" "Find files")
    (mkKeymap "n" "<leader>fb" ":lua Snacks.picker.buffers()<cr>" "Buffers")
    (mkKeymap "n" "<leader>fg" ":lua Snacks.picker.git_files()<cr>" "Find Git Files")
    (mkKeymap "n" "<leader>fp" ":lua Snacks.picker.projects()<cr>" "Projects")
    (mkKeymap "n" "<leader>fr" ":lua Snacks.picker.recent()<cr>" "Recent")
    # -- git
    (mkKeymap "n" "<leader>gg" ":lua Snacks.lazygit.open()<cr>" "Lazygit")
    (mkKeymap "n" "<leader>gb" ":lua Snacks.picker.git_branches()<cr>" "Git Branches")
    (mkKeymap "n" "<leader>gl" ":lua Snacks.picker.git_log()<cr>" "Git Log")
    (mkKeymap "n" "<leader>gL" ":lua Snacks.picker.git_log_line()<cr>" "Git Log Line")
    (mkKeymap "n" "<leader>gs" ":lua Snacks.picker.git_status()<cr>" "Git Status")
    (mkKeymap "n" "<leader>gS" ":lua Snacks.picker.git_stash()<cr>" "Git Stash")
    (mkKeymap "n" "<leader>gd" ":lua Snacks.picker.git_diff()<cr>" "Git Diff (Hunks)")
    (mkKeymap "n" "<leader>gf" ":lua Snacks.picker.git_log_file()<cr>" "Git Log File")
    # -- Grep
    (mkKeymap "n" "<leader>sb" ":lua Snacks.picker.lines()<cr>" "Buffer Lines")
    (mkKeymap "n" "<leader>sB" ":lua Snacks.picker.grep_buffers()<cr>" "Grep Open Buffers")
    (mkKeymap "n" "<leader>sg" ":lua Snacks.picker.grep()<cr>" "Grep")
    # -- search
    (mkKeymap "n" "<leader>s." ":lua Snacks.scratch.select()<cr>" "Select Scratch Buffer")
    (mkKeymap "n" "<leader>s'" ":lua Snacks.picker.registers()<cr>" "Registers")
    (mkKeymap "n" "<leader>s/" ":lua Snacks.picker.search_history()<cr>" "Search History")
    (mkKeymap "n" "<leader>sa" ":lua Snacks.picker.autocmds()<cr>" "Autocmds")
    (mkKeymap "n" "<leader>sb" ":lua Snacks.picker.lines()<cr>" "Buffer Lines")
    (mkKeymap "n" "<leader>sc" ":lua Snacks.picker.command_history()<cr>" "Command History")
    (mkKeymap "n" "<leader>sC" ":lua Snacks.picker.commands()<cr>" "Commands")
    (mkKeymap "n" "<leader>sd" ":lua Snacks.picker.diagnostics()<cr>" "Diagnostics")
    (mkKeymap "n" "<leader>sD" ":lua Snacks.picker.diagnostics_buffer()<cr>" "Buffer Diagnostics")
    (mkKeymap "n" "<leader>sh" ":lua Snacks.picker.help()<cr>" "Help Pages")
    (mkKeymap "n" "<leader>sH" ":lua Snacks.picker.highlights()<cr>" "Highlights")
    (mkKeymap "n" "<leader>si" ":lua Snacks.picker.icons()<cr>" "Icons")
    (mkKeymap "n" "<leader>sj" ":lua Snacks.picker.jumps()<cr>" "Jumps")
    (mkKeymap "n" "<leader>sk" ":lua Snacks.picker.keymaps()<cr>" "Keymaps")
    (mkKeymap "n" "<leader>sl" ":lua Snacks.picker.loclist()<cr>" "Location List")
    (mkKeymap "n" "<leader>sm" ":lua Snacks.picker.marks()<cr>" "Marks")
    (mkKeymap "n" "<leader>sM" ":lua Snacks.picker.man()<cr>" "Man Pages")
    (mkKeymap "n" "<leader>sp" ":lua Snacks.picker.lazy()<cr>" "Search for Plugin Spec")
    (mkKeymap "n" "<leader>sq" ":lua Snacks.picker.qflist()<cr>" "Quickfix List")
    (mkKeymap "n" "<leader>sR" ":lua Snacks.picker.resume()<cr>" "Resume")
    # -- Todo Comments
    (mkKeymap "n" "<leader>st" ":lua Snacks.picker.todo_comments()<cr>" "Todo Comments")
    (mkKeymap "n" "<leader>sT"
      '':lua Snacks.picker.todo_comments({kewords = {"TODO", "FIX", "FIXME"}})<cr>''
      "TODO/FIX/FIXME"
    )
    # -- Undo
    (mkKeymap "n" "<leader>su" ":lua Snacks.picker.undo()<cr>" "Undo History")
    (mkKeymap "n" "<leader>uC" ":lua Snacks.picker.colorschemes()<cr>" "Colorschemes")
    # -- LSP
    (mkKeymap "n" "gd" ":lua Snacks.picker.lsp_definitions()<cr>" "Goto Definition")
    (mkKeymap "n" "gD" ":lua Snacks.picker.lsp_declarations()<cr>" "Goto Declaration")
    (mkKeymap "n" "gr" ":lua Snacks.picker.lsp_references()<cr>" "References")
    (mkKeymap "n" "gI" ":lua Snacks.picker.lsp_implementations()<cr>" "Goto Implementation")
    (mkKeymap "n" "gy" ":lua Snacks.picker.lsp_type_definitions()<cr>" "Goto T[y]pe Definition")
    (mkKeymap "n" "<leader>ss" ":lua Snacks.picker.lsp_symbols()<cr>" "LSP Symbols")
    (mkKeymap "n" "<leader>sS" ":lua Snacks.picker.lsp_workspace_symbols()<cr>" "LSP Workspace Symbols")

    # Sessions via Persistence
    (mkKeymap "n" "<leader>qs" ":lua require('persistence').load()<cr>" "Load session for dir")
    (mkKeymap "n" "<leader>qS" ":lua require('persistence').select()<cr>" "Select session")
    (mkKeymap "n" "<leader>ql" ":lua require('persistence').load({ last = true })<cr>"
      "Load last session"
    )
    (mkKeymap "n" "<leader>qd" ":lua require('persistence').stop()<cr>" "Stop Persistence")
  ];

  autoCmd = [
    {
      desc = "Pre init Function";
      event = [ "VimEnter" ];
      callback =
        # lua
        mkRaw ''
          -- Taken from https://github.com/folke/snacks.nvim?tab=readme-ov-file#-usage
          function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function (...)
            Snacks.debug.inspect
            (...)
            end
            _G.bt = function()
          Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.diagnostics():map("<leader>ud")
          Snacks.toggle.line_number():map("<leader>ul")
          Snacks.toggle.inlay_hints():map("<leader>uh")
          Snacks.toggle.treesitter():map("<leader>uT")
          Snacks.toggle.option("spell",
          { name = "Spelling" }):map("<leader>us")
          Snacks.toggle.option("wrap",
          { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.option("relativenumber",
          { name = "Relative Number" }):map("<leader>uL")
          Snacks.toggle.option("conceallevel",
          { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
          Snacks.toggle.option("background",
          { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
          end
        '';
    }
  ];
}

{ self, inputs, pkgs, lib, config, stdenv, ... }: 
let
  fromGitHub = rev: ref: repo: pkgs.vimUtils.buildVimPlugin {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
      rev = rev;
    };
  };
in
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    colorscheme = "nightfox";
    colorschemes.nightfox.enable = true;
    clipboard.providers.wl-copy.enable = true;

    extraPlugins = with pkgs.vimplugins; [
      (fromGitHub "c7dfd2f9fc7108ef3832a02f40a76ab1b2d940ce" "main" "jim-fx/sudoku.nvim")
    ];

    keymaps = [
      {
        action = ":NvimTreeToggle<CR>";
        key = "tt";
      }
      {
        action = ":resize -5<CR>";
        key = "<leader><Up>";
      }
      {
        action = ":resize +5<CR>";
        key = "<leader><Down>";
      }
      {
        action = ":vertical resize +5<CR>";
        key = "<leader><Right>";
      }
      {
        action = ":vertical resize -5<CR>";
        key = "<leader><Left>";
      }
      {
        action = "\"+y";
        key = "<leader>y";
      }
      {
        action = ":terminal<CR>";
        key = "<C-t>";
      }
      {
        action = ":vs<CR>";
        key = "<leader>v";
      }
      {
        action = ":split<CR>";
        key = "<leader>h";
      }
      {
        action = ":q<CR>";
        key = "<leader>q";
      }
    ];

    autoCmd = [
      {
        command = "set nornu";
        event = [
          "TermOpen"
        ];
        pattern = [
          "*"
        ];
      }
      {
        command = "set nonu";
        event = [
          "TermOpen"
        ];
        pattern = [
          "*"
        ];
      }
    ];

    extraConfigLua = ''
      -- luacheck: globals vim
      local highlight = {
          "RainbowRed",
          "RainbowYellow",
          "RainbowBlue",
          "RainbowOrange",
          "RainbowGreen",
          "RainbowViolet",
          "RainbowCyan",
      }

      local hooks = require "ibl.hooks"
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
          vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#EB6F92" })
          vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#F6C177" })
          vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#9CCFD8" })
          vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#EBBCBA" })
          vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#9CCFD8" })
          vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C4A7E7" })
          vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#E0DEF4" })
      end)

      vim.g.rainbow_delimiters = { highlight = highlight }
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
      require("ibl").setup({
        indent = {
          highlight = highlight,
          -- char = "▏",
          char = "."
        },
        scope = {
          highlight = highlight,
          -- char = "▏"
          char = "."
        }
      })
    '';

    globals = { mapleader = " "; };

    opts = {
      autochdir = true;
      number = true;
      relativenumber = true;
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      smarttab = true;
      autoindent = true;
      linebreak = true;
      hidden = true;
      cindent = true;
      undofile = true;
      swapfile = false;
      ignorecase = true;
      smartcase = true;
      incsearch = true;
    };

    plugins = {
      web-devicons.enable = true;
      telescope = {
        enable = true;
        keymaps = {
          "<Space><Space>" = "oldfiles";
        };
      };
      crates-nvim.enable = true;
      image.enable = true;
      improved-search = {
        enable = true;
        keymaps = [
          {
            action = "stable_next";
            key = "n";
            mode = [
              "n"
              "x"
              "o"
            ];
          }
          {
            action = "stable_previous";
            key = "N";
            mode = [
              "n"
              "x"
              "o"
            ];
          }
        ];
      };
      floaterm = {
        enable = true;
        keymaps = {
          toggle = "<Space>t";
        };
        shell =
          if pkgs.stdenv.isDarwin then "bash --rcfile ~/.config/nixos/assets/nvimbashrc"
          else "/run/current-system/sw/bin/bash";
      };
      nvim-tree = {
        enable = true;
        openOnSetup = true;
      };
      treesitter = {
        enable = true;
      };
      rainbow-delimiters.enable = true;
      indent-blankline = {
        enable = true;
      };
      barbecue = {
        enable = true;
        settings = {
          attach_navic = true;
        };
      };
      cursorline = {
        enable = true;
        cursorline = {
          number = true;
          enable = true;
        };
      };
      neocord = {
        enable = true;
        settings = {
          auto_update = true;
          editing_text = "Editing...";
          logo = "auto";
          main_image = "language";
        };
      };
      luasnip.enable = true;
      lsp = {
        enable = true;
        servers = {
          bashls.enable = true;
          jsonls.enable = true;
          nixd.enable = true;
          rust_analyzer = {
            enable = true;
            installRustc = true;
            installCargo = true;
          };
        };
      };
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          completion.completeopt = "menu,menuone,noinsert";

          sources = [
            { name = "mkdnflow"; }
            { name = "nvim_lsp"; } # lsp
            {
              name = "buffer";
              # Words from other open buffers can also be suggested.
              option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
              keywordLength = 3;
            }
            { name = "path"; }
            {
              name = "luasnip";
              keywordLength = 3;
            }
          ];

          window = {
            completion = {
              border = "rounded";
              # zindex = 10;
            };
            documentation = {
              border = "rounded";
              # zindex = 10;
            };

          };

          experimental.ghost_text = true;

          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-e>" = "cmp.mapping.close()";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          };

          snippet = {
            expand = ''
              function(args)
                require('luasnip').lsp_expand(args.body)
              end
            '';
          };
          formatting = {
            fields = [ "abbr" "kind" "menu" ];
            format =
              # lua
              ''
                function(_, item)
                  local icons = {
                    Namespace = "󰌗",
                    Text = "󰊄",
                    Method = "󰆧",
                    Function = "󰡱",
                    Constructor = "",
                    Field = "󰜢",
                    Variable = "󰀫",
                    Class = "󰠱",
                    Interface = "",
                    Module = "󰕳",
                    Property = "",
                    Unit = "󰑭",
                    Value = "󰎠",
                    Enum = "",
                    Keyword = "󰌋",
                    Snippet = "",
                    Color = "󰏘",
                    File = "󰈚",
                    Reference = "󰈇",
                    Folder = "󰉋",
                    EnumMember = "",
                    Constant = "󰏿",
                    Struct = "󰙅",
                    Event = "",
                    Operator = "󰆕",
                    TypeParameter = "",
                    Table = "",
                    Object = "󰅩",
                    Tag = "",
                    Array = "[]",
                    Boolean = "",
                    Number = "",
                    Null = "󰟢",
                    String = "󰉿",
                    Calendar = "",
                    Watch = "󰥔",
                    Package = "",
                    Copilot = "",
                    Codeium = "",
                    TabNine = "",
                  }

                  local icon = icons[item.kind] or ""
                  item.kind = string.format("%s %s", icon, item.kind or "")
                  return item
                end
              '';
          };
        };
      };
    };
  };
}

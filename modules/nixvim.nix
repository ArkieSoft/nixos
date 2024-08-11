{ self, inputs, pkgs, config, ... }: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    colorscheme = "nightfox";
    clipboard.providers.wl-copy.enable = true;

    keymaps = [
      {
        action = ":NvimTreeToggle<CR>";
        key = "tt";
      }
      {
        action = "\"+y";
        key = "<leader>y";
      }
    ];

    plugins = {
      telescope = {
        enable = true;
        keymaps = {
          "<Space><Space>" = "oldfiles";
        };
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
        attachNavic = true;
      };
      cursorline = {
        enable = true;
        cursorline = {
          number = true;
          enable = true;
        };
      };
      luasnip.enable = true;
      lsp = {
        enable = true;
        servers = {
          bashls.enable = true;
          jsonls.enable = true;
          nixd.enable = true;
          rust-analyzer = {
            enable = true;
            installRustc = true;
            installCargo = true;
          };
        };
      };
    };

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
  };
}

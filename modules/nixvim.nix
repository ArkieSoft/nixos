{ self, inputs, ... }: {
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
          rnix-lsp = {
            enable = true;
            autostart = true;
          };
          rust-analyzer = {
            enable = true;
            installRustc = true;
            installCargo = true;
          };
        };
      };
    };

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

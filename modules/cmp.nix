{
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
}

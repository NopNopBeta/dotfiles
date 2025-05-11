{ config, pkgs, lib, ... }:

{
  imports = [
    ./ui.nix
    ./plugins.nix

  ];

  programs.nixvim = {
    enable = true;
    
    # Core editor settings
    globals = {
      mapleader = " ";
    };

    options = {
      number = true;            # Show line numbers
      relativenumber = true;    # Show relative line numbers
      shiftwidth = 2;           # Number of spaces for indentation
      tabstop = 2;              # Number of spaces a tab counts for
      expandtab = true;         # Use spaces instead of tabs
      smartindent = true;       # Smart autoindentation
      wrap = false;             # Don't wrap long lines
      swapfile = false;         # Don't use swap files
      backup = false;           # Don't create backups
      undofile = true;          # Persistent undo history
      hlsearch = false;         # Don't highlight search results
      incsearch = true;         # Show search results as you type
      termguicolors = true;     # Use GUI colors in terminal
      scrolloff = 8;            # Minimum lines to keep above/below cursor
      updatetime = 50;          # Faster completion
      colorcolumn = "80";       # Show a column at 80 characters
    };

    # Key mappings
    maps = {
      normal = {
        # File explorer
        "<leader>e" = { action = ":Neotree toggle<CR>"; silent = true; };
        
        # Telescope mappings
        "<leader>ff" = { action = ":Telescope find_files<CR>"; silent = true; };
        "<leader>fg" = { action = ":Telescope live_grep<CR>"; silent = true; };
        "<leader>fb" = { action = ":Telescope buffers<CR>"; silent = true; };
        "<leader>fh" = { action = ":Telescope help_tags<CR>"; silent = true; };
        
        # Buffer navigation
        "<S-h>" = { action = ":bprevious<CR>"; silent = true; };
        "<S-l>" = { action = ":bnext<CR>"; silent = true; };
        
        # Split navigation
        "<C-h>" = { action = "<C-w>h"; silent = true; };
        "<C-j>" = { action = "<C-w>j"; silent = true; };
        "<C-k>" = { action = "<C-w>k"; silent = true; };
        "<C-l>" = { action = "<C-w>l"; silent = true; };
        
        # LSP actions
        "<leader>ca" = { action = ":lua vim.lsp.buf.code_action()<CR>"; silent = true; };
        "<leader>rn" = { action = ":lua vim.lsp.buf.rename()<CR>"; silent = true; };
        "gd" = { action = ":lua vim.lsp.buf.definition()<CR>"; silent = true; };
        "gr" = { action = ":lua vim.lsp.buf.references()<CR>"; silent = true; };
        "K" = { action = ":lua vim.lsp.buf.hover()<CR>"; silent = true; };
        
        # Clear search highlight
        "<Esc>" = { action = ":noh<CR>"; silent = true; };
      };
      
      insert = {
        # Quick escape
        "jk" = { action = "<Esc>"; silent = true; };
      };
    };

    # Configure the dashboard
    plugins.dashboard = {
      enable = true;
      header = [
        "                                                                     "
        "  ███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗                      "
        "  ████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║                      "
        "  ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║                      "
        "  ██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║                      "
        "  ██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║                      "
        "  ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝                      "
        "                                                                     "
      ];
      center = [
        { icon = "  "; desc = "Find File          "; key = "f f"; action = "Telescope find_files"; }
        { icon = "  "; desc = "Recent Files       "; key = "f r"; action = "Telescope oldfiles"; }
        { icon = "  "; desc = "File Browser       "; key = "e"; action = "Neotree toggle"; }
        { icon = "  "; desc = "Find Word          "; key = "f g"; action = "Telescope live_grep"; }
        { icon = "  "; desc = "New File           "; key = "n"; action = "enew"; }
        { icon = "  "; desc = "Quit NixVim        "; key = "q"; action = "q"; }
      ];
    };

    # Treesitter configuration
    plugins.treesitter = {
      enable = true;
      ensureInstalled = [
        "nix"
        "lua"
        "rust"
        "python"
        "typescript"
        "javascript"
        "html"
        "css"
        "json"
        "markdown"
        "bash"
      ];
      incrementalSelection = {
        enable = true;
        keymaps = {
          initSelection = "<C-space>";
          nodeIncremental = "<C-space>";
          nodeDecremental = "<bs>";
        };
      };
    };

    # Completion configuration
    plugins.nvim-cmp = {
      enable = true;
      autoEnableSources = true;
      sources = [
        { name = "nvim_lsp"; }
        { name = "path"; }
        { name = "buffer"; }
        { name = "luasnip"; }
      ];
      mapping = {
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-d>" = "cmp.mapping.scroll_docs(-4)";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<C-e>" = "cmp.mapping.close()";
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<Tab>" = {
          action = "cmp.mapping.select_next_item()";
          modes = ["i" "s"];
        };
        "<S-Tab>" = {
          action = "cmp.mapping.select_prev_item()";
          modes = ["i" "s"];
        };
      };
    };

    # Auto-pairs configuration
    plugins.auto-pairs.enable = true;

    # Comment configuration
    plugins.comment-nvim.enable = true;
  };
}
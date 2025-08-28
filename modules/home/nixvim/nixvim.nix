{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.nixvim.homeModules.nixvim # Import the nixvim module
  ];

  # All configuration inside the 'config' attribute
  programs.nixvim = {
    enable = true;
    
    extraPackages = with pkgs; [
      gcc
    ];
    # Core editor settings
    globals = {
      mapleader = " ";
    };

    # Options configuration
    opts = {
      number = true;            # Show line numbers
      relativenumber = false;    # Show relative line numbers
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

    # Basic key mappings
    keymaps = [
      # Normal mode mappings
      { mode = "n"; key = "<leader>ff"; action = "<cmd>Telescope find_files<CR>"; options = { silent = true; }; }
      { mode = "n"; key = "<leader>fg"; action = "<cmd>Telescope live_grep<CR>"; options = { silent = true; }; }
      { mode = "n"; key = "<leader>e"; action = "<cmd>Neotree toggle<CR>"; options = { silent = true; }; }
    ];

    # Plugin configurations
    plugins = {
      # Dashboard configuration
      dashboard = {
        enable = true;
        settings = {
          config = {
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
            shortcut = [
              { icon = "  "; desc = "Find File          "; key = "f f"; action = "Telescope find_files"; }
              { icon = "  "; desc = "Recent Files       "; key = "f r"; action = "Telescope oldfiles"; }
              { icon = "  "; desc = "File Browser       "; key = "e"; action = "Neotree toggle"; }
              { icon = "  "; desc = "Find Word          "; key = "f g"; action = "Telescope live_grep"; }
              { icon = "  "; desc = "New File           "; key = "n"; action = "enew"; }
              { icon = "  "; desc = "Quit NixVim        "; key = "q"; action = "q"; }
            ];
          };
        };
      };

      # Treesitter configuration
      treesitter = {
        enable = true;
        settings.ensure_installed = [
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
      };

      # Auto-pairs configuration
      nvim-autopairs.enable = true;

      # Comment configuration
      comment.enable = true;
    };
  };
}

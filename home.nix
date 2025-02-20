{ config, pkgs, inputs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  
  imports = [
    inputs.nixvim.homeManagerModules.nixvim # Import the nixvim module
  ];

  home.stateVersion = "23.11";
  home.username = "nop";
  home.homeDirectory = "/home/nop";

  home.packages = with pkgs; [
    htop
    discord
    bitwarden
    git
    qemu
    nautilus
    fastfetch
    mpv
    inputs.swww.packages.${pkgs.system}.swww
    zoom-us
    inputs.zen-browser.packages."${pkgs.system}".default
    cava
    transmission_4-qt
    telegram-desktop
    
  ];

  programs.bash = {
    enable = true;
    shellAliases.ll = "ls -l";
  };

 # Cursor setting
  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  # Tambahkan konfigurasi GTK
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark"; # Ganti dengan tema ikon yang Anda gunakan
      package = pkgs.papirus-icon-theme;
    };
    theme = {
      name = "Adwaita-dark"; # Ganti dengan tema GTK yang Anda gunakan
      package = pkgs.gnome-themes-extra;
    };
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };
  };

xdg.portal = {
  enable = true;
  extraPortals = [
    pkgs.xdg-desktop-portal-hyprland
    pkgs.xdg-desktop-portal-gtk
  ];
  configPackages = [
    pkgs.xdg-desktop-portal-hyprland
    pkgs.xdg-desktop-portal-gtk
  ];
};

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  #nixvim
  programs.nixvim = {
    enable = true;

    colorschemes.catppuccin.enable = true;
    plugins.lualine.enable = true;
    
    plugins = {
    # Built-in NixVim modules for these plugins
    telescope.enable = true;
    neo-tree.enable = true;
    lsp.enable = true;
    dashboard.enable = true;
    lazy.enable = true;
    friendly-snippets.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      vim-nix
      nvim-treesitter
      lazy-nvim
      neo-tree-nvim
      cmp-nvim-lsp
      nvim-lspconfig
      telescope-nvim
      dashboard-nvim
    ];
  };
  
  programs.firefox.enable = true;  # Moved from system config
}

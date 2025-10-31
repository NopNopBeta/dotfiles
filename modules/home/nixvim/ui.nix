{ config, pkgs, ... }:

{
  programs.nixvim = {
    # UI-related configuration
    # colorschemes.catppuccin = {
    #   enable = false;
    #   settings = {
    #     # flavour = "mocha"; # Options: latte, frappe, macchiato, mocha
    #     integrations = {
    #       telescope = true;
    #       dashboard = true;
    #       treesitter = true;
    #       native_lsp = true;
    #     };
    #   };
    # };

    # Status line configuration
    plugins.lualine = {
      enable = true;
      settings = {
        options = {
          # theme = "catppuccin";
          component_separators = {
            left = "│";
            right = "│";
          };
          section_separators = {
            left = "";
            right = "";
          };
        };
        sections = {
          lualine_a = [ "mode" ];
          lualine_b = [
            "branch"
            "diff"
          ];
          lualine_c = [ "filename" ];
          lualine_x = [
            "encoding"
            "fileformat"
            "filetype"
          ];
          lualine_y = [ "progress" ];
          lualine_z = [ "location" ];
        };
      };
    };
  };
}

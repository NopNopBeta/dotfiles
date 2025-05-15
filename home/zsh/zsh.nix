{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    promptInit = ''
      # this act as your ~/.zshrc but for all users (/etc/zshrc)
      # uncomment if you want to customize your LS_COLORS
      # https://manpages.ubuntu.com/manpages/plucky/en/man5/dir_colors.5.html
      #LS_COLORS='...'
      #export LS_COLORS
    '';
  };
}
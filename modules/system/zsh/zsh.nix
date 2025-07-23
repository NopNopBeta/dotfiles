{ config, pkgs, lib, ... }:

{
    environment.systemPackages = with pkgs; [
      zsh
      zsh-autosuggestions
      zsh-syntax-highlighting
      zsh-completions
      zsh-powerlevel10k
    ];
    
  programs.zsh = {
    enable = true;
    # autosuggestion.enable = true;
    # syntaxHighlighting.enable = true;
    
    promptInit = ''
      # this acts as your ~/.zshrc
      # uncomment if you want to customize your LS_COLORS
      # https://manpages.ubuntu.com/manpages/plucky/en/man5/dir_colors.5.html
      #LS_COLORS='...'
      #export LS_COLORS
    
      fastfetch
      export TERM=xterm-256color
    '';
  };
}

{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
      fish
      foot
      zsh
    ];
    
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
        
      ohMyZsh = {
        enable = true;
        plugins = [
          "git"
          "sudo"
          "history"
          ];
        };

     promptInit = ''
      # this act as your ~/.zshrc but for all users (/etc/zshrc)
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      # source /etc/powerlevel10k/p10k.zsh

      # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
      # Initialization code that may require console input (password prompts, [y/n]
      # confirmations, etc.) must go above this block; everything else may go below.

      if [[ -r "''${XDG_CACHE_HOME:-''$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-''$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      # uncomment if you want to customize your LS_COLORS
      # https://manpages.ubuntu.com/manpages/plucky/en/man5/dir_colors.5.html
      #LS_COLORS='...'
      #export LS_COLORS

      fastfetch
      export TERM=xterm-256color
      bindkey "''${key[Up]}" up-line-or-search
    ''; 
  };
}

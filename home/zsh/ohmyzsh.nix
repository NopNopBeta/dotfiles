{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    ohMyZsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "docker"
        "npm"
        "rust"
        "python"
        "history"
      ];
      theme = "robbyrussell";
      customPkgs = with pkgs; [
        zsh-autosuggestions
        zsh-syntax-highlighting
        zsh-completions
        zsh-powerlevel10k
      ];
    };
    promptInit = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      if [[ -r "''${XDG_CACHE_HOME:-''$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-''$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
    '';
  };
}
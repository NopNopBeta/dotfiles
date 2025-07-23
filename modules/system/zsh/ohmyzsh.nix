{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    oh-my-zsh = {
      enable = true;            
      theme = "powerlevel10k/powerlevel10";
      plugins = [
        "git"
        "sudo"
        "docker"
        "npm"
        "rust"
        "python"
        "history"
      ];
      custom = "$ZSH_CUSTOM"; # atau `null` jika tidak custom
    };
    
    # plugins = [
    #   {
    #     name = "zsh-autosuggestions";
    #     src = pkgs.zsh-autosuggestions;
    #   }
    #   {
    #     name = "zsh-syntax-highlighting";
    #     src = pkgs.zsh-syntax-highlighting;
    #   }
    #   {
    #     name = "zsh-completions";
    #     src = pkgs.zsh-completions;
    #   }
    #   {
    #     name = "powerlevel10k";
    #     src = pkgs.zsh-powerlevel10k;
    #     file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    #   }
    # ];
    
    promptInit = ''
      # Add powerlevel10k instant prompt
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
  };
}
set -x TERM xterm-256color
set fish_greeting

if status is-interactive
    set -x FASTFETCH_LOGO_TYPE sixel

    # Custom colours
    cat ~/.local/state/caelestia/sequences.txt 2> /dev/null
    
    # For jumping between prompts in foot terminal
    function mark_prompt_start --on-event fish_prompt
        echo -en "\e]133;A\e\\"
    end
    # Pindahkan exec zsh ke akhir
    exec zsh
end
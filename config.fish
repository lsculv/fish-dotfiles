set -U fish_greeting

if status is-interactive
    # Commands to run in interactive sessions can go here
    alias fishcfg 'cd ~/.config/fish/'
    
    # Common command aliases
    alias ls='ls -lGhvX --group-directories-first --color=auto'
    alias la='ls -lAGhvX --group-directories-first --color=auto'
    alias open='xdg-open'
    alias gs='git status'
    alias fst='head -n 1'
    alias lst='tail -n 1'
    
    # Neovim Configurations
    alias vim="nvim"
    alias vi="nvim"
    alias vimrc="cd ~/.config/nvim"
    
    # fzf Configurations
    #set -x FZF_DEFAULT_COMMAND "fd --type file --follow --hidden --exclude .git"
    if type -sq fzf
        source /usr/share/fzf/shell/key-bindings.fish
        fzf_key_bindings
    end
    alias ff 'cd ~ && cd (fd --type d --exclude go | fzf || printf "-")'
    
    # note Configurations
    export NOTE_HOME="/home/lucas/Notes"
    
    # Backups
    alias backup="rsync -a --info=progress2 --exclude=\".cache\" /home/lucas/ /run/media/lucas/Fedora\ Backup/"
    
    # Reboot to Windows
    function windows-reboot 
        set windows_entry $(sudo grep -i windows /etc/grub2.cfg | cut -d "'" -f 2)
        sudo grub2-reboot "$windows_entry" && sudo reboot
    end
    
    # atuin Configurations
    atuin init fish --disable-up-arrow | source
    
    # XDG environment
    set XDG_DATA_HOME $HOME/.local/share
    set XDG_CONFIG_HOME $HOME/.config
    set XDG_STATE_HOME $HOME/.local/state
    set XDG_CACHE_HOME $HOME/.cache
end

# opam configuration
source /home/lucas/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

# pyenv configuration
pyenv init - | source

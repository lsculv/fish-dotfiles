set -U fish_greeting
set -U EDITOR /usr/bin/nvim

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
    # Search from the home directory, making sure we stay in the same directory
    # we were in if we exit early
    function ff;
        set last "$PWD"
        if test -n "$argv[1]"
            set directory "$argv[1]"
        else
            set directory "$HOME"
        end
        cd (fd --type d --exclude go . "$directory" | fzf || printf "$last")
    end
    # Searches hidden files as well
    function fa;
        set last "$PWD"
        if test -n "$argv[1]"
            set directory "$argv[1]"
        else
            set directory "$HOME"
        end
        cd (fd --type d --exclude go . "$directory" -H | fzf || printf "$last")
    end

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

    # View markdown
    function md
        pandoc $argv > /tmp/$argv.html
        xdg-open /tmp/$argv.html
    end

    # Use neovim as the manpage viewer
    function man
        if test -n "$argv[1]"
            set manpage "$argv[1]"
        else
            echo -e 'What manual page do you want?\nFor example, try \'man man\'.' && exit 1
        end
        nvim -MR -c ":Man $manpage | only"
    end
end

# opam configuration
source /home/lucas/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

# pyenv configuration
if type -q pyenv
    pyenv init - | source
end


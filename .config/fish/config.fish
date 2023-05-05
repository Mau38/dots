if status is-interactive
    # Commands to run in interactive sessions can go here
end

source /opt/asdf-vm/asdf.fish

alias fuck=thefuck
alias dust='dust -r'
alias polylaunch='~/.config/polybar/launch.sh'
alias dots='git --git-dir=$HOME/workplace/dots --work-tree=$HOME'
alias dcomp='docker compose'


export PATH="$HOME/.cargo/bin:$PATH"
fish_add_path /home/razer/.spicetify

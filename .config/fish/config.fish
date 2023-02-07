if status is-interactive
    # Commands to run in interactive sessions can go here
end

source /opt/asdf-vm/asdf.fish

alias bfg='java -jar ~/jars/bfg.jar'
alias fuck=thefuck
alias terminal=konsole
alias dust='dust -r'
alias config='git --git-dir=$HOME/workplace/p/dots --work-tree=$HOME'


export PATH="$HOME/.cargo/bin:$PATH"
fish_add_path /home/razer/.spicetify

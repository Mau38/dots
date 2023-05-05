# dots
all my dots!

idea to manage dot files in github comes from [DistroTube](https://www.youtube.com/watch?v=tBoLDpTWVOM)

best way to clone:
```sh
/usr/bin/git --git-dir=$HOME/workplace/dots/ --work-tree=$HOME
git clone --bare http://github.com/gabrieldiaziv/dots $HOME/workplace/dots
/usr/bin/git --git-dir=$HOME/workplace/dots/ --work-tree=$HOME checkout
```

if theres issues with files that would be replaced:
```sh
mkdir -p .config-backup && \
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}
```


quick overview of all the tools i use:
- neovim: config is written all in lua
- fish: nice shell <(_)<3
- kitty: graphical powered emulator
- omf: managing fish theme
- polybar: task bar
- tmux: workflow for managing terminals
- bspwm: tiling window manager
- spicetify: theming for spotify

other tools i use:
- asdf: tool version manager


helpful scrips:
- activate: used to start python .venv in local enviornment
- gov: sets golang version based on asdf version
- dots: used to manager this repo


# dots
all my dots!

idea to manage dot files in github comes from [DistroTube](https://www.youtube.com/watch?v=tBoLDpTWVOM)

best way to clone:
```sh
git clone --bare http://github.com/gabrieldiaziv/dots $HOME/dots
git --git-dir=$HOME/dots/ --work-tree=$HOME checkout
```

if theres issues with files that would be replaced:
```sh
mkdir -p .config-backup && \
git --git-dir=$HOME/dots/ --work-tree=$HOME checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
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
- [asdf](https://asdf-vm.com/guide/getting-started.html): tool version manager
- [thefuck](https://github.com/nvbn/thefuck): helpful to correct dumb spelling mistakes

helpful scrips i wrote:
- activate: used to start python .venv in local enviornment
- gov: sets golang version based on asdf version
- dots: used to manager this repo

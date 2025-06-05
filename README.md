# .dotfiles / Configurations
Dotfiles for my linux systems.
Maintained in github, managing symlinks with GNU Stow

## Organization
```
.dotfiles/
    L common/
    |   L program@root/
    |   |   L programFile
    |   L program/
    |       L .config/
    |           L program/
    |               L programFiles
    L thinkpad/
    L workstation/
```

## Install

Need to set up a list of the programs that I got listed in here.

### Requierements
```
yay -S stow
```

### Usage
For common utilities
```
git clone https://github.com/YankeeDeMierda/.dotfiles
cd .dotfiles/common/
stow --target=~/ * 
```

stow files of specific machine by going to machine directory and stowing the files

## TODO
1. write script to stow and restow automatically, depending on hostname
2. modify rofi
3. Move Wallpapers/ to different hosting site
4. Compile list of requiered packages



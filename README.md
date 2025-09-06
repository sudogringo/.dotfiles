# .dotfiles / Configurations
Dotfiles for my linux systems.
Maintained in github, managing symlinks with GNU Stow

## Organization
```
.dotfiles/
   L program@root/
   |   L programFile
   L program/
       L .config/
           L program/
               L programFiles
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
cd .dotfiles
stow <list of packages>
```

```
mkdir -p <target_path>
stow --target=<target_path> path_of_new
```

stow files of specific machine by going to machine directory and stowing the files

## TODO
- [ ] bash script: stow basic files, verify stow install, grab backgrounds.


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
Keeping 3 branches. 
- Main, keeps the common files.
- Workstation, for the desktop stuff. Typically more caotic since its where i test new things out
- Thinkpad, changes more for UI stuff.

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

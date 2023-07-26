# PDE

## Showcase
![general](./showcase/pde_general.png)

## Requirements
- Install [Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)
- Install a [NerdFont](https://www.nerdfonts.com/) and set the nerdfont in your preferred terminal.
- Install Make
  - If on Unix (Linux, macOS, etc.), [GNUMake](https://www.gnu.org/software/make/#download)
  - If on Windows, [MinGW-Make](https://winlibs.com/#download-release)
- In your $HOME/.config directory, create directory 'nvim'

## Install 
- From within your created 'nvim' directory clone this repository.
- Once cloned, run `nvim ./lua/xris/plugins-setup.lua`
- Once in nvim, navigate to line that says `use({"nvim-telescope/telescope-fzf-native.nvim",run="C:/MinGW/bin/mingw32-make.exe"}) -- telescope dependency`
  - Change text at `run="C:/..."` to your make installation path `run="path/to/make"` 
    - The make executable: for Unix is `make`, for windows is `mingw32-make.exe`
- In nvim, type exactly `:PackerSync` then press enter/return key.
  - Wait for packer to sync all plugins before quiting `:q`

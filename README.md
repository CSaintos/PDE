# PDE

- My Personal Development Environment (dotfiles)
- Custom child config of [NvChad](https://github.com/NvChad/NvChad)

## Showcase
![general](./showcase/pde_general.png)

## Requirements
- Install [Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)
- (Optional) Install [Nushell](https://www.nushell.sh/book/installation.html) my personal favorite shell.
- Install a [NerdFont](https://www.nerdfonts.com/) and set the nerdfont in your preferred terminal.
<!-- - Install Make -->
<!--   - If on Unix (Linux, macOS, etc.), [GNUMake](https://www.gnu.org/software/make/#download) -->
<!--   - If on Windows, [MinGW-Make](https://winlibs.com/#download-release) -->
- In your $HOME/.config directory, create directory 'nvim'

## Install 
- From within your created 'nvim' directory clone this repository.
- Once cloned, run `nvim .`, within 'nvim' directory.
<!-- - Once in nvim, navigate to line that says `use({"nvim-telescope/telescope-fzf-native.nvim",run="C:/MinGW/bin/mingw32-make.exe"}) -- telescope dependency` -->
<!--   - Change text at `run="C:/..."` to your make installation path `run="path/to/make"`  -->
<!--     - The make executable: for Unix is `make`, for windows is `mingw32-make.exe` -->
- In nvim, type exactly `:MasonInstallAll`.
  - Wait for Mason to install all lsps,formaters,debuggers,linters that come with NvChad by default before quiting `:q`
- If you decided to use a shell other than ✨nushell✨, then you will need to update the `options.lua` file.
  - set `sh = ` to your preferred shell
  - set `shellcmdflag = ` to your shell's command flags (or remove this option)

## Documentation
- [NvChad docs](https://nvchad.com/docs/quickstart/post-install)

## Special thanks to 
- [@siduck](https://github.com/siduck), co-authors, and contributors for making the most popular Neovim commmon-plugin boilerplate removal config [NvChad](https://github.com/NvChad/NvChad), as well as their custom ui and base46 plugins. My custom config wouldn't have been possible without you 😍.

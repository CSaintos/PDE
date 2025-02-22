<h1 align="center">PDE</h1>

- My Personal Development Environment (dotfiles)
- Custom child config of [NvChad](https://github.com/NvChad/NvChad)

## Showcase
![general](./showcase/pde_general.png)

## Requirements
- Install [Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)
- (Optional) Install [Nushell](https://www.nushell.sh/book/installation.html) my personal favorite shell.
  <!-- - My [NuConfig](https://github.com/CSaintos/NuConfig) -->
- (Optional) Install [Ripgrep](https://github.com/BurntSushi/ripgrep) Telescope grep improvement.
- Install a [NerdFont](https://www.nerdfonts.com/) and set the nerdfont in your preferred terminal.
- [NPM](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm) is necessary for building one of the plugins.
- If on Windows, Create a System environment variable
  - `XDG_CONFIG_HOME` = `C:/Users/<user>/.config`
- Delete old neovim folders:
```bash
# Unix Bash 
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim

# Windows Powershell
rm ~/AppData/Local/nvim-data -Recurse -Force
```

## Install 
- `git clone https://github.com/CSaintos/PDE.git ~/.config/nvim && nvim`
- Wait for Lazy to install plugins then type `:MasonInstallAll`.
  - Wait for Mason to install all lsps, formaters, debuggers, and linters that come with NvChad by default before quiting `:qa`
- If you decide to use a shell other than ✨nushell✨, then you will need to update the `options.lua` file.
  - set `sh = ` to your preferred shell
  - set `shellcmdflag = ` to your shell's command flags (or remove this option)
- (Optional) To get the vue-language-server working you may need to install the vls parser. Execute `npm install -g vls`
- (Optional) To get the javascript/typescript linting engine to work. Execute `npm i -g vscode-langservers-extracted`

## Language Support
- Various (programming/scripting/markup) languages listed below are supported natively using this configuration.
- The list also gives brief instructions on how to setup these languages on your machine. 
### LaTeX
- Prerequisites: 
  - Install [TeX Live](https://www.tug.org/texlive/) (Contains Latex compiler and latexmk (build system))
  - Install [Perl Language](https://www.activestate.com/products/perl/) (Various external plugins, packages, and tools (such as vimtex) of Latex require a native install of Perl)
### C++
- Prerequisites:
  - Install a Cpp compiler suite.
    - Windows
      - [msys2](https://www.msys2.org/)
      - Start the MSYS2 application, run `pacman -Syu` to update packages.
      - Install clang: `pacman -S mingw-w64-ucrt64-x86_64-clang`
        - If `clang --version` isn't working, make sure to add the `bin` to system path (environment variables)
  - Create a [Clangd config](https://clangd.llvm.org/config#files).
    - ex:
```yml
CompileFlags:
  Compiler: clang++.exe
  Add: ["--target=x86_64-w64-windows-gnu"]
  Remove: -f*
Diagnostics:
  UnusedIncludes: None
```
- Requirements
  - Any cpp project will need a compile_commands.json (Compilation database)
  - It will be used by clangd (for linting and code completions). So it only needs minimal info as below
```json
[
  {
    "directory": "<absolute_path_to_project_dir>",
    "arguments": [
      "clang++.exe",
      "-I<include_dir>"
    ],
    "file": "./<path_to_any_cpp_file_in_project>.cpp"
  }
]
```

## Documentation
- `:h lazy.nvim` - Lazy Plugin Manager docs
- `:h nvui` - NvChad UI/base46 docs
- `<space>ch` - Keymaps

## Special thanks to 
- [@siduck](https://github.com/siduck), co-authors, and contributors for making the most popular Neovim commmon-plugin boilerplate removal config [NvChad](https://github.com/NvChad/NvChad), as well as their custom ui and base46 plugins. My custom config wouldn't have been possible without you 😍.

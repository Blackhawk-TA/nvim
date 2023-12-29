# Config for neovim

<!--toc:start-->
- [Dependencies](#dependencies)
  - [Cross platform](#cross-platform)
    - [Arch packages](#arch-packages)
- [Development](#development)
  - [CMake](#cmake)
  - [GoLang](#golang)
  - [Lua](#lua)
  - [Python](#python)
<!--toc:end-->

This is my personal neovim config.

## Dependencies

### Cross platform

- [FiraMono font](https://github.com/ryanoasis/nerd-fonts)
- [Pynvim](https://github.com/neovim/pynvim)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fd](https://github.com/sharkdp/)

### Arch packages

- [Pynvim](https://archlinux.org/packages/extra/any/python-pynvim/)

## Development

### CMake

When using cmake, neovim requires a `compile_commands.json` file
present in the `./build` directory of the project.
This ensures, that all dependent header files are found.
To generate a `compile_commands.json` it is necessary to run
cmake with the `-DCMAKE_EXPORT_COMPILE_COMMANDS=ON` parameter.
A build workflow could look like this:

```bash
mkdir build && cd build
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..
make
```

This produces the `compile_commands.json` in the `.build` directory,
which neovim expects.

### GoLang

Go development works out of the box.

### Lua

To be able to install all required Mason packages,
[luarocks](https://archlinux.org/packages/extra/any/luarocks/) is required.

### Python

For debugging to work, `debugpy` must be installed using mason.
Mason installations are done automatically.
If a virtual environment is used, it requires `debugpy` to be installed there:

```bash
source .venv/bin/activate
pip install debugpy
```

When adding a virtual environment, neovim has to be
restarted to ensure that it is being used.

# Config for neovim
This is my personal neovim config.

## Dependencies

#### Cross platform

- [FiraMono font](https://github.com/ryanoasis/nerd-fonts)
- [Pynvim](https://github.com/neovim/pynvim)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fd](https://github.com/sharkdp/)

#### Arch packages

- [Pynvim](https://archlinux.org/packages/extra/any/python-pynvim/)


## Development

#### CMake

When using cmake, neovim requires a `compile_commands.json` file present in the `./build` directory of the project.
This ensures, that all dependent header files are found.
To generate a `compile_commands.json` it is necessary to run cmake with the `-DCMAKE_EXPORT_COMPILE_COMMANDS=ON` parameter.
A build workflow could look like this:
```bash
mkdir build && cd build
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..
make
```
This produces the `compile_commands.json` in the `.build` directory, which neovim expects.


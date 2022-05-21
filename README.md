# Hs293Go's Dotfiles

## Environment Variables

We detect the existence of some environment variables to selectively activate features. Set these variables in `.zshenv` or `.bash_profile`

These include:

- `VCPKG_ROOT`: Root directory of the `vcpkg` instance
- `PX4_ROOT`: Root directory of the PX4-Autopilot source repository
- `ARDUPILOT_ROOT`: Root directory of the Ardupilot source repository

Refer to [this SE answer](https://unix.stackexchange.com/questions/71253/what-should-shouldnt-go-in-zshenv-zshrc-zlogin-zprofile-zlogout) for proper usage of `zsh` dotfiles.

Refer to [this SE answer](https://apple.stackexchange.com/questions/51036/what-is-the-difference-between-bash-profile-and-bashrc) for the key differences between the `bash` dotfiles.

## Dependencies

[enhancd](https://github.com/b4b4r07/enhancd) depends on a fuzzy finder. We use `fzy`. Install by

``` bash
sudo apt-get install fzy
```

## Compilation

We use [YouCompleteMe](https://github.com/ycm-core/YouCompleteMe.git) for autocompletion in vim. This plugin requires compiling!

``` bash
cd .vim/bundle/YouCompleteMe
CC=gcc-8 CXX=g++-8 python3 install.py --all # Or --clangd-completer
```

where the `CC` and `CXX` variables might need to be specified if the OS ships with a pre-C++17 compiler.

> ### Warning
>
> ---
> Do NOT simply set `CC` or `CXX` to a `clang` compiler on Ubuntu, without confirming that the proper, C++17-compliant libc++ is in use!
>  

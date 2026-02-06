# Setup (ArchLinux)
```sh
git clone https://github.com/odeysseuss/.dotfiles
cd .dotfiles
./scripts/setup/setup.sh
```

# WSL Instructions (Ubuntu)
## Dependencies
```sh
sudo apt update && sudo apt upgrade -y
# some of these could already been installed
sudo apt install git zsh zip unzip xclip wget \
make clang clangd \
fzf ripgrep -y
```

## Neovim Installation
```sh
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update && sudo apt upgrade -y
sudo apt install neovim -y
```

## Starship Installation
```sh
curl -sS https://starship.rs/install.sh | sh
```

## Perf Installation
### Installation dependencies

```sh
sudo apt update && sudo apt upgrade -y
sudo apt install flex bison build-essential -y
sudo apt install libdwarf-dev libelf-dev libnuma-dev libunwind-dev libnewt-dev \
libdwarf++0 libelf++0 libdw-dev libbfb0-dev systemtap-sdt-dev libssl-dev \
libperl-dev python-dev-is-python3 binutils-dev libiberty-dev libzstd-dev \
libcap-dev libbabeltrace-dev libtraceevent-dev pkg-config -y
git clone https://github.com/microsoft/WSL2-Linux-Kernel --depth 1
cd WSL2-Linux-Kernel/tools/perf
make -j$(nproc)
sudo cp perf /usr/local/bin
```

### Run perf
***To run perf you only need these:***
- libnuma-dev
- libbabeltrace-dev
- libtraceevent-dev

```sh
perf list
perf record -e [event] -p [pid]
perf report
```

dotfiles
========

These are my personal dotfiles, managed with [chezmoi](https://chezmoi.io).

I use them:
- On my laptop running [a personalized custom image](https://github.com/ethanjli/lutho-os)
  of [ghcr.io/ublue-os/aurora-dx](https://github.com/ublue-os/bluefin/pkgs/container/aurora-dx)
- In [Distrobox](https://github.com/89luca89/distrobox/) containers

## Features

### Theme

- A visual theme emphasizing visual consistency and readability, notably:
  - Use of the [One Dark](https://onedarktheme.com/) color scheme wherever possible
  - Use of [Atkinson Hyperlegible](https://brailleinstitute.org/freefont) as the sans serif font
    wherever possible
  - Use of the [Intel One Mono](https://www.intel.com/content/www/us/en/company-overview/one-monospace-font.html)'s
    [patched Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/IntelOneMono)
    as the monospace font wherever possible
  - Avoidance of visual clutter

TODO: add screenshots

### Shell

- A self-contained configuration for [zsh](https://www.zsh.org/), notably:
  - Fast startup times (~0.2 s on my laptop)
  - A clean prompt line, using [powerlevel10k](https://github.com/romkatv/powerlevel10k):
    - with a similar look-and-feel as Starship's
      [plain text symbols](https://starship.rs/presets/plain-text.html) preset (only using ASCII
      symbols, for compatibility with virtual consoles)
    - using [instant prompt](https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#instant-prompt)
      for fast startup times
    - left-alignment of all elements to prevent terminal resizing weirdness
    - a reduced set of elements focused on the kinds of projects I work on or might work on
  - A fast, simple, and generalizable plugin system which just uses chezmoi to download plugins at
    pinned versions
  - Organization of files into `$HOME/.config/zsh` and `$HOME/.cache/zsh`
- A self-contained configuration for bash:
  - Fast startup times (~0.2 s on my laptop)
  - A clean prompt line, using [oh-my-posh](https://ohmyposh.dev/) (which I found to be extremely
    fast, in contrast to Starship)
    - configured to have a similar look-and-feel as my powerlevel10k prompt configuration
    - a reduced set of modules focused on the kinds of projects I work on or might work on
  - A fast, simple, and generalizable plugin system which just uses chezmoi to download plugins at
    pinned versions
- Synchronized, fuzzy-searchable shell history using [atuin](https://github.com/atuinsh/atuin)
- A [Zellij](https://zellij.dev/) configuration, notably:
  - Custom keybindings for a simpler, more vim-like experience
  - A modal usage model which defaults to locked mode as the base and enters normal mode using
    `Alt+i` to perform quick actions and access more advanced modes
  - A command-line script with a fuzzy-search menu for attaching to any Zellij session or creating
    a new session, designed to be run as an application launcher for Zellij in graphical desktops
- (WIP) A minimalistic [Neovim](https://neovim.io/) configuration, notably:
  - The Vim compatibility for all plugin-independent configuration
  - Generally default keybindings to avoid disrupting muscle-memory on machines with the default
    keybindings
  - [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager
  - [mason.nvim](https://github.com/williamboman/mason.nvim) as the language support tools manager
- (WIP) An [lf](https://github.com/gokcehan/lf) configuration, notably:
  - Nice previews of:
    - Markdown files, using [glow](https://github.com/charmbracelet/glow)
    - Other text files, using [bat](https://github.com/sharkdp/bat)
    - Raster images, using [chafa](https://hpjansson.org/chafa/) with sixel-based graphics
    - SVG images, using [ImageMagick](https://imagemagick.org/index.php)
    - Videos, using [FFMPEG](https://ffmpeg.org/)
  - (WIP) Integration with Neovim, the shell, and other tools, including:
    - Commands (intended for use with Zellij) for launching a Neovim server instance and then using
      LF to browse and (remotely) open files in that server instance.
- [zoxide](https://github.com/ajeetdsouza/zoxide) shell integration for easier navigation between
  directories
- A [lazygit](https://github.com/jesseduffield/lazygit) configuration for doing most of what I need
  to do with git within a Zellij pane and/or from within lf, notably:
  - A cleaner (and denser) view of the Git log

### Desktop

- A simple [wezterm](https://wezfurlong.org/wezterm/) configuration (because wezterm is fast and
  efficient, it's on Flathub, and I found that wezterm starts up much faster than Contour), notably:
  - Very minimal keybindings, mostly attached to the `Ctrl+Shift` modifier, to avoid disrupting
    muscle-memory on other terminal emulators and to avoid keybinding conflicts
  - No keybindings for panes, since I use Zellij for panes and tabs
  - No session management, since I use Zellij for session management
- (WIP) KDE Plasma configurations & theming, notably:
  - Custom keybindings, mostly attached to the `Meta` modifier, for manual window tiling

### Infrastructure

All general-purpose CLI tools are installed and version-managed with
[aqua](https://aquaproj.github.io/), except for packages listed in the
[prerequisites](#prerequisites) section which can be installed via Homebrew as part of the setup
process described below.

This repository also keeps track of the Flatpak apps installed on the system in the Brewfile (in `~/.Brewfile`).


## Setup

To use this repository, you will first need to set up the dotfiles using chezmoi. Then you will need
to set up global tools using aqua.

### Prerequisites

The following requirements must be met:

- You will need to have either bash or zsh (or both) installed. You probably already have bash
  installed.

If you want to take advantage of certain features, you will need to have some packages installed on
your host environment:

- If you want to use Neovim: the Neovim build downloaded by aqua doesn't run on musl hosts such as
  Alpine Linux - in such environments, Neovim needs to be provided by the host. The shell
  configurations will default to using the host-provided neovim if it exists; otherwise, the
  aqua-provided Neovim will be used as a fallback.
- If you want to use LSP servers and other tools managed by mason.nvim, you will need to have tools
  such as `go`, `node` & `npm`, and `python` and `pip` installed (e.g. using Homebrew). These tools
  can be installed using Homebrew following the instructions below.
- If you want to preview SVG images in LF, you will need ImageMagick, which is not provided by aqua.
  These tools can be installed using Homebrew following the instructions below.
- If you want to preview videos in LF, you will need FFMPEG, which is not provided by aqua.
  These tools can be installed using Homebrew following the instructions below.
- If you want to use zsh, you will need to have it already installed.
  I may eventually investigate [statically-linked zsh build](https://github.com/romkatv/zsh-bin) to
  determine whether it might make sense to provide zsh via aqua or chezmoi.

### Set up dotfiles

To install the dotfiles on a new machine which already has chezmoi, run:

```
chezmoi init --apply ethanjli
```

Otherwise, you should run:

```
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$(mktemp -d)" init --apply ethanjli
```

This will set up the global [aqua](https://aquaproj.github.io) configuration without you having to
install chezmoi first. Then the next step will install chezmoi for you.

### Set up homebrew-managed global tools

After restarting your terminal, you can install tools needed for Neovim LSP and treesitter plugins
(all managed by mason.nvim) by running:

```
systemctl --user start homebrew-install.service
```

### Set up aqua-managed global tools

On a machine without aqua, you can install aqua as follows:

```
curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v3.0.1/aqua-installer | bash
```

(this is only needed when this repository has packages which I have not yet contributed upstream
to the standard aqua repository)

Then you should install the aqua tools by running:

```
aqua i -a
```

### Set up atuin sync

Run `atuin login`.

### (Optional) Set up Flatpak-managed GUI tools

You can install the full list of Flatpaks specifie by this repo by running:

```
systemctl --user start flatpak-install.service
```

## Operations

TODO: add a keybindings cheatsheet

### Upgrade aqua tools

To bump the installed version of an aqua-provided tool after this repo bumps the configured version
to install, just run `aqua i -a`.

### Install any new homebrew tools

To install new packages when this repo adds packages to the Brewfile, run
`systemctl --user start homebrew-install.service`.

### Install any new Flatpak apps

To install new packages when this repo adds packages to the Flatpakfile, run
`systemctl --user start flatpak-install.service`.

### Upgrade zsh & bash plugins

To bump the installed version of a zsh or bash plugin after this repo bumps the configured version
to install, delete the cached plugin directory in `~/.cache/zsh/plugins` or `~/.cache/bash/plugins`,
and run `chezmoi apply`.

## Maintenance

### Add an aqua program

If using local packages from this repository, you may first need to configure aqua to allow that:

```
cd ${XDG_CONFIG_HOME:-$HOME/.config}/aquaproj-aqua
git init
aqua policy allow "${XDG_CONFIG_HOME:-$HOME/.config}/aquaproj-aqua/aqua-policy.yaml"
```

Then you can run:

```
aqua g -o ${XDG_CONFIG_HOME:-$HOME/.config}/aquaproj-aqua/aqua.yaml
```

### Upgrade aqua programs

TBD

### Upgrade zsh & bash plugins

To bump the version of a zsh or bash plugin, update the URL in `.chezmoiexternal.toml`.

## Licensing

Except where otherwise indicated, source code provided here is covered by the following information:

Copyright Ethan Li

SPDX-License-Identifier: Apache-2.0 OR BlueOak-1.0.0

You can use the source code provided here either under the
[Apache 2.0 License](https://www.apache.org/licenses/LICENSE-2.0)
or under the
[Blue Oak Model License 1.0.0](https://blueoakcouncil.org/license/1.0.0);
you get to decide. I am making the software available under the Apache license because it's
[OSI-approved](https://writing.kemitchell.com/2019/05/05/Rely-on-OSI.html),
but I like the Blue Oak Model License more because it's easier to read and understand.

dotfiles
========

These are my personal dotfiles, managed with [chezmoi](https://chezmoi.io).

I use them:
- On my laptop running [a personal Fedora Kinoite-based fork](https://github.com/ethanjli/lutho-os)
  of [ghcr.io/ublue-os/bluefin-dx](https://github.com/ublue-os/bluefin/pkgs/container/bluefin-dx)
  (Bluefin is a [Fedora Silverblue](https://fedoraproject.org/silverblue/) OCI image)
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
  - Synchronized, fuzzy-searchable shell history using [atuin](https://github.com/atuinsh/atuin)
  - A fast, simple, and generalizable plugin system which just uses chezmoi to download plugins at
    pinned versions
  - Organization of files into `$HOME/.config/zsh` and `$HOME/.cache/zsh`
- A self-contained configuration for bash:
  - Fast startup times (~0.2 s on my laptop)
  - A clean prompt line, using [oh-my-posh](https://ohmyposh.dev/) (which I found to be extremely
    fast, in contrast to Starship)
    - configured to have a similar look-and-feel as my powerlevel10k prompt configuration
    - a reduced set of modules focused on the kinds of projects I work on or might work on
  - Synchronized, fuzzy-searchable shell history using [atuin](https://github.com/atuinsh/atuin)
  - A fast, simple, and generalizable plugin system which just uses chezmoi to download plugins at
    pinned versions
- A [Zellij](https://zellij.dev/) configuration, notably:
  - Custom keybindings for a simpler, more vim-like experience
  - A modal usage model which defaults to locked mode as the base and enters normal mode using
    `Alt+i` to perform quick actions and access more advanced modes
  - A command-line script with a fuzzy-search menu for attaching to any Zellij session or creating
    a new session, designed to be run as an application launcher for Zellij in graphical desktops
- (WIP) A minimalistic [Neovim](https://neovim.io/) configuration, notably:
  - Shell integration to use Neovim instead of Vim when Neovim is available
  - The same configuration for Neovim, Vim, and the Neovim Flatpak
  - Generally default keybindings to avoid disrupting muscle-memory on machines with the default
    keybindings
- (WIP) An [lf](https://github.com/gokcehan/lf) configuration, notably:
  - Nice previews of:
    - Markdown files, using [glow](https://github.com/charmbracelet/glow)
    - Other text files, using [bat](https://github.com/sharkdp/bat)
    - Raster images, using [chafa](https://hpjansson.org/chafa/) with sixel-based graphics
    - SVG images, using [ImageMagick](https://imagemagick.org/index.php)
    - Videos, using [FFMPEG](https://ffmpeg.org/)
  - (WIP) Integration with Neovim, the shell, and other tools
- [zoxide](https://github.com/ajeetdsouza/zoxide) shell integration for easier navigation between
  directories
- A [lazygit](https://github.com/jesseduffield/lazygit) configuration for doing most of what I need
  to do with git within a Zellij pane and/or from within lf, notably:
  - A cleaner (and denser) view of the Git log
  - (WIP) Custom keybindings

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
[prerequisites](#prerequisites) section.


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
  Alpine Linux - in such environments, Neovim needs to be provided by the host.
- If you want to preview SVG images in LF, you will need ImageMagick, which is not provided by aqua.
  I will eventually look for an alternative which could be provided via aqua.
- If you want to preview videos in LF, you will need FFMPEG, which is not provided by aqua.
  I will eventually look for an alternative which could be provided via aqua.
- If you want to use zsh, you will need to have it already installed
  I will eventually investigate the [statically-linked zsh build](https://github.com/romkatv/zsh-bin)
  to determine whether it might make sense to provide zsh via aqua or chezmoi.

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

### Set up global tools

On a machine without aqua, you can install aqua as follows:

```
curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v2.2.0/aqua-installer | bash
```

(this is only needed when this repository has packages which I have not yet contributed upstream
to the standard aqua repository)

Then you should install the aqua tools by running:

```
aqua i -a
```

### Set up atuin sync

Run `atuin login`.

## Operations

TODO: add a keybindings cheatsheet

### Upgrade aqua tools

To bump the installed version of an aqua-provided tool after this repo bumps the configured version
to install, just run `aqua i -a`.

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

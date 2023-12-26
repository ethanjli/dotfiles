dotfiles
========

These are my personal dotfiles, managed with [chezmoi](https://chezmoi.io).

I use them:
- On my laptop running [a personal Fedora Kinoite-based fork](https://github.com/ethanjli/lutho-os)
  of [ghcr.io/ublue-os/bluefin-dx](https://github.com/ublue-os/bluefin/pkgs/container/bluefin-dx)
  (Bluefin is a [Fedora Silverblue](https://fedoraproject.org/silverblue/) OCI image)
- In [Distrobox](https://github.com/89luca89/distrobox/) containers

## Features

- A visual theme emphasizing visual comfort, notably:
  - Use of the [One Dark](https://onedarktheme.com/) color scheme wherever possible
  - Use of [Atkinson Hyperlegible](https://brailleinstitute.org/freefont) as the sans serif font
    wherever possible
  - Use of the [Intel One Mono](https://www.intel.com/content/www/us/en/company-overview/one-monospace-font.html)'s
    [patched Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/IntelOneMono)
    as the monospace font wherever possible
- A self-contained configuration for [zsh](https://www.zsh.org/), notably:
  - Fast startup times (~0.2 s on my laptop)
  - A clean prompt line, using [powerlevel10k](https://github.com/romkatv/powerlevel10k) with a
    similar look-and-feel as Starship's [plain text symbols](https://starship.rs/presets/plain-text.html)
    preset
    - using [instant prompt](https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#instant-prompt)
      for fast startup times
    - sticking to ASCII symbols for compatibility with virtual consoles
    - left-alignment of all elements to prevent terminal resizing weirdness
    - a reduced set of elements focused on the kinds of projects I work on or might work on
  - Synchronized, fuzzy-searchable shell history using [atuin](https://github.com/atuinsh/atuin)
  - A fast, simple, and generalizable plugin system which just uses chezmoi to download plugins at
    pinned versions
  - Organization of files into `$HOME/.config/zsh` and `$HOME/.cache/zsh`
- A self-contained configuration for bash:
  - Somewhat reasonable startup times (~0.4 s on my laptop)
  - A clean prompt line, using [starship](https://starship.rs/)
    - sticking to ASCII symbols for compatibility with virtual consoles
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
- All general-purpose CLI tools installed and version-managed with [aqua](https://aquaproj.github.io/);
  with the following caveats:
  - The Neovim build downloaded by aqua doesn't run on musl hosts such as Alpine Linux - in such
    environments, Neovim needs to be provided as a host package
  - ImageMagick is not provided; it is only used for preview of SVG images in LF. I will eventually
    look for an alternative which could be provided via aqua.
  - FFMPEG is not provided; it is only used for preview of videos in LF. I will eventually look for
    an alternative which could be provided via aqua.
  - Zsh is not provided, though it [could be provided](https://github.com/romkatv/zsh-bin)
  - Bash is not provided, obviously
- A simple [wezterm](https://wezfurlong.org/wezterm/) configuration (because wezterm is fast and
  efficient, it's on Flathub, and I found that wezterm starts up much faster than Contour), notably:
  - Very minimal keybindings, mostly attached to the `Ctrl+Shift` modifier, to avoid disrupting
    muscle-memory on other terminal emulators and to avoid keybinding conflicts
  - No keybindings for panes, since I use Zellij for panes and tabs
  - No session management, since I use Zellij for session management
- (WIP) KDE Plasma configurations & theming, notably:
  - Custom keybindings, mostly attached to the `Meta` modifier, for manual window tiling

## Usage

### Set up dotfiles

To install the dotfiles on a new machine with chezmoi available, run:

```
chezmoi init --apply ethanjli
```

Or on a machine without chezmoi, you can bootstrap the global [aqua](https://aquaproj.github.io)
configuration (which in turn will install chezmoi) without having to first install chezmoi:

```
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$(mktemp -d)" init --apply ethanjli
```

### Set up global tools

On a machine without aqua, you can install aqua as follows:

```
curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v2.2.0/aqua-installer | bash
```

Then you will need to allow use of non-standard aqua packages provided by this repository:

```
cd ${XDG_CONFIG_HOME:-$HOME/.config}/aquaproj-aqua
git init
aqua policy allow "${XDG_CONFIG_HOME:-$HOME/.config}/aquaproj-aqua/aqua-policy.yaml"
```

Then you can install the aqua tools by running:

```
aqua i -a
```

### Set up atuin sync

Run `atuin login`.

### Upgrade zsh & bash plugins

To bump the installed version of a zsh or bash plugin after this repo bumps the configured version
to install, delete the cached plugin directory in `~/.cache/zsh/plugins` or `~/.cache/bash/plugins`,
and run `chezmoi apply`.

## Maintenance

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

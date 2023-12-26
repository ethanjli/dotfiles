dotfiles
========

These are my personal dotfiles, managed with [chezmoi](https://chezmoi.io).

## Usage

### Set up dotfiles

To install the dotfiles on a new machine with chezmoi available, run:

```
chezmoi init --apply ethanjli
```

Or on a machine without chezmoi, you can bootstrap the global [aqua](https://aquaproj.github.io) configuration (which in turn will install chezmoi) without having to first install chezmoi:

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

## Licensing

Except where otherwise indicated, source code provided here is covered by the following information:

Copyright Ethan Li

SPDX-License-Identifier: Apache-2.0 OR BlueOak-1.0.0

You can use the source code provided here either under the [Apache 2.0 License](https://www.apache.org/licenses/LICENSE-2.0) or under the [Blue Oak Model License 1.0.0](https://blueoakcouncil.org/license/1.0.0); you get to decide. I am making the software available under the Apache license because it's [OSI-approved](https://writing.kemitchell.com/2019/05/05/Rely-on-OSI.html), but I like the Blue Oak Model License more because it's easier to read and understand.

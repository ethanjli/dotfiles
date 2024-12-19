# Lutho Keyboard Guide

## Design

TODO

## Plasma Desktop

Plasma Desktop shortcuts generally use Meta and the left hand, in order to keep the right hand free for mouse usage. We also keep some standard shortcuts with Alt.

### Layout

We use manual quick-tiling for layout, with the idea that Shift causes a layout change, Ctrl causes a size change and Alt is a more "extreme" version of an action. We use `w`/`a`/`d`/`x` as the directions for tiling, while `s` is for the center.

- Meta + `w`/`x`/`a`/`d`: switch to the next window to the above/below/left/right
- Meta + `s`: lower the current window below other windows, and switch to the next active window
   - Meta + Alt + `s`: toggle whether to lower the current window below other windows, without switching the active window
- Meta + Shift + `w`/`x`/`a`/`d`: quick-tile window to the upper/bottom/left/right half
- Meta + Shift + `q`/`e`/`z`/`c`: quick-tile to the upper-left/upper-right/lower-left/lower-right quadrant
- Meta + Shift + `s`: maximize window
   - Meta + Shift + Alt + `s`: toggle window fullscreen
- Meta +  `f`: send window to picture-in-picture mode (with the Thumbnail Aside desktop effect)
- Meta + Esc: minimize window
- Meta + Alt + Esc: close window

Non-tiling layout actions use the arrow keys:

- Meta + Up/Down/Left/Right: switch to the next window to the above/below/left/right
- Meta + Shift + Up/Down/Left/Right: move window to the top/bottom/left/right edge

- Meta + `/`: move the window with the mouse

- Meta + Shift + `/`: move window to the center

- Meta + Ctrl + `/`: resize the window with the mouse

### Navigation

Layout-based navigation between windows uses `w`/`x`/`a`/`d`; navigation between desktops uses the Alt modifier with `q`/`e`; and navigation between screens uses the Alt modifier with `z`/`c`. With the Shift modifier, we move the current window.

Relative: 

- Meta + `w`/`x`/`a`/`d`: switch to the next window to the left/below/above/right
- Meta + Alt + `q`/`e`: switch to previous/next desktop
- Meta + Alt + Shift + `q`/`e`: move current window while switching to previous/next desktop
- Meta + Alt + `z`/`c`: switch to previous/next screen
- Meta + Alt + Shift + `z`/`c`: move current window while switching to next/previous screen

Absolute:

- Meta + `1`/`2`/`3`/.../`9`/`0`: switch to window 1/2/3/.../9/10 on the taskbar
- Meta + Alt + `1`/`2`/`3`/.../`9`/`0`: switch to desktop 1/2/3/.../9/10
- Meta + Alt + Shift + `1`/`2`/`3`/..../`9`/`0`: move current window to desktop 0/2/3/.../9/10

Windows can be also selected by walking through the main and alternate task switchers. In this context, the Alt modifier walks through all un-minimized windows on the current screen+desktop while the Meta modifier only walks through minimized windows on the current screen+desktop; and the Tab key walks through all windows while the ` key only walks through windows of the current application.

- Alt + Tab: walk through windows on the current screen+desktop
- Alt + `` ` ``: walk through windows on the current screen+desktop of the current application
- Meta + Tab: walk through minimized windows on the current screen+desktop
- Meta + `` ` ``: walk through minimized windows on the current screen+desktop of current application

### Accessibility

The Zoom desktop effect is intentionally disabled because it causes problems with kwin wayland: opening menus in GNOME apps [causes a 25-second freeze](https://bugs.kde.org/show_bug.cgi?id=462346) when focus tracking is enabled, and even just having the Zoom desktop effect enabled causes a similarly long freeze when opening images in Gwenview.

The Invert desktop effect can be controlled:

- Meta + `v`: toggle invert window colors

### Launching

Panel shortcuts:

- Meta: Application Launcher
- Alt + `F2`: Global Menu
- Alt + `F3`: Window Operations Menu
- Meta + Space: System Tray
- Alt + Space: KRunner
- Meta + Alt + Space: Overview
- Meta + Shift + Space: Peek at Desktop
- Meta + Ctrl + Space: Calendar

Specific programs are launched with Meta + function keys:

- Meta + `F1`: Google Chrome
- Meta + `F2`: Dolphin
- Meta + `F3`: lf (terminal-based file manager)
- Meta + `F4`: Attach a Zellij session (terminal multiplexer)
- Meta + `F5`: WezTerm (terminal)

We also keep the following default program launch shortcuts for general utilities:

- Meta + `.`: Emoji Selector
- Meta + `,`: Crow Translate

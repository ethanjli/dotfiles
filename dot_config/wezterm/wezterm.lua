-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action
local mux = wezterm.mux

-- Set startup behavior
wezterm.on('gui-startup', function(cmd)
  local _, _, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

config.color_scheme = 'OneDark (base16)'

config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 32
config.window_frame = {
  font = wezterm.font { family = 'Atkinson Hyperlegible', weight = 'Bold' },
  -- active_titlebar_bg = '#323842', -- from the official One Dark colorscheme
  active_titlebar_bg = '#1E222A', -- integrate with KDE Plasma's One Dark colorscheme
  inactive_titlebar_bg = '#21252B',
}
config.colors = {
  tab_bar = {
    -- background = '#1E2227', -- from the official One Dark colorscheme
    background = '#1E222A', -- integrate with KDE Plasma's One Dark colorscheme
    active_tab = {
      bg_color = '#282C34',
      fg_color = '#F6F7F9',
      intensity = 'Bold',
    },
    inactive_tab = {
      -- bg_color = '#1E2227', -- from the official One Dark colorscheme
      bg_color = '#1E222A', -- integrate with KDE Plasma's One Dark colorscheme
      fg_color = '#ABB2BF',
    },
    inactive_tab_hover = {
      -- bg_color = '#1E2227', -- from the official One Dark colorscheme
      bg_color = '#1E222A', -- integrate with KDE Plasma's One Dark colorscheme
      fg_color = '#ABB2BF',
      intensity = 'Bold',
    },
    new_tab = {
      -- bg_color = '#1E2227', -- from the official One Dark colorscheme
      bg_color = '#1E222A', -- integrate with KDE Plasma's One Dark colorscheme
      fg_color = '#ABB2BF',
    },
    new_tab_hover = {
      -- bg_color = '#1E2227', -- from the official One Dark colorscheme
      bg_color = '#1E222A', -- integrate with KDE Plasma's One Dark colorscheme
      fg_color = '#ABB2BF',
      intensity = 'Bold',
    },
  }
}

config.window_padding = {
  left = "6pt",
  right = "6pt",
  top = "6pt",
  bottom = "6pt",
}

config.font = wezterm.font {
  family = 'IntoneMono Nerd Font',
}
config.freetype_load_target = 'Normal'

config.default_cursor_style = 'SteadyBar'

config.window_close_confirmation = 'NeverPrompt'

config.disable_default_key_bindings = true
config.keys = {
  { key = ';', mods = 'CTRL', action = act.ActivateCommandPalette },
  { key = ':', mods = 'SHIFT|CTRL', action = act.ShowLauncher },
  { key = ':', mods = 'ALT|SHIFT|CTRL', action = act.ShowDebugOverlay },
  { key = 'T', mods = 'SHIFT|CTRL', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'W', mods = 'SHIFT|CTRL', action = act.CloseCurrentTab{confirm = false} },
  { key = 'PageDown', mods = 'CTRL', action = act.ActivateTabRelative(1) },
  { key = 'PageDown', mods = 'SHIFT|CTRL', action = act.MoveTabRelative(1) },
  { key = 'Tab', mods = 'CTRL', action = act.ActivateTabRelative(1) },
  { key = 'PageUp', mods = 'CTRL', action = act.ActivateTabRelative(-1) },
  { key = 'PageUp', mods = 'SHIFT|CTRL', action = act.MoveTabRelative(-1) },
  { key = 'Tab', mods = 'SHIFT|CTRL', action = act.ActivateTabRelative(-1) },
  { key = '1', mods = 'CTRL', action = act.ActivateTab(0) },
  { key = '!', mods = 'SHIFT|CTRL', action = act.MoveTab(0) },
  { key = '2', mods = 'CTRL', action = act.ActivateTab(1) },
  { key = '@', mods = 'SHIFT|CTRL', action = act.MoveTab(1) },
  { key = '3', mods = 'CTRL', action = act.ActivateTab(2) },
  { key = '#', mods = 'SHIFT|CTRL', action = act.MoveTab(2) },
  { key = '4', mods = 'CTRL', action = act.ActivateTab(3) },
  { key = '$', mods = 'SHIFT|CTRL', action = act.MoveTab(3) },
  { key = '5', mods = 'CTRL', action = act.ActivateTab(4) },
  { key = '%', mods = 'SHIFT|CTRL', action = act.MoveTab(4) },
  { key = '6', mods = 'CTRL', action = act.ActivateTab(5) },
  { key = '^', mods = 'SHIFT|CTRL', action = act.MoveTab(5) },
  { key = '7', mods = 'CTRL', action = act.ActivateTab(6) },
  { key = '&', mods = 'SHIFT|CTRL', action = act.MoveTab(6) },
  { key = '8', mods = 'CTRL', action = act.ActivateTab(7) },
  { key = '*', mods = 'SHIFT|CTRL', action = act.MoveTab(7) },
  { key = '9', mods = 'CTRL', action = act.ActivateTab(8) },
  { key = '(', mods = 'SHIFT|CTRL', action = act.MoveTab(8) },
  { key = '0', mods = 'CTRL', action = act.ResetFontSize },
  { key = '=', mods = 'CTRL', action = act.IncreaseFontSize },
  { key = '-', mods = 'CTRL', action = act.DecreaseFontSize },
  { key = 'L', mods = 'SHIFT|CTRL', action = act.ClearScrollback 'ScrollbackAndViewport' },
  { key = 'PageUp', mods = 'SHIFT', action = act.ScrollByPage(-1) },
  { key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1) },
  { key = 'UpArrow', mods = 'SHIFT', action = act.ScrollByLine(-1) },
  { key = 'DownArrow', mods = 'SHIFT', action = act.ScrollByLine(1) },
  { key = 'F', mods = 'SHIFT|CTRL', action = act.Search 'CurrentSelectionOrEmptyString' },
  { key = 'C', mods = 'SHIFT|CTRL', action = act.CopyTo 'Clipboard' },
  { key = 'V', mods = 'SHIFT|CTRL', action = act.PasteFrom 'Clipboard' },
  { key = 'phys:Space', mods = 'SHIFT|CTRL', action = act.ActivateCopyMode },
}

-- set the default shell
config.default_prog = { '/usr/bin/zsh', '-l' }

-- and finally, return the configuration to wezterm
return config

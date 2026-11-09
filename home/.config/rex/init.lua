-- Rex configuration, migrated from tmux, Herdr and WezTerm.

-- tmux (~/.config/tmux/tmux.conf), prefix ctrl+b
rex.bind("ctrl+b>shift+\\", "pane.split", { direction = "right" })
rex.bind("ctrl+b>-", "pane.split", { direction = "down" })
rex.bind("ctrl+b>|", "pane.split", { direction = "right" })
rex.bind("ctrl+b>c", "client.tab.new")
-- Pass the prefix through to programs that use it themselves.
rex.bind("ctrl+b>ctrl+b", "pane.send_key", { key = "ctrl+b" })

-- WezTerm (~/.config/wezterm/wezterm.lua): its macOS-style text navigation
-- keys (cmd+left, cmd+right, cmd+backspace, alt+left, alt+right) are Rex defaults.

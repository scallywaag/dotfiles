-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
-- require("awful.hotkeys_popup.keys")

-- HACK: custom tasklist with client class instead of client name
local tasklistc = require("tasklistc")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Oops, there were errors during startup!",
		text = awesome.startup_errors,
	})
end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function(err)
		-- Make sure we don't go into an endless error loop
		if in_error then
			return
		end
		in_error = true

		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Oops, an error happened!",
			text = tostring(err),
		})
		in_error = false
	end)
end
-- }}}

--- Enable for lower memory consumption
collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
gears.timer({
	timeout = 5,
	autostart = true,
	call_now = true,
	callback = function()
		collectgarbage("collect")
	end,
})

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

-- HACK: add gap
beautiful.useless_gap = 1

-- HACK: desktop indicator underline bar
local theme_dir = os.getenv("HOME") .. "/.config/awesome/"
beautiful.taglist_squares_sel = theme_dir .. "bar31.png"
beautiful.taglist_squares_unsel = theme_dir .. "bar31.png"
beautiful.taglist_spacing = 7

-- This is used later as the default terminal and editor to run.
local terminal = "kitty"
local editor = os.getenv("EDITOR") or "nano"
local editor_cmd = terminal .. " -e " .. editor

local mod = "Mod1"
local super = "Mod4"
local m1 = 10
local m2 = 18

-- {{{ System settings
-- set up mouse - remove acceleration (wired+wireless)
awful.spawn.with_shell("xinput --set-prop " .. m1 .. " 'libinput Accel Profile Enabled' 0, 1, 0")
awful.spawn.with_shell("xinput --set-prop " .. m2 .. " 'libinput Accel Profile Enabled' 0, 1, 0")
awful.spawn.with_shell("xsetroot -cursor_name left_ptr")

-- set up keyboard
awful.spawn.with_shell("xset r rate 300 50")
awful.spawn.with_shell("xmodmap ~/.config/.Xmodmap")

-- turn off screen blanking and DPMS
awful.spawn.with_shell("xset s off")
awful.spawn.with_shell("xset s noblank")
awful.spawn.with_shell("xset -dpms")

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
	-- awful.layout.suit.floating,
	awful.layout.suit.tile,
	-- awful.layout.suit.tile.left,
	-- awful.layout.suit.tile.bottom,
	-- awful.layout.suit.tile.top,
	-- awful.layout.suit.fair,
	-- awful.layout.suit.fair.horizontal,
	-- awful.layout.suit.spiral,
	-- awful.layout.suit.spiral.dwindle,
	-- awful.layout.suit.max,
	-- awful.layout.suit.max.fullscreen,
	-- awful.layout.suit.magnifier,
	-- awful.layout.suit.corner.nw,
	-- awful.layout.suit.corner.ne,
	-- awful.layout.suit.corner.sw,
	-- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
local myawesomemenu = {
	{
		"hotkeys",
		function()
			hotkeys_popup.show_help(nil, awful.screen.focused())
		end,
	},
	{ "manual", terminal .. " -e man awesome" },
	{ "edit config", editor_cmd .. " " .. awesome.conffile },
	{ "restart", awesome.restart },
	{
		"quit",
		function()
			awesome.quit()
		end,
	},
}

local mymainmenu = awful.menu({
	items = {
		{ "awesome", myawesomemenu, beautiful.awesome_icon },
		{ "open terminal", terminal },
	},
})

local mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
-- mykeyboardlayout = awful.widget.keyboardlayout()

-- SYSTRAY
local mysystray = wibox.widget.systray()
mysystray.forced_height = 22
beautiful.systray_icon_spacing = 10
local systray_container = wibox.container.place(mysystray)

-- {{{ Wibar
-- Create a textclock widget
local mytextclock = wibox.widget.textclock()
mytextclock.font = "Noto Sans Mono 12"

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),
	awful.button({ mod }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ mod }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({}, 4, function(t)
		awful.tag.viewnext(t.screen)
	end),
	awful.button({}, 5, function(t)
		awful.tag.viewprev(t.screen)
	end)
)

local tasklist_buttons = gears.table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal("request::activate", "tasklist", { raise = true })
		end
	end),
	awful.button({}, 3, function()
		awful.menu.client_list({ theme = { width = 250 } })
	end),
	awful.button({}, 4, function()
		awful.client.focus.byidx(1)
	end),
	awful.button({}, 5, function()
		awful.client.focus.byidx(-1)
	end)
)

local function set_wallpaper(s)
	-- Wallpaper
	-- if beautiful.wallpaper then
	-- 	local wallpaper = beautiful.wallpaper
	-- 	-- If wallpaper is a function, call it with the screen
	-- 	if type(wallpaper) == "function" then
	-- 		wallpaper = wallpaper(s)
	-- 	end
	-- 	-- gears.wallpaper.maximized(wallpaper, s, true)
	-- end
	awful.spawn.with_shell("feh --bg-scale /home/patrik/Pictures/Wallpapers/KDE_Altai_5120x2880.png")
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

-- TODO: create a mapping of tag - screen, both text. pass tag and screen to all
-- functions that need to use them.
awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	set_wallpaper(s)

	--NOTE:
	-- if 2 screens, split the tags
	local num_screens = screen.count()

	-- Assign tags based on the number of screens
	if num_screens == 1 then
		awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" }, s, awful.layout.suit.tile)
	elseif num_screens == 2 then
		if s.index == 1 then
			awful.tag({ "1", "2", "3", "4", "5", "6" }, s, awful.layout.suit.tile)
		elseif s.index == 2 then
			awful.tag({ "7", "8", "9", "0" }, s, awful.layout.suit.tile)
		end
	end

	-- -- Each screen has its own tag table.
	-- awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()
	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end),
		awful.button({}, 4, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 5, function()
			awful.layout.inc(-1)
		end)
	))
	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = taglist_buttons,
		style = {
			font = "Noto Sans Mono 12",
			fg_focus = "#000",
			bg_focus = "#8CC2E1",
		},
		widget_template = {
			{
				{
					id = "text_role",
					widget = wibox.widget.textbox,
				},
				left = 14,
				right = 14,
				widget = wibox.container.margin,
			},
			id = "background_role",
			widget = wibox.container.background,
		},
	})

	-- Create a tasklist widget
	-- s.mytasklist = awful.widget.tasklist({
	s.mytasklist = tasklistc({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons,
		style = {
			shape = gears.shape.rectangle,
			shape_border_width = 2,
			shape_border_color = "#222",
			font = "Noto Sans Mono 9",
			fg_focus = "#000",
			bg_focus = "#8CC2E1",
			-- bg_normal = "#444",
		},
		layout = {
			spacing = 10,
			layout = wibox.layout.fixed.horizontal,
		},
		widget_template = {
			{
				{
					{
						id = "text_role",
						widget = wibox.widget.textbox,
					},
					layout = wibox.layout.fixed.horizontal,
				},
				left = 10,
				right = 10,
				widget = wibox.container.margin,
			},
			id = "background_role",
			widget = wibox.container.background,
		},
	})

	-- Create the wibox
	s.mywibox = awful.wibar({ position = "bottom", screen = s, height = 30 })

	-- for the life of me I can't understand "frontend"
	-- but this should center the middle part and unless you spawn 10 clients
	-- it won't overlap the left and right parts
	-- Add widgets to the wibox
	s.mywibox:setup({
		layout = wibox.layout.align.horizontal,
		expand = "none",
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			-- mylauncher,
			s.mytaglist,
			s.mypromptbox,
			-- spacing = 28,
		},
		s.mytasklist,
		-- {
		-- 	layout = wibox.layout.align.horizontal,
		-- 	expand = "outside",
		-- 	nil, -- left spacer
		-- 	s.mytasklist, -- actual tasklist
		-- 	nil, -- right spacer
		-- },
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			-- mykeyboardlayout,
			-- wibox.widget.systray(),
			--
			-- mysystray,
			systray_container,
			mytextclock,
			-- s.mylayoutbox,
		},
	})
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
	awful.button({}, 3, function()
		mymainmenu:toggle()
	end),
	awful.button({}, 4, awful.tag.viewnext),
	awful.button({}, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
-- TODO: split keybinds between apps and client/tag control
globalkeys = gears.table.join(
	awful.key({ super, "Shift" }, "Return", function()
		awful.spawn.easy_async_with_shell(
			[[rofi -dmenu -p "Insert label:" -theme ~/.config/rofi/prompt.rasi]],
			function(label)
				label = label:gsub("%s+", "")
				if label ~= "" then
					awful.spawn("kitty --class " .. label)
				else
					awful.spawn("kitty")
				end
			end
		)
	end, { description = "launch kitty with class via rofi", group = "launcher" }),

	awful.key({ mod }, "/", function()
		awful.spawn("rofi -show drun -show-icons")
	end, { description = "rofi app launcher", group = "launcher" }),

	awful.key({ super }, "l", function()
		awful.spawn("betterlockscreen -l")
	end, { description = "lock screen", group = "launcher" }),

	awful.key({ mod }, "F1", function()
		awful.spawn("kitty --class customterm -T btopkitty -e btop")
	end, { description = "launch btop kitty in top-right corner", group = "launcher" }),

	-- awful.key({ super }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),

	awful.key({ super }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
	awful.key({ super }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),

	awful.key({ super }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),

	awful.key({ mod, "Shift" }, "l", function()
		awful.client.focus.byidx(1)
	end, { description = "focus next by index", group = "client" }),
	awful.key({ mod, "Shift" }, "h", function()
		awful.client.focus.byidx(-1)
	end, { description = "focus previous by index", group = "client" }),

	awful.key({ mod, "Shift" }, "j", function()
		awful.client.focus.bydirection("down")
		if client.focus then
			client.focus:raise()
		end
	end, { description = "focus down by direction", group = "client" }),
	awful.key({ mod, "Shift" }, "k", function()
		awful.client.focus.bydirection("up")
		if client.focus then
			client.focus:raise()
		end
	end, { description = "focus up by direction", group = "client" }),

	awful.key({ mod, "Shift" }, "`", function()
		local cc = {}
		for _, c in ipairs(client.get()) do
			if awful.widget.tasklist.filter.currenttags(c, mouse.screen) then
				cc[#cc + 1] = c
			end
		end
		local new_focused = cc[1]
		if new_focused then
			client.focus = new_focused
			new_focused:raise()
		end
	end, { description = "focus first", group = "client" }),

	awful.key({ super }, "w", function()
		mymainmenu:show()
	end, { description = "show main menu", group = "awesome" }),

	-- Layout manipulation
	awful.key({ mod, "Ctrl" }, "l", function()
		awful.client.swap.byidx(1)
	end, { description = "swap with next client by index", group = "client" }),
	awful.key({ mod, "Ctrl" }, "h", function()
		awful.client.swap.byidx(-1)
	end, { description = "swap with previous client by index", group = "client" }),

	-- awful.key({ super, "Control" }, "j", function()
	-- 	awful.screen.focus_relative(1)
	-- end, { description = "focus the next screen", group = "screen" }),
	-- awful.key({ super, "Control" }, "k", function()
	-- 	awful.screen.focus_relative(-1)
	-- end, { description = "focus the previous screen", group = "screen" }),

	awful.key({ super }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),

	awful.key({ super }, "Tab", function()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end, { description = "go back", group = "client" }),

	-- Standard program
	awful.key({ super }, "Return", function()
		awful.spawn(terminal)
	end, { description = "open a terminal", group = "launcher" }),

	-- awful.key({ super, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
	awful.key({ mod, "Shift" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
	-- awful.key({ super, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),

	awful.key({ mod }, "]", function()
		awful.tag.incmwfact(0.05)
	end, { description = "increase master width factor", group = "layout" }),
	awful.key({ mod }, "[", function()
		awful.tag.incmwfact(-0.05)
	end, { description = "decrease master width factor", group = "layout" }),

	awful.key({ mod, "Shift" }, "]", function()
		awful.tag.incnmaster(1, nil, true)
	end, { description = "increase the number of master clients", group = "layout" }),
	awful.key({ mod, "Shift" }, "[", function()
		awful.tag.incnmaster(-1, nil, true)
	end, { description = "decrease the number of master clients", group = "layout" }),

	awful.key({ mod, "Control" }, "]", function()
		awful.tag.incncol(1, nil, true)
	end, { description = "increase the number of columns", group = "layout" }),
	awful.key({ mod, "Control" }, "[", function()
		awful.tag.incncol(-1, nil, true)
	end, { description = "decrease the number of columns", group = "layout" }),

	-- awful.key({ super }, "space", function()
	-- 	awful.layout.inc(1)
	-- end, { description = "select next", group = "layout" }),
	-- awful.key({ super, "Shift" }, "space", function()
	-- 	awful.layout.inc(-1)
	-- end, { description = "select previous", group = "layout" }),

	awful.key({ mod, "Shift" }, "n", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:emit_signal("request::activate", "key.unminimize", { raise = true })
		end
	end, { description = "restore minimized", group = "client" }),

	-- Prompt
	-- awful.key({ super }, "r", function()
	-- 	awful.screen.focused().mypromptbox:run()
	-- end, { description = "run prompt", group = "launcher" }),

	awful.key({ super }, "x", function()
		awful.prompt.run({
			prompt = "Run Lua code: ",
			textbox = awful.screen.focused().mypromptbox.widget,
			exe_callback = awful.util.eval,
			history_path = awful.util.get_cache_dir() .. "/history_eval",
		})
	end, { description = "lua execute prompt", group = "awesome" }),

	-- Menubar
	-- awful.key({ super }, "p", function()
	-- 	menubar.show()
	-- end, { description = "show the menubar", group = "launcher" })

	awful.key({ super }, "p", function()
		awful.spawn("pavucontrol")
	end, { description = "pavucontrol", group = "launcher" }),

	awful.key({ super }, "b", function()
		awful.spawn("google-chrome-stable")
	end, { description = "google-chrome", group = "launcher" }),

	awful.key({ super }, "s", function()
		awful.spawn("flameshot gui")
	end, { description = "flameshot", group = "launcher" }),

	awful.key({ super }, "j", function()
		awful.spawn("flameshot full --region 1920x1080+0+0")
	end, { description = "flameshot", group = "launcher" }),

	awful.key({ super, "Shift" }, "j", function()
		awful.spawn("flameshot full --region 1920x1080+0+0 -c")
	end, { description = "flameshot", group = "launcher" }),

	awful.key({ super }, "k", function()
		awful.spawn("flameshot full --region 1920x1080+1920+0")
	end, { description = "flameshot", group = "launcher" }),

	awful.key({ super, "Shift" }, "k", function()
		awful.spawn("flameshot full --region 1920x1080+1920+0 -c")
	end, { description = "flameshot", group = "launcher" }),

	awful.key({ super }, "e", function()
		awful.spawn("thunar")
	end, { description = "thunar", group = "launcher" })
)

clientkeys = gears.table.join(
	awful.key({ super }, "f", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, { description = "toggle fullscreen", group = "client" }),

	-- awful.key({ super, "Shift" }, "c", function(c)
	-- 	c:kill()
	-- end, { description = "close", group = "client" }),
	--

	awful.key({ mod, "Shift" }, "q", function(c)
		c:kill()
	end, { description = "close", group = "client" }),

	awful.key(
		{ super, "Control" },
		"space",
		awful.client.floating.toggle,
		{ description = "toggle floating", group = "client" }
	),

	awful.key({ super, "Control" }, "Return", function(c)
		c:swap(awful.client.getmaster())
	end, { description = "move to master", group = "client" }),

	awful.key({ super }, "o", function(c)
		c:move_to_screen()
	end, { description = "move to screen", group = "client" }),

	awful.key({ super }, "t", function(c)
		c.ontop = not c.ontop
	end, { description = "toggle keep on top", group = "client" }),

	awful.key({ mod }, "n", function(c)
		-- The client currently has the input focus, so it cannot be
		-- minimized, since minimized clients can't have the focus.
		c.minimized = true
	end, { description = "minimize", group = "client" }),

	awful.key({ mod }, "m", function(c)
		c.maximized = not c.maximized
		c:raise()
	end, { description = "(un)maximize", group = "client" }),

	awful.key({ mod, "Shift" }, "m", function(c)
		c.maximized_horizontal = not c.maximized_horizontal
		c:raise()
	end, { description = "(un)maximize horizontally", group = "client" }),

	awful.key({ mod, "Control" }, "m", function(c)
		c.maximized_vertical = not c.maximized_vertical
		c:raise()
	end, { description = "(un)maximize vertically", group = "client" })
)

-- TODO: oh look, already tag and screen.
-- also can change position of monitor change to middle like in i3
local function view_tag_and_focus(tag_name, screen_number)
	local old_coords = mouse.coords() -- Save current position
	local old_screen = mouse.screen
	local s = screen[screen_number]
	local tag = awful.tag.find_by_name(s, tag_name)

	if tag then
		tag:view_only()
		client.focus = awful.client.focus.history.get(s, 0)
		if client.focus then
			client.focus:raise()
		end

		if old_screen.index ~= s.index then
			-- Calculate relative position on old screen
			local old_geo = old_screen.geometry
			local rel_x = old_coords.x - old_geo.x
			local rel_y = old_coords.y - old_geo.y

			-- Move mouse to the same relative position on the new screen
			local new_geo = s.geometry
			mouse.coords({
				x = new_geo.x + rel_x,
				y = new_geo.y + rel_y,
			}, true)
		end
	end
end

local function move_client_to_tag(tag_name)
	local target_screen = nil
	local tag = nil
	local i = tonumber(tag_name)

	-- Decide the screen based on tag_name
	if i > 0 and i <= 6 then
		target_screen = screen[1]
	else
		target_screen = screen[2]
	end

	if target_screen then
		tag = awful.tag.find_by_name(target_screen, tag_name)
	end

	if client.focus and tag then
		client.focus:move_to_tag(tag)
	end
end

-- TODO: create a mapping of tag - screen, both text. pass tag and screen to all
-- functions that need to use them.
-- like in the functions above.. why bother with comparisons when you can just
-- use view_tag_and_focus(t, s) - tag-screen and won't need number checks
-- and conversions for string/number
for i = 0, 9 do
	local key = tostring(i)

	globalkeys = gears.table.join(
		globalkeys,
		awful.key({ mod, "Shift" }, key, function()
			if i > 0 and i <= 6 then
				view_tag_and_focus(key, 1)
			else
				view_tag_and_focus(key, 2)
			end
		end),
		awful.key({ mod, "Control" }, key, function()
			move_client_to_tag(key)
		end, { description = "move focused client to tag " .. key, group = "tag" })
	)
end

clientbuttons = gears.table.join(
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	awful.button({ mod }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ mod }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
		},
	},

	-- Floating clients.
	{
		rule_any = {
			instance = {
				"DTA", -- Firefox addon DownThemAll.
				"copyq", -- Includes session name in class.
				"pinentry",
			},
			class = {
				"Arandr",
				"Blueman-manager",
				"Gpick",
				"Kruler",
				"MessageWin", -- kalarm.
				"Sxiv",
				"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
				"Wpa_gui",
				"veromix",
				"xtightvncviewer",
			},

			-- Note that the name property shown in xprop might be set slightly after creation of the client
			-- and the name shown there might not match defined rules here.
			name = {
				"Event Tester", -- xev.
			},
			role = {
				"AlarmWindow", -- Thunderbird's calendar.
				"ConfigManager", -- Thunderbird's about:config.
				"pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
			},
		},
		properties = { floating = true },
	},

	-- Add titlebars to normal clients and dialogs
	{ rule_any = { type = { "normal", "dialog" } }, properties = { titlebars_enabled = false } },

	-- Set Firefox to always map on the tag named "2" on screen 1.
	-- { rule = { class = "Firefox" },
	--   properties = { screen = 1, tag = "2" } },

	{
		rule = { class = "customterm" },
		properties = {
			floating = true,
			width = 620,
			height = 320,
			x = screen[2].geometry.x + screen[2].geometry.width - 620,
			y = 0,
			ontop = true,
		},
	},

	{
		rule = { class = "pavucontrol" },
		properties = {
			width = 900,
			height = 900,
			floating = true,
			ontop = true,
			placement = awful.placement.centered,
		},
	},

	{
		rule = { class = "Viewnior" },
		properties = {
			floating = true,
			ontop = true,
			placement = awful.placement.centered,
		},
	},

	{
		rule = { class = "Thunar" },
		properties = {
			floating = true,
			ontop = true,
			placement = awful.placement.centered,
		},
	},
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	if not awesome.startup then
		awful.client.setslave(c)
	end

	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
	-- buttons for the titlebar
	local buttons = gears.table.join(
		awful.button({}, 1, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.move(c)
		end),
		awful.button({}, 3, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.resize(c)
		end)
	)

	awful.titlebar(c):setup({
		{ -- Left
			awful.titlebar.widget.iconwidget(c),
			buttons = buttons,
			layout = wibox.layout.fixed.horizontal,
		},
		{ -- Middle
			{ -- Title
				align = "center",
				widget = awful.titlebar.widget.titlewidget(c),
			},
			buttons = buttons,
			layout = wibox.layout.flex.horizontal,
		},
		{ -- Right
			awful.titlebar.widget.floatingbutton(c),
			awful.titlebar.widget.maximizedbutton(c),
			awful.titlebar.widget.stickybutton(c),
			awful.titlebar.widget.ontopbutton(c),
			awful.titlebar.widget.closebutton(c),
			layout = wibox.layout.fixed.horizontal(),
		},
		layout = wibox.layout.align.horizontal,
	})
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c)
	c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
end)
-- }}}

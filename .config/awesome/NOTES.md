# taglist underlines

bar png needs to be adjusted for different bar sizes

right now bar = 30px, bar.png = 30-32px with the actual bar ~1-3px

```lua
-- after beautiful.init()
local theme_dir = os.getenv("HOME") .. "/.config/awesome/"
beautiful.taglist_squares_sel = theme_dir .. "bar31.png"
beautiful.taglist_squares_unsel = theme_dir .. "bar31.png"
beautiful.taglist_spacing = 7

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
```


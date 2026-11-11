
hl.layer_rule({
    match = { namespace = 'quickshell' },
    no_anim = true
})

hl.window_rule({
	name = "discord-magic",
	match = { class = "^discord$" },
	workspace = "special:magic silent",
})

hl.window_rule({
	name = "feishin-magic",
	match = { class = "^feishin$" },
	workspace = "special:magic silent",
})

hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = 'suppress-maximize-events',
    match = { class = '.*' },

    suppress_event = 'maximize',
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = 'fix-xwayland-drags',
    match = {
        class      = '^$',
        title      = '^$',
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

hl.window_rule({
    match = {
        class = 'mpv'
    },
    float = true,
    size = { 600, 600 }
})

hl.window_rule({
    match = {
        class = 'imv'
    },
    float = true,
    size = { 600, 600 }
})


hl.window_rule({
    match = {
        class = 'YouTube Music Desktop App'
    },
    float = true,
    size = { 430, 630 }
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = 'move-hyprland-run',
    match = { class = 'hyprland-run' },

    move  = '20 monitor_h-120',
    float = true,
})

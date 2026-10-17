hl.config({
	input = {
		-- kb_layout = "us,us",
		-- kb_variant = ",intl",
		-- kb_options = "grp:alt_shift_toggle",
		kb_layout = "us",
		kb_options = "caps:escape,compose:ralt,shift:both_capslock_cancel",
		kb_model = "",
		kb_rules = "",

		repeat_rate = 40,
		repeat_delay = 250,

		follow_mouse = 1,
		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
		accel_profile = "flat",

		touchpad = {
			natural_scroll = false,
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})

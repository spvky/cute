package main

import "core:fmt"
import "core:strings"
import "vendor:ghst/ui/buttons"
import rl "vendor:raylib"

show_data_menu: bool
data_menu_y_position: Smoothed = {
	value      = 864,
	lerp_value = 864,
	threshhold = 1,
	rate       = 5,
}
button_style: buttons.Button_Style

init_ui :: proc() {
	button_style = buttons.DEFAULT_BUTTON_STYLE
}

handle_data_menu :: proc() {
	data_button := buttons.Button {
		text = "DATA",
		callback = proc() {
			if show_data_menu {
				show_data_menu = false
				data_menu_y_position.value = 500
			} else {
				show_data_menu = true
				data_menu_y_position.value = 864
			}
		},
	}
	buttons.draw_button(data_button, {600, i32(data_menu_y_position.lerp_value)}, button_style)
	rl.DrawRectangle(
		600,
		i32(data_menu_y_position.lerp_value) + button_style.font_size,
		600,
		500,
		button_style.unclicked_color,
	)
	position_text :=
		selected_bug != nil ? fmt.tprintf("Position: [%.f0,%.f0]", selected_bug.position.x, selected_bug.position.y) : fmt.tprintf("Position: ----")
	rl.DrawText(
		strings.clone_to_cstring(position_text, context.temp_allocator),
		620,
		i32(data_menu_y_position.lerp_value) + 72,
		36,
		rl.WHITE,
	)
}

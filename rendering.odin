package main

import "core:math"
import rl "vendor:raylib"

crosshair_rot: f32

render :: proc() {
	frametime := rl.GetFrameTime()
	draw_to_texture(frametime)
	draw_to_screen(frametime)
}

draw_to_texture :: proc(frametime: f32) {
	rl.BeginTextureMode(screen_texture)
	rl.ClearBackground({0, 12, 240, 255})
	pos := cursor_pos()
	render_bugs()
	rl.EndTextureMode()
}

draw_to_screen :: proc(frametime: f32) {
	rl.BeginDrawing()
	rl.ClearBackground(rl.BLACK)
	source := rl.Rectangle {
		x      = 0,
		y      = f32(WINDOW_HEIGHT - SCREEN_HEIGHT),
		width  = f32(SCREEN_WIDTH),
		height = -f32(SCREEN_HEIGHT),
	}
	dest := rl.Rectangle {
		x      = 0,
		y      = 0,
		width  = f32(WINDOW_WIDTH),
		height = f32(WINDOW_HEIGHT),
	}
	origin := Vec2{0, 0}
	rotation: f32 = 0
	rl.DrawTexturePro(screen_texture.texture, source, dest, origin, rotation, rl.WHITE)
	handle_smoothed_value(&data_menu_y_position, frametime)
	handle_data_menu()
	crosshair_rot += 90 * frametime
	pos := rl.GetMousePosition()
	rl.DrawTexturePro(
		crosshair,
		{0, 0, 16, 16},
		{pos.x, pos.y, 32, 32},
		{16, 16},
		crosshair_rot,
		rl.WHITE,
	)
	rl.EndDrawing()
}

package main

import rl "vendor:raylib"

render :: proc() {
	draw_to_texture()
	draw_to_screen()
}

draw_to_texture :: proc() {
	rl.BeginTextureMode(screen_texture)
	rl.ClearBackground({0, 12, 240, 255})
	pos := cursor_pos()
	render_bugs()
	rl.DrawCircleV(pos, 10, rl.RED)
	rl.EndTextureMode()
}

draw_to_screen :: proc() {
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
	rl.EndDrawing()
}

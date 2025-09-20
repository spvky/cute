package main

import "core:strings"
import "utils"
import rl "vendor:raylib"

Vec2 :: [2]f32
Vec3 :: [3]f32

load_texture :: proc(filename: string) -> rl.Texture {
	when ODIN_OS == .JS {
		return utils.load_texture(filename)
	}
	return rl.LoadTexture(strings.clone_to_cstring(filename))
}

cursor_pos :: proc() -> Vec2 {
	ratio := f32(WINDOW_WIDTH) / SCREEN_WIDTH
	return rl.GetMousePosition() / ratio
}

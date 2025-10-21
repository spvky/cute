package main

import "core:math"
import "core:strings"
import "utils"
import rl "vendor:raylib"

Vec2 :: [2]f32
Vec3 :: [3]f32
Smoothed :: struct {
	value:      f32,
	lerp_value: f32,
	threshhold: f32,
	rate:       f32,
}

handle_smoothed_value :: proc(s: ^Smoothed, delta: f32) {
	if math.abs(s.value - s.lerp_value) < s.threshhold {
		s.lerp_value = s.value
	} else {
		s.lerp_value = math.lerp(s.lerp_value, s.value, s.rate * delta)
	}
}

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

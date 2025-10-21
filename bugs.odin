package main

import "core:fmt"
import l "core:math/linalg"
import "core:math/rand"
import rl "vendor:raylib"

selected_bug: ^Bug

Bug :: struct {
	position:         Vec2,
	velocity:         Vec2,
	move_delta:       Vec2,
	max_speed:        f32,
	radius:           f32,
	detection_radius: f32,
	state:            Bug_State,
	decision_timer:   f32,
	selected:         bool,
}


Bug_State :: enum {
	Wander,
	Follow,
}

make_bugs :: proc(amount: int = 32) -> [dynamic]Bug {
	bugs_collection := make([dynamic]Bug, 0, amount)
	for i in 0 ..< amount {
		x_pos := rand.float32() * SCREEN_WIDTH
		y_pos := rand.float32() * SCREEN_HEIGHT
		append(&bugs_collection, Bug{position = {x_pos, y_pos}, radius = 5})
	}
	return bugs_collection
}

unselect_bugs :: proc() {
	for &b in bugs {
		b.selected = false
	}
}


handle_bug_wander :: proc() {
	frametime := rl.GetFrameTime()
	for &b in bugs {
		if b.state == .Wander {
			b.decision_timer -= frametime
			if b.decision_timer < 0 {
				behavior := rand.float32()
				time := rand.float32()
				if behavior < 0.333 {
					b.move_delta = Vec2{0, 0}
					b.decision_timer = (time * 0.5) + 0.15
				} else {
					x_pos := rand.float32() * SCREEN_WIDTH
					y_pos := rand.float32() * SCREEN_HEIGHT
					b.max_speed = (rand.float32() * 30) + 5
					b.move_delta = l.normalize0(Vec2{x_pos, y_pos} - b.position)
					b.decision_timer = (time * 1.5) + 0.15
				}
			}
		}
	}
}

handle_bug_movement :: proc() {
	frametime := rl.GetFrameTime()
	for &b in bugs {
		if l.length2(b.move_delta) != 0 {
			if l.length(b.velocity) < b.max_speed {
				b.velocity += b.move_delta * 0.1 * b.max_speed
			}
			b.velocity = 0.98 * b.velocity
		}
		b.position += b.velocity * frametime
	}
}

render_bugs :: proc() {
	for b in bugs {
		if b.selected {
			rl.DrawCircleV(b.position, b.radius * 1.25, rl.RED)
		}
		rl.DrawCircleV(b.position, b.radius, rl.WHITE)
	}
}

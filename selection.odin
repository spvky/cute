package main

import "core:fmt"
import l "core:math/linalg"
import rl "vendor:raylib"

select :: proc() {
	if rl.IsMouseButtonPressed(.LEFT) {
		cursor := cursor_pos()
		for &b in bugs {
			if l.distance(cursor, b.position) < b.radius {
				if selected_bug != nil {
					selected_bug.selected = false
				}
				selected_bug = &b
				b.selected = true
				break
			}
		}
	}

}

package main

import rl "vendor:raylib"

crosshair: rl.Texture

load_textures :: proc() {
	crosshair = rl.LoadTexture("assets/textures/crosshair.png")
}

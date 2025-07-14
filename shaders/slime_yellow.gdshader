shader_type canvas_item;


void fragment() {
	if(COLOR.g > 0.6){
		COLOR = vec4(COLOR.r + 0.2, COLOR.g - 0.1, 0.0, COLOR.a);
	}
}


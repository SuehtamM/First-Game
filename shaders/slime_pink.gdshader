shader_type canvas_item;


void fragment() {
	if(COLOR.g > 0.6){
		COLOR = vec4(COLOR.r+0.2, 0.0, COLOR.b+0.5, COLOR.a);
		
	}
}


shader_type canvas_item;


void fragment() {
	if(COLOR.g > 0.1){
		COLOR = vec4(COLOR.r -0.4, COLOR.g - 0.1, COLOR.b + 0.9, COLOR.a);
	}
}
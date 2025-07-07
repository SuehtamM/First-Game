extends StaticBody2D

enum Block_Color {GRAY, ORANGE, BROWN, YELLOW}

@export var block_color : Block_Color
var gray_action_block_sprite := Rect2(128.0, 16.0, 16.0, 16.0)
var orange_action_block_sprite := Rect2(16.0, 16.0, 16.0, 16.0)
var brown_action_block_sprite := Rect2(80.0, 16.0, 16.0, 16.0)
var yellow_action_block_sprite := Rect2(48.0, 16.0, 16.0, 16.0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.region_enabled = true
	match block_color:
		Block_Color.GRAY:
			$Sprite2D.region_rect = gray_action_block_sprite
		Block_Color.ORANGE:
			$Sprite2D.region_rect = orange_action_block_sprite
		Block_Color.BROWN:
			$Sprite2D.region_rect = brown_action_block_sprite
		Block_Color.YELLOW:
			$Sprite2D.region_rect = yellow_action_block_sprite

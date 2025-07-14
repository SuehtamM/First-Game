extends Node2D

var left_camera_limit : int = -490
var bottom_camera_limit : int = 80
var right_camera_limit : int = 7328

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player/Camera2D.limit_bottom = bottom_camera_limit
	$Player/Camera2D.limit_left = left_camera_limit
	$Player/Camera2D.limit_right = right_camera_limit

func _on_action_block_action() -> void:
	$ActionBlock/AltPathActivated.play()
	for block in $TempBlocks.get_children():
		block.queue_free()

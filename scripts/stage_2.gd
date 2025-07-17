extends Node2D

var left_camera_limit : int = -490
var bottom_camera_limit : int = 80
var right_camera_limit : int = 7328

signal end_stage
signal power_up_picked

func _on_action_block_action() -> void:
	$ActionBlock/AltPathActivated.play()
	for block in $TempBlocks.get_children():
		block.queue_free()


func _on_end_stage_body_entered(body: Node2D) -> void:
	end_stage.emit()


func _on_body_entered(body: Node2D) -> void:
	power_up_picked.emit()

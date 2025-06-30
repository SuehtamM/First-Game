extends Area2D

signal show_message

func _on_body_entered(body: Node2D) -> void:
	self.global_position[1] -= 5
	await get_tree().create_timer(0.1).timeout
	self.global_position[1] += 5
	show_message.emit()

extends Area2D

signal game_state_off

func _on_body_entered(body: Node2D) -> void:
	$Timer.start()

func _on_timer_timeout() -> void:
	$GameOver.visible = true
	game_state_off.emit()

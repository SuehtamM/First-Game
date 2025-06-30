extends Node

func _ready() -> void:
	$LabelEnemies.text = ""

func _on_block_show_message() -> void:
	$LabelEnemies.text = "Cuidado com os inimigos...\nAcerte-os na cabeça!"

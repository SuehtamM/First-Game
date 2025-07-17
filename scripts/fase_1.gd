extends Node

var enemies_dead : int
var bonus_area_available : bool = false
var total_coins : int = 122
var coins_collected : int
signal end_stage

func _process(delta: float) -> void:
	if enemies_dead == 7 and not bonus_area_available:
		bonus_area_available = true
		$Platform/BonusPlatform/AnimationPlayerBonus.play("bonus")
		$Platform/BonusPlatform/BonusSound.play()

func _on_slime_slime_dead() -> void:
	enemies_dead += 1


func _on_slime_2_slime_dead() -> void:
	enemies_dead += 1


func _on_slime_3_slime_dead() -> void:
	enemies_dead += 1


func _on_slime_4_slime_dead() -> void:
	enemies_dead += 1


func _on_slime_5_slime_dead() -> void:
	enemies_dead += 1


func _on_slime_6_slime_dead() -> void:
	enemies_dead += 1


func _on_slime_7_slime_dead() -> void:
	enemies_dead += 1


func _on_end_stage_body_entered(body: Node2D) -> void:
	end_stage.emit()

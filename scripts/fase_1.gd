extends Node

var enemies_dead : int
var bonus_area_available : bool = false
var total_coins : int = 122
var coins_collected : int
var left_camera_limit = - 1085
var bottom_camera_limit = 65
var right_camera_limit = 4000

func _ready() -> void:
	$Player/Camera2D.limit_left = left_camera_limit
	$Player/Camera2D.limit_bottom = bottom_camera_limit
	$Player/Camera2D.limit_right = right_camera_limit

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

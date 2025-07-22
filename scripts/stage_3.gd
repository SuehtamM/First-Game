extends Node2D

var factor : float
var end : bool = false
signal end_stage
signal disable_camera_player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Slime.speed = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $CameraStage.enabled and not end:
		$CameraStage.position.x += 0.5

func _on_slime_wall_1_body_entered(body: Node2D) -> void:
	$Slime.speed = 150
	factor = randf()
	if factor > 0.0:
		$Slime.speed = 150 * (1 + factor)


func _on_slime_wall_2_body_entered(body: Node2D) -> void:
	$Slime.speed = 150
	factor = randf()
	if factor > 0.0:
		$Slime.speed = 150 * (1 + factor)


func _on_area_change_cameras_body_entered(body: Node2D) -> void:
	$CameraStage.enabled = true
	disable_camera_player.emit()
	$Slime.speed = 150
	$Slime/RayCastLeft.collide_with_areas = true
	$Slime/RayCastRight.collide_with_areas = true


func _on_slime_slime_dead() -> void:
	end = true
	end_stage.emit()


func _on_music_finished() -> void:
	$music.play()

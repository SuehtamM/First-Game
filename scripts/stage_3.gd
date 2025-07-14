extends Node2D

var factor : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player/Camera2D.limit_left = -560
	$Slime.speed = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $CameraStage.enabled:
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
	$Player/Camera2D.enabled = false
	$CameraStage.enabled = true
	
	$Slime.speed = 150
	$Slime/RayCastLeft.collide_with_areas = true
	$Slime/RayCastRight.collide_with_areas = true

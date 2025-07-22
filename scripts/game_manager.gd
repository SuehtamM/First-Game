extends Node

enum Stages {STAGE1, STAGE2, STAGE3, END}

var left_camera_limit : int
var bottom_camera_limit : int
var right_camera_limit : int

var stage1 : PackedScene = preload("res://scenes/stage_1.tscn")
var stage2 : PackedScene = preload("res://scenes/stage_2.tscn")
var stage3 : PackedScene = preload("res://scenes/stage_3.tscn")

func _ready() -> void:
	$Stages.add_child(stage1.instantiate())
	$Stages/fase_1.end_stage.connect(_on_end_stage_1)
	
	$Player.global_position = Vector2(-1000, -100)
	$Player/Camera2D.limit_left = -1085
	$Player/Camera2D.limit_bottom = 64
	$Player/Camera2D.limit_right = 4000

func change_stage(stage : Stages) -> void:
	if stage == Stages.STAGE1:
		$Stages.add_child(stage1.instantiate())
		$Stages/fase_1.end_stage.connect(_on_end_stage_1)
		
		$Player.global_position = Vector2(-1000, -100)
		$Player/Camera2D.limit_left = -1085
		$Player/Camera2D.limit_bottom = 64
		$Player/Camera2D.limit_right = 4000
		
	
	elif stage == Stages.STAGE2:
		$Stages.add_child(stage2.instantiate())
		$Stages/fase_2.end_stage.connect(_on_end_stage_2)
		
		$Player.global_position = Vector2(-456, -104)
		$Player/Camera2D.limit_left = -490
		$Player/Camera2D.limit_bottom = 80
		$Player/Camera2D.limit_right = 7328
		$Player/Snow.visible = true
		
		$Stages/fase_2.power_up_picked.connect(_on_pickup_power_up)
		
	elif stage == Stages.STAGE3:
		$Stages.add_child(stage3.instantiate())
		
		$Stages/Stage3.end_stage.connect(_on_end_stage_3)
		$Stages/Stage3.disable_camera_player.connect(_on_disable_camera_player)
		
		$Player.global_position = Vector2(-2272, -1992)
		$Player/Camera2D.limit_left = -2344
		$Player/Camera2D.limit_bottom = 56
		$Player/Camera2D.limit_right = 12120
		
	elif stage == Stages.END:
		$Player/FinishGame.visible = true
		

func _on_end_stage_1() -> void:
	change_stage(Stages.STAGE2)
	$Stages/fase_1.queue_free()
	
func _on_end_stage_2() -> void:
	change_stage(Stages.STAGE3)
	$Stages/fase_2.queue_free()
	$Player/Snow.visible = false
	
func _on_end_stage_3() -> void:
	change_stage(Stages.END)
	
func _on_pickup_power_up() -> void:
	$Player.maxjumps = 1
	$Player/PowerUpReceived.play()
	$Stages/fase_2/DoubleJumpItem/Explosion.emitting = true
	await get_tree().create_timer(0.3).timeout
	$Stages/fase_2/DoubleJumpItem.queue_free()
	
func _on_disable_camera_player() -> void:
	$Player/Camera2D.enabled = false
	$Stages/Stage3/music.playing = true

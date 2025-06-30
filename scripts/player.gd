extends CharacterBody2D

const SPEED : float = 100.0
const DASH_SPEED : float = 400.0
const SPEED_RUNNING : int = 150
const JUMP_VELOCITY : float = -300.0

@export var health : int = 3
@export var can_dash : bool = false
@export var maxjumps : int = 0 # quantidade máxima de pulos seguidos
var jumps : int = 0 
var dashing : bool = false
var dashes : int = 0
var damaged : bool = false
var game_over : bool = false

func _on_timer_dash_timeout() -> void:
	dashing = false

func _on_timer_can_dash_timeout() -> void:
	can_dash = true

func _physics_process(delta: float) -> void:
	# direction vale 1 para movimento pra direita e -1 pra esquerda (por causa da ordem)
	if game_over:
		return
	
	if health <= 0:
		$AnimatedSprite2D.play("death")
		await get_tree().create_timer(1.2).timeout
		game_over = true
		$GameOver.visible = true
		return
	
	var direction : float = Input.get_axis("move_left", "move_right")
	
	# Adiciona gravidade
	if not is_on_floor():
		velocity += get_gravity() * delta

	## inputs
	
	# pulo
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("jump") and not is_on_floor() and jumps < maxjumps:
		velocity.y = JUMP_VELOCITY
		jumps += 1
	
	# dash
	if Input.is_action_just_pressed("dash") and can_dash and dashes == 0:
		dashes += 1
		dashing = true
		can_dash = false
		$Timer_dash.start()
		$Timer_can_dash.start()
	
	## Propriedades do player
	
	# sprite acompanhando a direção do movimento
	if direction > 0: # se estiver andando pra direita
		$AnimatedSprite2D.flip_h = false # nao espelha o sprite
	elif direction < 0:
		$AnimatedSprite2D.flip_h = true
	
	# velocidade do movimento
	if direction:
		if Input.is_action_pressed("run_fast"):
			velocity.x = direction * SPEED_RUNNING
		elif dashing:
			velocity.x = direction * DASH_SPEED
		else:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# muda as animações do player
	if is_on_floor() and not damaged:
		jumps = 0
		dashes = 0
		if direction == 0:
			$AnimatedSprite2D.play("idle")
		else:
			$AnimatedSprite2D.play("run")
	elif not is_on_floor() and jumps > 0:
		$AnimatedSprite2D.play("second_jump")
	elif damaged:
		$AnimatedSprite2D.visible = not $AnimatedSprite2D.visible
	else:
		$AnimatedSprite2D.play("jump")
	
	# resetar o game quando apertar \
	if Input.is_action_just_pressed("reset game"):
		get_tree().reload_current_scene()
	
	move_and_slide()

func _on_hurt_box_area_entered(area: Area2D) -> void:
	if not damaged:
		health -= 1
		$Timer_damage.start()
		damaged = true

func _on_timer_damage_timeout() -> void:
	damaged = false
	$AnimatedSprite2D.visible = true

func _on_hit_box_area_entered(area: Area2D) -> void:
	if health > 1:
		velocity.y = JUMP_VELOCITY

func _on_killzone_game_state_off() -> void:
	game_over = true

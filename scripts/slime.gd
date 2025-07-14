extends CharacterBody2D

enum Cor{GREEN, BLUE, YELLOW}

signal slime_dead

@export var speed : int = 60
@export var health : int = 2
@export var direction : int = 1
@export var color : Cor
var sprite : AnimatedSprite2D

var hit : bool = false
var dead : bool = false

func _ready() -> void:
	if(color == Cor.BLUE ):
		$AnimatedSpriteBlue.visible = true
		$AnimatedSpriteGreen.visible = false
		sprite = $AnimatedSpriteBlue
		
	elif (color == Cor.YELLOW):
		$AnimatedSpriteYellow.visible = true
		$AnimatedSpriteGreen.visible = false
		sprite = $AnimatedSpriteYellow
		
	else:
		sprite = $AnimatedSpriteGreen
		
	if direction == -1:
		sprite.flip_h = true

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if health <= 0:
		$HitBox.monitorable = false
		$HitBox.monitoring = false
		$CollisionShape2D.disabled = true
		sprite.play("death")
		await get_tree().create_timer(0.7).timeout
		queue_free()
		slime_dead.emit()
		return
	
	# Raycast parede
	if $RayCastRight.is_colliding():
		direction = -1
		sprite.flip_h = true
	elif $RayCastLeft.is_colliding():
		direction = 1
		sprite.flip_h = false
	
	if not $RayCastFloorRight.is_colliding():
		direction = -1
		sprite.flip_h = true
	elif not $RayCastFloorLeft.is_colliding():
		direction = 1
		sprite.flip_h = false
	
	if not hit:
		position.x += direction * speed * delta
	else:
		sprite.play("damage")
		
	move_and_slide()

func _on_hurt_box_area_entered(area: Area2D) -> void:
	if not hit:
		$TimerDamage.start()
		health -= 1
		hit = true
		$Tap.play()

func _on_timer_damage_timeout() -> void:
	sprite.play("walk")
	hit = false

extends CharacterBody2D


const SPEED = 120.0
const JUMP_VELOCITY = -280.0

#Reference to the sprite
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	#Gravity: only fall when we're in the air
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump: only from the ground
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	#Direction Input for left(-1) and right(1)
	var direction := Input.get_axis("move_left", "move_right")
	
	#Face the direction we're moving
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	#Pick the animation based on what the player is doing
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()

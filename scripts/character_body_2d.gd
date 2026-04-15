extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -400.0
var is_attacking = false 
@onready var _animated_sprite = $AnimatedSprite2D



func _physics_process(delta: float) -> void:
	# Add the gravity.	
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	# make sure to flip the sprite here if going left/right
	if Input.is_action_just_pressed("attack"):
		is_attacking = true
		_animated_sprite.play("attack")
	elif direction != 0 and !is_attacking:
		_animated_sprite.play("run")	
		_animated_sprite.flip_h = direction < 0
	elif !is_attacking:
		_animated_sprite.play("idle")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_sword_hit_area_entered(area: Area2D) -> void:
	pass # Replace with function body.

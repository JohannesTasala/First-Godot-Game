extends CharacterBody2D

signal  fired_shot

var SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = get_node("AnimationPlayer")

@onready var ray:=$Gun/ShootRay

var is_crouching = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("Jump")
		
	if Input.is_action_pressed("down") and is_on_floor():
		is_crouching = true
		anim.play("Crouch")
		SPEED = 100
	else :
		is_crouching = false
		SPEED = 300
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = true
	elif direction == 1:
			get_node("AnimatedSprite2D").flip_h = false
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0 and is_crouching == false:
			anim.play("Run")
		elif velocity.y == 0 and is_crouching == true:
			anim.play("Crouch")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0 and is_crouching == false:
			anim.play("Idle")
		elif velocity.y == 0 and is_crouching == true:
			anim.play("Crouch")
		
		
	if velocity.y > 0:
		anim.play("Fall")
		
	
		
	

	move_and_slide()
	
	if Game.playerHP <= 0:
		queue_free()
		get_tree().change_scene_to_file("res://main.tscn")
		
		
func _unhandled_input(event):
	if event.is_action_pressed("shoot") and ray.is_colliding():
		emit_signal("fired_shot", ray.get_collision_point())
		var target = ray.get_collider()
		print("shoot")
		print(target)
		

extends CharacterBody2D

var SPEED = 100
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var chase = false

func _ready():
	get_node("AnimatedSprite2D").play("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Gravity for Reaper
	velocity.y += gravity * delta
	if chase == true:
		get_node("AnimatedSprite2D").play("Run")
		player = get_node("../../Player/Player")
		var direction = (player.position - self.position).normalized()
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = false
			velocity.x = direction.x * SPEED
		else:
			get_node("AnimatedSprite2D").flip_h = true
			velocity.x = direction.x * SPEED
	else:
		get_node("AnimatedSprite2D").play("Idle")
		velocity.x = 0
	move_and_slide()


func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true


func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false

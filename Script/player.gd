extends CharacterBody2D

@onready var playerSprite = $AnimatedSprite2D
@export var moveSpeed: float
@export var jumpSpeed: float
var isFacingRigth: bool = true
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	
	moveX()
	jump(delta)
	flip()
	updateAnimation()
	
	move_and_slide()

func updateAnimation():
	if is_on_floor():
		if velocity.x:
			playerSprite.play("run")
		else:
			playerSprite.play("idle")
	elif !is_on_floor():
		playerSprite.play("jump")

func moveX():
	var direction = Input.get_axis("move_left","move_right")
	if direction:
		velocity.x = direction * moveSpeed
	else:
		velocity.x = move_toward(velocity.x, 0, moveSpeed)
	
func jump(delta) -> void:
	if (Input.is_action_just_pressed("jump") and is_on_floor()):
		velocity.y = jumpSpeed
		
	if !is_on_floor():	
		velocity.y += (gravity * delta)*2
		
func flip():
	if (isFacingRigth and velocity.x < 0) or (!isFacingRigth and velocity.x > 0):
		playerSprite.scale.x *= -1
		isFacingRigth = !isFacingRigth

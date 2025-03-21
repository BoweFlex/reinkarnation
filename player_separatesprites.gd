extends CharacterBody2D

@export var run_speed = 50.0
@export var jump_velocity = 300
@export var max_fall_velocity = 350
var gravity: int = ProjectSettings.get("physics/2d/default_gravity")
var screen_size

func _ready() -> void:
	screen_size = get_viewport_rect().size
	position.x = screen_size.x / 4
	position.y = screen_size.y / 2
	$Standing.show()
	$Crouching.hide()
	$Hitbox_Standing.show()
	$Hitbox_Crouching.hide()
	
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("crouch"):
		$Standing.hide()
		$Crouching.show()
		$Hitbox_Standing.hide()
		$Hitbox_Crouching.show()
	else:
		$Standing.show()
		$Crouching.hide()
		$Hitbox_Standing.show()
		$Hitbox_Crouching.hide()
	if Input.is_action_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_velocity
	velocity.y = minf(max_fall_velocity, velocity.y + gravity * delta)
	var direction = Input.get_axis("move_left" + "", "move_right" + "") * run_speed
	velocity.x = move_toward(velocity.x, direction, 1000 * delta)
	
	move_and_slide()

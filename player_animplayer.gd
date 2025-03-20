extends CharacterBody2D # CharacterBody2D and/or CollisionPolygon2D may be better choices here

@export var run_speed = 50.0
@export var jump_velocity = 300
@export var max_fall_velocity = 350
var gravity: int = ProjectSettings.get("physics/2d/default_gravity")
var screen_size

func _ready() -> void:
	screen_size = get_viewport_rect().size


func _physics_process(delta: float) -> void:
	print(is_on_floor())
	if Input.is_action_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_velocity
	velocity.y = minf(max_fall_velocity, velocity.y + gravity * delta)
	var direction = Input.get_axis("move_left" + "", "move_right" + "") * run_speed
	velocity.x = move_toward(velocity.x, direction, 1000 * delta)
	
	if not is_zero_approx(velocity.x):
		$AnimationPlayer.play("run")
	else:
		$AnimationPlayer.stop()
	move_and_slide()

#func _process(delta: float) -> void:
	#pass
	#var velocity = Vector2.ZERO
	#if Input.is_action_pressed("jump"):
		## I'm not really sure what to do here yet - it could change sprite and/or hitbox but not positive yet
		## how to make a standard jump rather than floaty.
		#pass
	#if Input.is_action_pressed("crouch"):
		## I *think* in the current POC, Sprite2D should have two different Texture2Ds, one at square size and one at a half height size
		## this if block would then emit a signal that triggers Sprite2D to swap to the half height Texture.
		## Alternatively, Sprite2D could be replaced with an AnimatedSprite2D with just one frame per action, which would allow us to switch between the actions (this is honestly probably the same as described above, just not manual)
		## More importantly, CollisionShape would also need to change (I believe this can be done through an AnimatedSprite),
		## and run_speed should be cut in half.
		#pass
	#if Input.is_action_pressed("move_left"):
		#velocity.x -= 1
	#if Input.is_action_pressed("move_right"):
		#velocity.x += 1
	#if velocity.length() != 0:
		#velocity = velocity.normalized() * run_speed
	#position += velocity * delta
	#position.clamp(Vector2.ZERO, screen_size) # Ensure we're not moving off the screen

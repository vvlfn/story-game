extends CharacterBody3D

@onready var animation = $AnimationPlayer
@export var _camera: Camera3D

var JUMP_STRENGTH: float = 5.0
var SPEED: float = 5.0
func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	_camera.global_position = $CameraCenter/CameraPos.global_position
	_camera.look_at($CameraCenter.global_position)
	
	var movementInput: Vector2 = Input.get_vector("walk_left", "walk_right","walk_forward", "walk_back")
	var moveDirection: Vector3 = (transform.basis * Vector3(movementInput.x, 0, movementInput.y)).normalized()
	#var turnDirection: float = movementInput.x
	
	
	if moveDirection:
		velocity.x = moveDirection.x * SPEED * delta * 60
		velocity.z = moveDirection.z * SPEED * delta * 60
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		print("test")
		velocity.y = JUMP_STRENGTH
	
	
	if velocity and is_on_floor():
		animation.play("walk")
	else:
		animation.stop()
		
	print(is_on_floor())
	move_and_slide()

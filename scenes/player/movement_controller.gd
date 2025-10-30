extends CharacterBody3D

@onready var animation = $AnimationPlayer
@export var _camera: Camera3D

var JUMP_STRENGTH: float = 300.0


var SPEED: float = 2.0
func _ready() -> void:
	pass
	
func _physics_process(_delta: float) -> void:
	if !is_on_floor():
		velocity += get_gravity()
	
	_camera.global_position = $CameraCenter/CameraPos.global_position
	_camera.look_at($CameraCenter.global_position)
	
	var movementInput: Vector2 = Input.get_vector("walk_left", "walk_right","walk_forward", "walk_back")
	var moveDirection: Vector3 = (transform.basis * Vector3(movementInput.x, 0, movementInput.y)).normalized()
	#var turnDirection: float = movementInput.x
	
	velocity = moveDirection * SPEED
	
	if Input.is_action_pressed("jump") and is_on_floor():
		print("test")
		velocity.y += JUMP_STRENGTH
	
	#rotation_degrees.y -= turnDirection * 3
	if velocity:
		animation.play("walk")
		#rotation.y = atan2(-direction.x, -dire-ction.z)
	else:
		animation.stop()
		
	
	move_and_slide()
	

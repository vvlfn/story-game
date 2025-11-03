extends CharacterBody3D

@onready var animation = $AnimationPlayer
@export var _camera: Camera3D


@onready var _Skeleton3D: Skeleton3D = $Armature/Skeleton3D

var canInteract: bool = false
var JUMP_STRENGTH: float = 5.0
var SPEED: float = 5.0


var t: float = 0

func _ready() -> void:
	setPlayerColor(Color(0.734, 0.024, 0.65, 1.0))
	#setPlayerColor(Color(0.5,0.5,0.5))
	
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
		velocity.y = JUMP_STRENGTH
		
	if Input.is_action_just_pressed("interact") and canInteract:
		UI.startDialog()
	
	
	if velocity and is_on_floor():
		animation.play("walk")
		setPlayerColor(Color(0.542, 0.835, 1.0, 1.0))
	else:
		animation.stop()
		setPlayerColor(Color(0.734, 0.024, 0.65, 1.0))
		
		
	move_and_slide()


func setPlayerColor(color: Color) -> void:
	_Skeleton3D.get_child(0).mesh.surface_get_material(0).set("shader_parameter/baseColor", color)

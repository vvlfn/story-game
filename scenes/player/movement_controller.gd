extends CharacterBody3D

@onready var animation = $AnimationPlayer
@export var _camera: Camera3D

var SPEED: float = 2.0
func _ready() -> void:
	pass
	
func _process(_delta: float) -> void:
	var movementInput: Vector2 = Input.get_vector("walk_left", "walk_right", "walk_forward", "walk_back")
	#var headingDirection: Vector3 = (transform.basis.z)
	var direction: Vector3 = (Vector3(movementInput.x, 0, movementInput.y)).normalized()
	velocity = direction * SPEED
	if velocity:
		animation.play("walk")
		rotation.y = atan2(-direction.x, -direction.z)
	else:
		animation.stop()
	
	move_and_slide()
	

extends Node3D

@onready var root: CharacterBody3D = get_parent()
var SENSITIVITY: Vector2 = Vector2(300, 300)

func _ready() -> void:
	pass
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta: float) -> void:
	var turnInput: Vector2 = Input.get_vector("look_left","look_right", "look_up","look_down")
	root.rotation.y -= turnInput.x / 100 * SENSITIVITY.x * delta
	var newCameraPos: float = $CameraPos.position.y - (turnInput.y / 100 * SENSITIVITY.y) * delta
	$CameraPos.position.y = clampf(newCameraPos, 0, 3) 
		

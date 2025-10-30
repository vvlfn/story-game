extends Node3D

@onready var root: CharacterBody3D = get_parent()

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(_delta: float) -> void:
	var turnInput: Vector2 = Input.get_vector("look_left","look_right", "look_up","look_down")
	root.rotation.y -= turnInput.x / 25
	var newCameraPos: float = $CameraPos.position.y - turnInput.y / 25
	$CameraPos.position.y = clampf(newCameraPos, 0, 3) 
		

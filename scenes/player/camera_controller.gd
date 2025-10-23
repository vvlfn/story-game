extends Node3D

@onready var root: CharacterBody3D = get_parent()
@onready var camera: Camera3D = root._camera
@onready var cameraPos = $CameraPos

var SENS: Vector2 = Vector2(75, 75)

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(_delta: float) -> void:
	camera.global_position = cameraPos.global_position
	camera.look_at(global_position)
	
	var cameraInput: Vector2 = Input.get_vector("look_left", "look_right", "look_up", "look_down")
	rotation_degrees.y += cameraInput.x * SENS.x / 50
	rotation_degrees.x += cameraInput.y * SENS.y / 50
	print(rotation_degrees.x)
	#rotation_degrees.x = clampf(rotation_degrees.x, -15, -80)

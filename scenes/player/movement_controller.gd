extends CharacterBody3D

@onready var animation = $AnimationPlayer
@onready var cameraCenter = $CameraCenter
@onready var cameraPos = $CameraCenter/CameraPos

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	var movementInput: Vector2 = Input.get_vector("move_left", "move_right", "move_foward", "move_back")
	

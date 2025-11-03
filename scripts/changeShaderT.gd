extends Node

var t: float = 0

	
func _physics_process(delta: float) -> void:
	t+=delta
	if t>3:
		t = 0
	updateShaderT()

func updateShaderT() -> void:
	for child: MeshInstance3D in $Skeleton3D.get_children():
		for id in range(child.mesh.get_surface_count()):
			child.mesh.surface_get_material(id).set("shader_parameter/t", t)

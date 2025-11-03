extends Node3D

var bodyMaterial: Material = load('res://scenes/npc/materials/body.tres')
var screenMaterial: Material = load('res://scenes/npc/materials/screen.tres')


var t: float = 0
func _physics_process(delta: float) -> void:
	t+= delta
	if t>3:
		t = 0
	updateShaderT()
	
func updateShaderT() -> void:
	for child: MeshInstance3D in $Armature/Skeleton3D.get_children():
		child.mesh.surface_get_material(0).set("shader_parameter/t", t)
		if child.mesh.get_surface_count() == 2:
			child.mesh.surface_get_material(1).set("shader_parameter/t", t)
	#_Skeleton3D.get_child(0).mesh.surface_get_material(0).set("shader_parameter/t", t)

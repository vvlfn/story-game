extends CSGCombiner3D

@export var material: StandardMaterial3D

func _ready() -> void:
	#set('material', material)
	for child in get_children():
		#print(child.get_property_list())
		child.set('material', material)

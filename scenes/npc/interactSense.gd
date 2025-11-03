extends Area3D

@export var dialog: String = "dialog1"

func _on_area_entered(area: Area3D) -> void:
	UI.showInteract()
	UI.setDialog(dialog)
	area.get_parent().canInteract = true

func _on_area_exited(area: Area3D) -> void:
	UI.hideInteract()
	area.get_parent().canInteract = false

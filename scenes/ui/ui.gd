extends Control

@onready var textDisplay: RichTextLabel = $MarginContainer/VBoxContainer/RichTextLabel
@onready var interactLabel: Label = $MarginContainer/VBoxContainer/interact
var dialogData: Dictionary
var dialogPath: String = ""

var dialogLength: int = 0
var currentLine: int = 0
var dialogOn: bool = false

var textIndex: int = 0
var textFormatted: String = ""

var displayFinished: bool = false
var timer: float = 0.0
func setDialog(dialog: String):
	dialogPath = "res://dialogs/" + dialog + ".json"

func _ready() -> void:
	textDisplay.text = ""
	interactLabel.hide()

func _process(delta: float) -> void:
	if dialogOn:
		var content: Array = dialogData.get("dialog")
		var text: String = content[currentLine].get("sender") + ": " + content[currentLine].get("content")
		timer += delta
		if timer > 0.05:
			timer = 0
			if textIndex < len(text):
				textFormatted += text[textIndex]
			else:
				displayFinished = true
			textIndex += 1
		textDisplay.text = textFormatted

func loadDataFromFile(path: String):
	var fileString = FileAccess.get_file_as_string(path)
	var jsonData
	if fileString != null:
		jsonData = JSON.parse_string(fileString)
	dialogData = jsonData
	dialogLength = len(jsonData.get("dialog"))

func showInteract():
	interactLabel.show()
	
func hideInteract():
	interactLabel.hide()
	
func startDialog():
	if not dialogOn:
		loadDataFromFile(dialogPath)
		dialogOn = true
	else:
		if currentLine >= dialogLength -1:
			endDialog()
		else:
			if displayFinished:
				currentLine += 1
				textFormatted = ""
				textIndex = 0
				displayFinished = false
		
func endDialog():
	dialogOn = false
	textDisplay.text = ""
	textFormatted = ""
	dialogData = {}
	currentLine = 0
	dialogLength = 0
	textIndex = 0

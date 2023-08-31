extends Panel
@onready var container = $ScrollContainer/VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

func _show(s: bool = false):
	if s:
		show()
	for l in container.get_children():
		if l.name != "Label_base":
			l.queue_free()
	
	for i in CreditManager.credits:
		var label = $ScrollContainer/VBoxContainer/Label_base.duplicate()
		label.text = str(i.index, ". ", i.name, "(", i.licence, ") ", " by:" , i.author, ", link: ", i.link)
		label.show()
		container.add_child(label)
	
	var note_label = $ScrollContainer/VBoxContainer/Label_base.duplicate()
	note_label.text = str("Hello, I am glad to prensent you my first game. Enjoy it.")
	note_label.show()
	container.add_child(note_label)

func _on_button_close_pressed():
	for l in container.get_children():
		if l.name != "Label_base":
			l.queue_free()
	hide()
	pass # Replace with function body.

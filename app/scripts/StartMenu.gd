extends Control

var study = preload("res://Translate.tscn").instance()

onready var clicksound = $ClickSound

func _on_ExitButton_pressed():
	clicksound.play()
	yield(get_tree().create_timer(0.05), "timeout")
	study.free()
	get_tree().quit()

func _on_OptionsButton_pressed():
	yield(get_tree().create_timer(0.05), "timeout")
	clicksound.play()

func _on_StudyButton_pressed():
	clicksound.play()
	yield(get_tree().create_timer(0.05), "timeout")
	queue_free()
	get_tree().get_root().add_child(study)

func _on_VocabularyButton_pressed():
	clicksound.play()
	yield(get_tree().create_timer(0.05), "timeout")

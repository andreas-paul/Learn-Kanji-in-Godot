extends Control

onready var jlpt5 = _base.jlpt5
onready var keys = jlpt5.keys()
onready var word

var ReadingScene = preload("res://Reading.tscn")
var state

# Variable to count tries that turned out wrong
var tries = 0

signal correct_translation
signal wrong_translation

enum {
	WAIT
}


func _ready():	
	_generate_kanji()
	$CenterContainer/VBoxContainer/Kanji.text = _base.character
	$CenterContainer/VBoxContainer/InputBranch/Input.grab_focus()


func _input(event):
	if state == WAIT and event.is_action_pressed("ui_accept"):
		_change_to_reading()


func _generate_kanji():
	randomize()
	_base.character = keys[randi() % keys.size()]
	if not _base.character in _base.seen:
		_base.seen.append(_base.character)
		_base.meaning = jlpt5[_base.character]['meanings']	
		_base.reading = jlpt5[_base.character]['readings_on']	
	elif len(_base.seen) == keys.size():
		print('No new kanji availalbe. Restart')  # FIXME: Remove after debug
		# Restart button or end etc --> Queue_free and new scene
	else:
		_generate_kanji()
	

func _on_Input_text_entered(new_text):		
	new_text = new_text.to_lower()	
	_check_translation(new_text)


func _check_translation(response):	
	var check = 0
	
	for i in range(len(_base.meaning)):
		_base.meaning[i] = _base.meaning[i].to_lower()

	for meaning in _base.meaning:
		if (meaning in response or response in meaning) and len(meaning) == len(response):
			check += 1
			
	if _base._distance(response, _base.meaning):
		check += 1		

	if check > 0:
		emit_signal("correct_translation")
	else:
		emit_signal("wrong_translation")
		

func _on_Translate_correct_translation():
	$CenterContainer/VBoxContainer/InputBranch/ColorRect.color = Color(0,0.6,0,0.2)
	$CenterContainer/VBoxContainer/InputBranch/Input.editable = false
	state = WAIT

	
func _on_Translate_wrong_translation():
	$CenterContainer/VBoxContainer/InputBranch/ColorRect/AnimationPlayer.play("Flash")	
	tries += 1
	if tries > 2:
		print('High on tries')
		tries = 0


func _on_ReturnToStart_pressed():
	queue_free()
	var _discard = get_tree().change_scene("res://StartMenu.tscn")


func _set_input_empty():
	$CenterContainer/VBoxContainer/InputBranch/Input.text = ''


func _change_to_reading():
	get_tree().set_input_as_handled()
	queue_free()
	get_tree().get_root().add_child(ReadingScene.instance())

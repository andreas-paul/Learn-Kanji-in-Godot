extends Control

var character

onready var jlpt5 = Config.jlpt5
onready var keys = jlpt5.keys()		

signal correct
signal wrong

func _ready():	
	_generate_kanji()

func _process(_delta):
	pass

func _generate_kanji():
	randomize()
	character = keys[randi() % keys.size()]
	print(jlpt5[str(character)]['meanings'])  # FIXME: DEBUG
	$CenterContainer/VBoxContainer/Kanji.text = str(character)
	
func _check_translation(response, kanji_character):	
	var meaning = jlpt5[kanji_character]['meanings']	
	for i in range(len(meaning)):
		meaning[i] = meaning[i].to_lower()		
	if (response in meaning) or _distance(response, meaning):		
		emit_signal("correct")
	else:		
		emit_signal("wrong")

func _distance(response, meaning):
	for i in meaning:		
		if _edit_distance(response, i, len(response), len(i)) <= 1:			
			return true
		else:
		
			return false

func _edit_distance(str1, str2, m, n):	
	# This function calculates the edit distance between response
	# and any of the existing meanings
	# str1, str2: input strings | m, n: length str1, str2

	# TODO: if input len > meaning len doesn't work

	if m == 0: 
		return n
	if n == 0: 
		return m 		
	if str1[m-1] == str2[n-1]: 
		return _edit_distance(str1, str2, m-1, n-1)
	var min1 : int = _edit_distance(str1, str2, m, n-1)
	var min2 : int = _edit_distance(str1, str2, m-1, n)
	var min3 : int = _edit_distance(str1, str2, m-1, n-1 )	
	return 1 + min(min1, min(min2, min3))
	
func _on_Study_correct():
	_set_input_empty()
	_generate_kanji()

func _on_Study_wrong():
	$CenterContainer/VBoxContainer/Input/ColorRect/AnimationPlayer.play("Flash")	

func _on_ReturnToStart_pressed():
	# TODO: Save for continue
	queue_free()
	var _discard = get_tree().change_scene("res://StartMenu.tscn")

func _on_Input_text_entered(new_text):
	new_text = new_text.to_lower()
	_check_translation(new_text, character)

func _set_input_empty():
	$CenterContainer/VBoxContainer/Input.text = ''

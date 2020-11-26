extends Control

var sub_hir = {'んあ': 'な', 'んい': 'に', 'んう': 'ぬ', 'んえ': 'ね', 'んお': 'の'}
var sub_kat = {'ンア': 'ナ', 'ンイ': 'ニ' , 'ンウ': 'ヌ' , 'ンエ': 'ネ', 'ンオ': 'ノ'}

onready var readings = _base.jlpt5[_base.character]['readings_on'] + _base.jlpt5[_base.character]['readings_kun']

signal reading_correct
signal reading_wrong


func _ready():

	$CenterContainer/VBoxContainer/Kanji.text = _base.character
	$CenterContainer/VBoxContainer/Input.grab_focus()

	for i in len(readings):
		if '.' in readings[i]:
			readings[i] = readings[i].replace('.', '')
	

func _check_reading(response):
	if response in readings:
		emit_signal("reading_correct")
	else:
		emit_signal("reading_wrong")
		

func _on_Input_text_entered(new_text):	
	_check_reading(new_text)


func _on_Input_text_changed(new_text):
	if len(new_text) > 0:
		new_text = str(new_text).to_lower()
		new_text = autoloadpy.hiragana(new_text)
		for key in sub_hir:
			if key in new_text:
				new_text = new_text.replace(key, sub_hir[key])					
		$CenterContainer/VBoxContainer/Input.text = new_text
		$CenterContainer/VBoxContainer/Input.caret_position = $CenterContainer/VBoxContainer/Input.text.length()
		accept_event()


func _on_Reading_reading_wrong():
	$CenterContainer/VBoxContainer/Input/ColorRect/AnimationPlayer.play("Flash")


func _on_Reading_reading_correct():
	queue_free()	
	var err = get_tree().change_scene("res://Translate.tscn")
	if err != OK:
		push_error(err)


func _on_ReturnToStart_pressed():
	queue_free()
	var _discard = get_tree().change_scene("res://StartMenu.tscn")
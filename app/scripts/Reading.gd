extends Control

var sub_hir = {'んあ': 'な', 'んい': 'に', 'んう': 'ぬ', 'んえ': 'ね', 'んお': 'の'}
var sub_kat = {'ンア': 'ナ', 'ンイ': 'ニ' , 'ンウ': 'ヌ' , 'ンエ': 'ネ', 'ンオ': 'ノ'}
var state

onready var readings = _base.jlpt5[_base.character]['readings_on'] + _base.jlpt5[_base.character]['readings_kun']

signal reading_correct
signal reading_wrong

enum {
	WAIT
}

func _ready():

	$CenterContainer/VBoxContainer/Kanji.text = _base.character
	$CenterContainer/VBoxContainer/InputBranch/Input.grab_focus()

	for i in len(readings):
		if '.' in readings[i]:
			readings[i] = readings[i].replace('.', '')
	

func _input(event):
	if state == WAIT and event.is_action_pressed("ui_accept"):
		_change_to_reading()


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
		$CenterContainer/VBoxContainer/InputBranch/Input.text = new_text
		$CenterContainer/VBoxContainer/InputBranch/Input.caret_position = $CenterContainer/VBoxContainer/InputBranch/Input.text.length()
		accept_event()


func _on_Reading_reading_wrong():
	$CenterContainer/VBoxContainer/InputBranch/ColorRect/AnimationPlayer.play("Flash")


func _on_Reading_reading_correct():
	$CenterContainer/VBoxContainer/InputBranch/ColorRect.color = Color(0,0.6,0,0.2)
	$CenterContainer/VBoxContainer/InputBranch/Input.editable = false
	state = WAIT
	

func _on_ReturnToStart_pressed():
	queue_free()
	var _discard = get_tree().change_scene("res://StartMenu.tscn")


func _change_to_reading():
	get_tree().set_input_as_handled()
	queue_free()
	var err = get_tree().change_scene("res://Translate.tscn")
	if err != OK:
		push_error(err)

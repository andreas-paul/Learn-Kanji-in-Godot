extends Node

onready var data_standard = load_json("assets/kanji.json")

onready var data = data_standard

onready var jlpt5 = filter_by_jlpt(5, data)  # JLPT 5
onready var jlpt4 = filter_by_jlpt(4, data)  # JLPT 4
onready var jlpt3 = filter_by_jlpt(3, data)  # JLPT 3
onready var jlpt2 = filter_by_jlpt(2, data)  # JLPT 2
onready var jlpt1 = filter_by_jlpt(1, data)  # JLPT 1

onready var character = '生'
onready var reading
onready var meaning
onready var seen = [] 


func filter_by_jlpt(jlpt, parsed_data):
	var data_jlpt = {}
	for i in parsed_data:			
		if parsed_data[i]['jlpt_new'] == jlpt:
			data_jlpt[i] = parsed_data[i]
	return data_jlpt
	

func load_json(path):
	# Define variables and load json from disk
	var file = File.new()
	file.open(path, File.READ)
	var content = file.get_as_text()
	file.close()
	var kanji = JSON.parse(content)
	
	# If no parsing error return kanji data	
	if kanji.error == OK:
		print('Data loaded OK')
		var parsed_data = kanji.result
		return parsed_data
	# Print error if parsing error occurred
	else:
		print('Error', kanji.error)
		print("Error Line: ", kanji.error_line)
		print("Error String: ", kanji.error_string)
	
		
func _distance(response, meaning):
	for i in meaning:		
		if _edit_distance(response, i, len(response), len(i)) <= 2:			
			return true
		else:		
			return false


func _edit_distance(str1, str2, m, n):	
	# This function calculates the edit distance between response
	# and any of the existing meanings
	# str1, str2: input strings | m, n: length str1, str2
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

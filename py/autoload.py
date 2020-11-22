from godot import exposed, export, Node
from godot.bindings import *

import wanakana as wk

@exposed
class autoload(Node):
	
	
	def hiragana(self, x):		
		new_text = str(x).lower()	
		new_text = wk.to_hiragana(new_text)
		return new_text
		
	def katakana(self, x):		
		new_text = str(x).lower()	
		new_text = wk.to_katakana(new_text)
		return new_text
		
	def kana(self, x):		
		new_text = str(x).lower()	
		new_text = wk.to_kana(new_text)
		return new_text

	def test(self):
		txt = wk.to_hiragana('ONAJI onaji na buttsuuji')
		return txt

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

	def dl_dist(self, s1, s2):
		s1 = str(s1)
		s2 = str(s2)
		d = {}
		lenstr1 = len(s1)
		lenstr2 = len(s2)
		for i in range(-1, lenstr1 + 1):
			d[(i, -1)] = i + 1
		for j in range(-1, lenstr2 + 1):
			d[(-1, j)] = j + 1

		for i in range(lenstr1):
			for j in range(lenstr2):
				if s1[i] == s2[j]:
					cost = 0
				else:
					cost = 1
				d[(i,j)] = min(
								d[(i-1,j)] + 1,
								d[(i,j-1)] + 1,
								d[(i-1,j-1)] + cost
								)
				if i and j and s1[i] == s2[j-1] and s1[i-1] == s2[j]:
					d[(i,j)] = min(d[(i,j)], d[i-2,j-2] + cost)
		
		return d[lenstr1 - 1, lenstr2 - 1]

# KANJI VALLEY

A Godot app to study Japanese Kanji, developed as part of my efforts to learn Godot and GameDev in general. Uses GDscript but for the Romaji to Kana conversion, which uses Python. Barebones for now

<p align="center">
<img src="img/KanjiValley_screengrab.gif" width="250"/>
</p>

Features:

- JLPT5 Kanji only (for now)
- Check translation and reading
- Automatically converts to Hiragana while typing (in reading scene)

To do:

- Ability to select from all JLPT levels
- Switch between Hiragana and Katakana
- Save and load configuration and settings
- Hints if answer is wrong multiple times in succession
- Kanji history on a grid
- Maybe some sort of SRS
- More info about specific Kanji (maybe even Jiso.org integration)
- Graphics (nice animations etc.)

Requirements:  

- Assets folder:

    - kanji.json downloaded from [here](https://github.com/davidluzgouveia/kanji-data) 
    - Add your own fonts. Needs to support Japanese (e.g. NotoSansJP)

- Godot addons: Pythonscript v. >=0.50.0

Credits:

- [Godot](https://godotengine.org/)
- [Godot Python](https://github.com/touilleMan/godot-python)
- [Kanji data](https://github.com/davidluzgouveia/kanji-data)
- [WanaKana-py](https://github.com/Starwort/wanakana-py)
- [WanaKana](https://github.com/WaniKani/WanaKana)

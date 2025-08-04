extends AudioStreamPlayer

var music := preload("res://menus/lord_of_the_land.mp3")


func _ready() -> void:
	self.stream = music
	self.play()

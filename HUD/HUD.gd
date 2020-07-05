extends Control

var pLifeIcon := preload("res://HUD/LifeIcon.tscn")

onready var lifeContainer := $LifeContainer

func _ready():
	clearLives()
	
	Signals.connect("on_player_life_changed", self, "_on_player_life_changed")
	
func clearLives():
	for child in lifeContainer.get_children():
		lifeContainer.remove_child(child)
		child.queue_free()

func setLives(lives: int):
	clearLives()
	for i in range(lives):
		lifeContainer.add_child(pLifeIcon.instance())

func _on_player_life_changed(life: int):
	setLives(life)

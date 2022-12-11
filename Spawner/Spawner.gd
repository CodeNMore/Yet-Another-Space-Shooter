extends Node2D

const MIN_SPAWN_TIME = 1.5

var preloadedEnemies := [
	preload("res://Enemy/FastEnemy.tscn"),
	preload("res://Enemy/SlowShooter.tscn"),
	preload("res://Enemy/BouncerEnemy.tscn")
]
var preloadedPowerups := [
	preload("res://Powerups/ShieldPowerup.tscn"),
	preload("res://Powerups/RapidFirePowerup.tscn"),
]
var plMeteor := preload("res://Meteor/Meteor.tscn")

onready var spawnTimer := $SpawnTimer
onready var powerupSpawnTimer := $PowerupSpawnTimer

export var nextSpawnTime := 5.0
export var minPowerupSpawnTime := 3
export var maxPowerupSpawnTime := 20

func _ready():
	randomize()
	spawnTimer.start(nextSpawnTime)
	powerupSpawnTimer.start(minPowerupSpawnTime)

func getRandomSpawnPos() -> Vector2:
	var viewRect := get_viewport_rect()
	var xPos := rand_range(viewRect.position.x, viewRect.end.x)
	return Vector2(xPos, position.y)

func _on_SpawnTimer_timeout():
	# Spawn an enemy
	if randf() < 0.1:
		var meteor := plMeteor.instance()
		meteor.position = getRandomSpawnPos()
		get_tree().current_scene.add_child(meteor)
	else:
		var enemyPreload = preloadedEnemies[randi() % preloadedEnemies.size()]
		var enemy: Enemy = enemyPreload.instance()
		enemy.position = getRandomSpawnPos()
		get_tree().current_scene.add_child(enemy)
	
	# Restart the timer
	nextSpawnTime -= 0.1
	if nextSpawnTime < MIN_SPAWN_TIME:
		nextSpawnTime = MIN_SPAWN_TIME
	spawnTimer.start(nextSpawnTime)

func _on_PowerupSpawnTimer_timeout() -> void:
	var powerupPreload = preloadedPowerups[randi() % preloadedPowerups.size()]
	var powerup: Powerup = powerupPreload.instance()
	powerup.position = getRandomSpawnPos()
	get_tree().current_scene.add_child(powerup)
	powerupSpawnTimer.start(rand_range(minPowerupSpawnTime, maxPowerupSpawnTime))

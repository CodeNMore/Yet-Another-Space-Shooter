extends Area2D
class_name Player

var plBullet := preload("res://Bullet/Bullet.tscn")

onready var animatedSprite := $AnimatedSprite
onready var firingPositions := $FiringPositions
onready var fireDelayTimer := $FireDelayTimer
onready var invincibilityTimer := $InvincibilityTimer
onready var rapidFireTimer := $RapidFireTimer
onready var shieldSprite := $Shield

export var speed: float = 100
export var life: int = 3
export var damageInvincibilityTime := 2.0
var vel := Vector2(0, 0)

export var normalFireDelay: float = 0.12
export var rapidFireDelay: float = 0.08
var fireDelay: float = normalFireDelay

func _ready():
	shieldSprite.visible = false
	Signals.emit_signal("on_player_life_changed", life)

func _process(delta):
	# Animate
	if vel.x < 0:
		animatedSprite.play("Left")
	elif vel.x > 0:
		animatedSprite.play("Right")
	else:
		animatedSprite.play("Straight")
		
	# Check if shooting
	if Input.is_action_pressed("shoot") and fireDelayTimer.is_stopped():
		fireDelayTimer.start(fireDelay)
		for child in firingPositions.get_children():
			var bullet := plBullet.instance()
			bullet.global_position = child.global_position
			get_tree().current_scene.add_child(bullet)
	
func _physics_process(delta):
	var dirVec := Vector2(0, 0)
	
	if Input.is_action_pressed("move_left"):
		dirVec.x = -1
	elif Input.is_action_pressed("move_right"):
		dirVec.x = 1
	if Input.is_action_pressed("move_up"):
		dirVec.y = -1
	elif Input.is_action_pressed("move_down"):
		dirVec.y = 1

	vel = dirVec.normalized() * speed
	position += vel * delta
	
	# Make sure that we are within the screen
	var viewRect := get_viewport_rect()
	position.x = clamp(position.x, 0, viewRect.size.x)
	position.y = clamp(position.y, 0, viewRect.size.y)

func damage(amount: int):
	if !invincibilityTimer.is_stopped():
		return
	
	applyShield(damageInvincibilityTime)
	
	life -= amount
	Signals.emit_signal("on_player_life_changed", life)
	
	var cam := get_tree().current_scene.find_node("Cam", true, false)
	cam.shake(20)
	
	if life <= 0:
		queue_free()
		
func applyShield(time: float):
	invincibilityTimer.start(time + invincibilityTimer.time_left)
	shieldSprite.visible = true

func applyRapidFire(time: float):
	fireDelay = rapidFireDelay
	rapidFireTimer.start(time + rapidFireTimer.time_left)

func _on_InvincibilityTimer_timeout():
	shieldSprite.visible = false

func _on_RapidFireTimer_timeout() -> void:
	fireDelay = normalFireDelay

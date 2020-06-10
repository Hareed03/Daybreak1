extends KinematicBody2D
var is_not_dead = true
const UP = Vector2(0, -1)
const GRAVITY = 20
const ACCELERATION = 60
var is_collided = false
const SPEED = 120
const MAX_SPEED = 200
var dialKeyCheck
const JUMP_HEIGHT = -600
export (bool) var is_player
var percentage_health
signal player_stats_changed
var is_in_NPCarea = false
onready var SMRT = "Dialogue/CanvasLayer/dialogue"
export (float) var max_health = 100
var floating_text = preload("res://Floating_Text.tscn")
var time = OS.get_ticks_msec()
var ProgressBar
var player = KinematicBody2D
var attack_cooldown_time = 1000
var next_attack_time = 0
var damage = 30
var motion = Vector2()
var attacking = false
var current_hp
var hp = 100
var timer
var is_grounded
var is_jumping = false
var max_hp = 100
var Label = "UserInterface/UserInterface/health"
var area
var can_talk = true

signal dead
func _ready():
	area = get_node("Dialogue")
	area.connect("body_entered", self, "contact")

	area
	
	timer = Timer.new()
	$AnimatedSprite.play("Idle")
	emit_signal("player_stats_changed", self)
	current_hp = hp
	$Camera2D/CanvasLayer/ProgressBar.value = current_hp
	$Camera2D/CanvasLayer/Health.text = "%s / %s" % [current_hp, max_hp]
	if current_hp <= 0:
		OnDeath()
func _physics_process(delta):
	if is_not_dead:
		get_input()

func get_input():
	motion.y += GRAVITY
	var friction = false

	if Input.is_action_pressed("walk_right"):
		motion.x = min(motion.x+ACCELERATION, MAX_SPEED)
		$AnimatedSprite.play("walking")
		$AnimatedSprite.flip_h = false
		
	elif Input.is_action_pressed("walk_left"):
		motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
		$AnimatedSprite.play("walking")
		$AnimatedSprite.flip_h = true
		
	elif Input.is_action_just_pressed("slash"):
		$AnimationPlayer.play("slashbox")
		attacking = true
		if attacking == true:
			$AnimationPlayer.play("slashbox")
			$AnimatedSprite.play("slash")
			motion.x = 0
	
		
	else:
		motion.x = 0
		$AnimatedSprite.play("Idle")
		friction = true
		motion.x = lerp(motion.x, 0, 0.2)

				
	if is_on_floor():
		
		if Input.is_action_pressed("crouch"):
			$AnimatedSprite.play("crouchidle")
			_drop()


		if Input.is_action_pressed("crouch") && Input.is_action_pressed("walk_right"):
			$AnimatedSprite.play("crouchmove")
			motion.x = 75
		
		if Input.is_action_pressed("crouch") && Input.is_action_pressed("walk_left"):
			$AnimatedSprite.play("crouchmove")
			motion.x = -75

		if Input.is_action_just_pressed("jump"):
			$AnimatedSprite.play("jump")
			motion.y = JUMP_HEIGHT
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
	else:
		$AnimatedSprite.play("jump")
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.05)
	motion = move_and_slide(motion, UP)
	pass
	

		

func _drop():
	position.y += 1


func Progressbarupdate():
	percentage_health = int((float(current_hp) / max_health ))
	$Camera2D/CanvasLayer/ProgressBar.value = current_hp
	$Camera2D/CanvasLayer/Health.text = "%s / %s" % [current_hp, max_hp]
	
	

func OnHit(damage):
	current_hp -= damage
	var text = floating_text.instance()
	text.amount = damage
	add_child(text)
	Progressbarupdate()
	if current_hp <= 0:
		OnDeath()
		
func OnDeath():
	is_not_dead = false
	$Hitbox/CollisionShape2D.disabled = true
	$AnimatedSprite.play("Death")
	emit_signal("dead")

	

func _on_swordhit_body_entered(body):
	if body.is_in_group("Enemy"):
		body.OnHit(damage)



func _on_Church_title_body_entered(body):
	if body.is_in_group("Player"):
		$Camera2D/CanvasLayer/ChruchTEXT/AnimationPlayer.play("show")
		$Camera2D/CanvasLayer/ChruchTEXT/AnimationPlayer.play("invisible")
	else:
		pass






func _on_GhostDialogue_area_entered(area):

	is_in_NPCarea = true


func _on_GhostDialogue_area_exited(area):

	is_in_NPCarea = false


func _on_RoomDetector_area_entered(area: Area2D) -> void:
	var collision_shape = area.get_node("CollisionShape2D")
	var size = collision_shape.shape.extents*2
	
	var view_size = get_viewport_rect().size/2
	if size.y < view_size.y:
		size.y = view_size.y
		
	if size.x < view_size.x:
		size.x = view_size.x
	
	var cam = $Camera2D
	cam.limit_top = collision_shape.global_position.y - size.y/2
	cam.limit_left = collision_shape.global_position.x - size.x/2
	
	cam.limit_bottom = cam.limit_top + size.y
	cam.limit_right = cam.limit_left + size.x


func _on_GhostDialogue_body_entered(body):
	if Input.is_action_pressed("interact"):
		var dialogue_node = get_parent().get_node("Dialogue/CanvasLayer/dialogue")
		dialogue_node.show_text(body.chapter, body.dialog, body.start_at)

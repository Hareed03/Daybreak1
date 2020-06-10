extends KinematicBody2D


const GRAVITY = 10
const SPEED = 50
const FLOOR = Vector2(0, -1)
var floating_text = preload("res://Floating_Text.tscn")
var direction = 1
var velocity = Vector2()
var hp = 60
var current_hp
var damage = 10
var motion = Vector2()
var is_not_dead = true
func OnHit(damage):
	current_hp -= damage
	var text = floating_text.instance()
	text.amount = damage
	add_child(text)
	
	if current_hp <= 0:
		OnDeath()
		
func OnDeath():
	is_not_dead = false
	$HitBox/HitBox.set_deferred("disabled", true)
	$AnimatedSprite.play("death")
	$CollisionShape2D.set_deferred("disabled", true)
	$Hurtbox.set_deferred("disabled", true)
	
		
		
func _ready():
	current_hp = hp
	
func _physics_process(delta):
	if is_not_dead:
		velocity.x = SPEED * direction
	
		if direction == 1:
			$AnimatedSprite.flip_h = true
		else:
			$AnimatedSprite.flip_h = false
		
		$AnimatedSprite.play("Rat_Run")
	
		velocity.y += GRAVITY
	
		velocity = move_and_slide(velocity, FLOOR)
	
		if is_on_wall():
			direction = direction * -1
	





func _on_HitBox_body_entered(body):
	if body.is_in_group("Player"):
		body.OnHit(damage)

extends CharacterBody2D

@export var speed = 400
@onready var animation_tree : AnimationTree = $AnimationTree
var input_direction : Vector2 = Vector2.ZERO

func get_input():
	input_direction = Input.get_vector("left", "right", "up", "down").normalized()
	if input_direction:
		velocity = input_direction * speed
	else:
		velocity = Vector2.ZERO
		
func update_animation_tree_parameters():
	if velocity == Vector2.ZERO:
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/is_moving"] = false
	else:
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/is_moving"] = true
		
	if input_direction != Vector2.ZERO:
		animation_tree["parameters/Idle/blend_position"] = input_direction
		animation_tree["parameters/Walk/blend_position"] = input_direction
	
func _ready():
	animation_tree.active = true
	
func _physics_process(delta):
	get_input()
	move_and_slide()

func _process(delta):
	update_animation_tree_parameters()
	
func _unhandled_input(event):
	if Input.is_action_just_pressed("interact"):
		DialogueManager.show_example_dialogue_balloon(load("res://dialogues/main.dialogue"), "this_is_a_node_title")


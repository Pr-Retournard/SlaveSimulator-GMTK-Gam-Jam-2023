extends Node2D

@export var min_number_people_in_area_to_collect : int = 3 
var number_people_in_area_to_collect :int = 0
var is_ready_to_collect = false
var is_player_in_the_area = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	is_ready_to_collect = is_player_in_the_area and (number_people_in_area_to_collect>=min_number_people_in_area_to_collect)
	print(number_people_in_area_to_collect)
	if is_ready_to_collect:
		queue_free()

func _on_area_2d_body_entered(body):
	if body is Player:
		number_people_in_area_to_collect +=1
		is_player_in_the_area = true
	if body is Slave:
		number_people_in_area_to_collect +=1
		
func _on_area_2d_body_exited(body):
	if body is Player:
		number_people_in_area_to_collect -=1
		is_player_in_the_area = false
	if body is Slave:
		number_people_in_area_to_collect -=1

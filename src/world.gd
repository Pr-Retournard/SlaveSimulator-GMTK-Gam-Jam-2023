extends Node2D

var player_is_in_a_right_area : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var next_player_is_in_a_right_area : bool = false
	var Slaves = get_node("%Slaves")
	for slave in Slaves.get_children():
		next_player_is_in_a_right_area = slave.player_is_in_the_right_area or next_player_is_in_a_right_area	
	player_is_in_a_right_area = next_player_is_in_a_right_area
	$Player/DebugLabel.text = str(player_is_in_a_right_area)

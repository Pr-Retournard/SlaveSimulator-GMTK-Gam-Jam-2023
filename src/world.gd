extends Node2D

var is_player_near_a_slave : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var next_is_player_near_a_slave : bool = false
	var Slaves = get_node("%Slaves")
	for slave in Slaves.get_children():
		next_is_player_near_a_slave = slave.is_player_near_the_slave or next_is_player_near_a_slave	
	is_player_near_a_slave = next_is_player_near_a_slave
	$Player/DebugLabel.text = str(is_player_near_a_slave)

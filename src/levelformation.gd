extends Node2D

var is_player_right_place : bool = true
var is_player_near_a_slave : bool = false
var scenario_checklist : Array[bool] 
var number_time : int 
var training_number :int 
# Called when the node enters the scene tree for the first time.
func _ready():
	$Master.enable_to_move = false
	positions_init()
	number_time = 0 
	training_number = 0
	
func positions_init():
	var Positions = $NextGoalPositions.get_children()
	var pos = 0
	for slave in $Slaves.get_children():
		slave.next_goal_position = Positions[pos]
		pos+=1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_is_player_near_a_slave()
	update_scenario()
	update_master_behaviour()
	update_win_con()
	is_player_right_place = ($Player.position.distance_to($NextGoalPositions/NextGoalPosition15.position)<64)
#	print($Player.position.distance_to($NextGoalPosition15.position))

func update_win_con():
	if scenario_checklist == [true,true,true]:
		print("You win")

func update_master_behaviour():
	if !is_player_near_a_slave:
		$Master.is_angry = true
	else:
		$Master.is_angry = false

func update_is_player_near_a_slave():
	var next_is_player_near_a_slave : bool = false
	var Slaves = get_node("%Slaves")
	for slave in Slaves.get_children():
		next_is_player_near_a_slave = slave.is_player_near_the_slave or next_is_player_near_a_slave	
	is_player_near_a_slave = next_is_player_near_a_slave
	$Player/DebugLabel.text = str(is_player_right_place)
	
func update_is_player_near_to_the_path():
# a coder
	pass

func move_slaves_of(move_vector : Vector2):
	for mark_goal_position in $NextGoalPositions.get_children():
			mark_goal_position.position += move_vector
			
func move_slaves_in_positions(next_positions: Array[Vector2]):
	var index = 0
	for mark_goal_position in $NextGoalPositions.get_children():
			mark_goal_position.position = next_positions[index]
			index += 1
			
func update_scenario():
	#Formation 0 START AVANCER !!! x4
	if is_player_right_place && (number_time <=4)&& (training_number == 0):
		move_slaves_of(Vector2(111,64))
		number_time +=1
		if (number_time==4)&& (training_number == 0):
			training_number += 1
			number_time = 0
	#Formation 0 FIN
	#Formation 1 START RECULER !!! x4
	if is_player_right_place && number_time <=4&& (training_number == 1):
		move_slaves_of(-Vector2(111,64))
		number_time += 1
		if (number_time==4)&& (training_number == 1):
			training_number += 1
			number_time = 0
	#Formation 1 FIN
	#Formation 2 START
#	if is_player_right_place && number_time <=4&& (training_number == 2):
#		move_slaves_in_positions(
#
#		)
	#Formation 2 START
	pass

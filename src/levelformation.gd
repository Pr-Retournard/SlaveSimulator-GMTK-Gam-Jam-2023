extends Node2D

var is_player_right_place : bool = true
var is_player_near_a_slave : bool = false
var scenario_checklist : Array[bool] 
var number_time : int 
var training_number :int 
var is_TimerKeepPosition_timeout : bool = false
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
	#Formation 0 END
	#Formation 1 START RECULER !!! x4
	if is_player_right_place && number_time <=4&& (training_number == 1):
		move_slaves_of(-Vector2(111,64))
		number_time += 1
		if (number_time==4)&& (training_number == 1):
			training_number += 1
			number_time = 0
	#Formation 1 END
	#Formation 2 START
	if is_player_right_place && number_time < 1 &&(training_number == 2):
		move_slaves_in_positions([
	#Formation Tortue
			Vector2(-333, -638),#Slave
			Vector2(-184, -619),#Slave2
			Vector2(-122, -482),#Slave3
			Vector2(15, -728),#Slave4
			Vector2(43, -479),#Slave5
			Vector2(154, -391),#Slave6
			Vector2(434, -338),#Slave7
			Vector2(145, -242),#Slave8
			Vector2(22, -167),#Slave9
			Vector2(0, 59),#Slave10
			Vector2(-118, -225),#Slave11
			Vector2(-422, -270),#Slave12
			Vector2(-180, -352),#Slave13
			Vector2(-341, -501),#Slave14
			Vector2(200,-140)#Player
		])
		if is_player_right_place && (training_number == 2):
			number_time +=1
		if number_time==1 && (training_number == 2):
			training_number += 1
			number_time = 0
		if training_number ==3:
			print("you_win")
	#Formation 2 END

func _on_timer_keep_position_timeout():
	is_TimerKeepPosition_timeout = true

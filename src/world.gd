extends Node2D

var is_player_near_a_slave : bool = false
var scenario_checklist : Array[bool] 
# Called when the node enters the scene tree for the first time.
func _ready():
	scenario_checklist = [false, false ,false]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_is_player_near_a_slave()
	update_scenario()
	update_master_behaviour()
	update_win_con()

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
	$Player/DebugLabel.text = str(is_player_near_a_slave)
	
func update_scenario():
	var final_goal : bool
	if scenario_checklist[0]:
		$NextGoalPosition.position = $Collectable2.position
	if scenario_checklist[1]:
		$NextGoalPosition.position = $FinalPosition.position
	final_goal = $Collectable.is_collect and $Collectable2.is_collect and ($Player.position.distance_to($FinalPosition.position)<20)
	scenario_checklist = [$Collectable.is_collect, $Collectable2.is_collect ,final_goal]
	print(scenario_checklist)

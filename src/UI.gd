extends Control

@export var life: int = 3

@onready var heartSprites = [$Heart1, $Heart2, $Heart3]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in heartSprites.size():
		if (life < i + 1):
			heartSprites[i].visible = false

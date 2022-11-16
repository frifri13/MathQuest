extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var enemyHealth : int = 4
var isEnemyDead : bool = false
var counter : int = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("FakeDamage") == true:
		if enemyHealth > 0:
			print("Enemy health: ")
			print(enemyHealth)
			enemyHealth -= 1
		else:
			print("Enemy dead")
			
			if isEnemyDead == false:
				isEnemyDead = true
	
	if isEnemyDead == true:
		counter -= 1
	if counter <= 0:
		get_tree().change_scene("res://Levels/Test.tscn")

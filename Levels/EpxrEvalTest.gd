extends Node


var logic_helper = "-+*/"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var num_helper_one = randi() % 10
	randomize()
	var num_helper_two = randi() % 10
	var expr = str(num_helper_one) + logic_helper[rand_range(0, 2)] + str(num_helper_two)
	var expression = Expression.new()
	expression.parse(expr)
	var result = expression.execute()
	var end_of_equation = randi() % 101;
	
	print("expr = " + expr)
	print("result of the expression = " + str(result))
	print("result of the equation = " + str(end_of_equation))
	if(result != end_of_equation):
		print("No damage!")
	else:
		print("Damage dealt!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

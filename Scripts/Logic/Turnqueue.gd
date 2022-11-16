extends Spatial 

class_name TurnQueue

var active_character

func initialize():
	active_character = get_child(0)
	

func sortTurnOder(a, b):
	return a.stats.speed < b.stats.speed

func playTurn():
	yield(active_character.playTurn(), "completed")
	var new_index : int = (active_character.get_index + 1) % get_child_count()
	active_character = get_child(new_index)

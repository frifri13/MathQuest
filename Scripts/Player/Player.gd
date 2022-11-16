extends KinematicBody
export var speed := 7.0
export var gravity := 50.0

var _velocity = Vector3.ZERO
var snapVec : Vector3 = Vector3.DOWN

onready var _spring_arm : SpringArm = $SpringArm


func _physics_process(delta):
	var move_direction := Vector3.ZERO
	move_direction.x  = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	move_direction.z  = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	move_direction = move_direction.rotated(Vector3.UP, _spring_arm.rotation.y).normalized()

	_velocity.x = move_direction.x * speed
	_velocity.z = move_direction.z * speed
	_velocity.y -= gravity * delta
	
	_velocity = move_and_slide_with_snap(_velocity, snapVec, Vector3.UP, true)

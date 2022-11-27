extends Node

const serial_res = preload("res://bin/gdserial.gdns")
onready var serial_port = serial_res.new()

#input anterior do joystick
var inputPast = ("J " + "0 " + "0")

var is_port_open = false
var text = ""

signal keypad(key)
signal pushbutton(pushbutton)
signal joystick(x_value, y_value)


func _ready():
	open()
	pass


func _exit_tree():
	close()


func open():
	is_port_open = serial_port.open_port("COM4", 9600)
	print(is_port_open)


func write(textWrite):
	serial_port.write_text(textWrite)


func close():
	is_port_open = false
	serial_port.close_port()


# warning-ignore:unused_argument
func _process(delta):
	if is_port_open:
		var t = serial_port.read_text()
		if t.length() > 0:
			for c in t:
				if c == "\n":
					on_text_received(text)
					text = ""
				else:
					text+=c
			#print(t)
		


"""
* Função que trata o recebimento dos dados, seguindo o seguinte protocolo:
**** Botões -> Exemplo: "1 Sobe" (Player 1 sobe)
**** Potenciômetros -> Exemplo: "2 -7" (Player 2 desloque em direção a -7)
**** Joystick -> Exemplo: "1 5 -2" (Player 1 desloque na direção 5 em x e -2 em y)
"""
func on_text_received(text):
#	if (text == ("J " + "-1 " + "-1")):
#		if(inputPast == text): pass
		
	if(text != inputPast): #CHECA SE INPUT FOI REPETIDO
		inputPast = text #INPUT ANTERIOR RECEBE ATUAL
		var command_array = text.split(" ") #DIVIDE TEXTO EM UM ARRAY
		print(command_array)
#		if(len(command_array) < 1): #SE ARRAY FOR PEQUENO DEMAIS
#			#print("array pequeno demais")
#			return
		if(str(command_array[0]) == "J"):#JOYSTICK
			emit_signal("joystick", command_array[1], command_array[2])			
			#print("sinal joystick ", command_array[1], command_array[2])
		elif command_array[0] == "K":#KEYPAD
			emit_signal("keypad", str(command_array[1]))	
			print("keypad" + str(command_array[0]) + "!")
			print("keypad" + str(command_array[1]) + "!")
		elif command_array[0] == "P": #PUSHBUTTON
			emit_signal("pushbutton", command_array[1])
			#print("sinal pushbutton ", command_array[0])
			

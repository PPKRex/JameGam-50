extends Node

@export var circuitsInLevel = 1
var circuits = 0
signal levelCompleted(tiles, touchedCable)

func circuitTouched(tiles, touchedCable):
	circuits += 1
	if circuits >= circuitsInLevel:
		levelCompleted.emit(tiles, touchedCable)

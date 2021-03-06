class_name PowerPerTurn
extends StaticEffect

var power_per_turn: int

func _init(power_per_turn: int):
	self.power_per_turn = power_per_turn

func build_description() -> String:
	return "+%s power per turn" % power_per_turn

func apply(player_id: int):
	game.player(player_id).inc_power_per_turn(power_per_turn)

func undo(player_id: int):
	game.player(player_id).dec_power_per_turn(power_per_turn)

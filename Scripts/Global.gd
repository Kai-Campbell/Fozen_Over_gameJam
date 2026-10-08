extends Node

'Options sliders values'
var sfx_value = 0.7
var music_value = 0.7

'Floor names (for walking sounds)'
var current_world_floors : PackedStringArray

'Items'
var has_flight_stick = false
var has_light = false
var has_prop = false
var has_alien_device = false
var has_gun = false

'People'
var has_meet_army = false
var has_met_kid = false
var has_met_mayor = false
var has_talked_pilot_finale = false
var has_met_bunker_guy = false
var has_met_gun_guy = false


'events'
var decision_made_10_sec = false # if you blow the bomb up
var decision_made_20_min = false
var leave_pilot_to_die = false # if you leave the pilot
var kill_bunker_guy = false
var shooted_pilot = false # if you kill pilot in convo
var strike_the_deal = false
var leave = false
var kill_pilot = false
var shoot_pilot = false # if you fight the pilot

'interactables'
@warning_ignore("unused_signal")
signal item_aquired(item : String)

'pause game'
@warning_ignore("unused_signal")
signal text_start
@warning_ignore("unused_signal")
signal text_end

'level specific'
@warning_ignore("unused_signal")
signal start_game
@warning_ignore("unused_signal")
signal pilot_with_gun
@warning_ignore("unused_signal")
signal choose_time
@warning_ignore("unused_signal")
signal pilot_dead_lol

@warning_ignore("unused_signal")
signal play_gun_sound

func reset_everything():
	decision_made_10_sec = false
	decision_made_20_min = false
	leave_pilot_to_die = false
	kill_bunker_guy = false
	shooted_pilot = false
	strike_the_deal = false
	leave = false
	kill_pilot = false
	shoot_pilot = false
	
	has_meet_army = false
	has_met_kid = false
	has_met_mayor = false
	has_talked_pilot_finale = false
	has_met_bunker_guy = false
	has_met_gun_guy = false
	
	has_flight_stick = false
	has_light = false
	has_prop = false
	has_alien_device = false
	has_gun = false

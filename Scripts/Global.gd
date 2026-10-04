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
var battle_with_pilot = false # if you fight the pilot
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

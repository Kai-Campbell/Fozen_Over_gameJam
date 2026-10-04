extends CanvasLayer

@onready var sfx: HSlider = $VBoxContainer/SFX
@onready var music: HSlider = $VBoxContainer/Music

var sfx_index
var music_index

func _ready() -> void:
	sfx_index = AudioServer.get_bus_index("SFX")
	music_index = AudioServer.get_bus_index("MUSIC")
	
	AudioServer.set_bus_volume_db(sfx_index, AudioServer.get_bus_volume_db(sfx_index))
	AudioServer.set_bus_volume_db(music_index, AudioServer.get_bus_volume_db(music_index))
	
	sfx.set_value_no_signal(Global.sfx_value)
	music.set_value_no_signal(Global.music_value) 
	
	print(AudioServer.get_bus_volume_db(sfx_index))
	print(AudioServer.get_bus_volume_db(music_index))


func _on_sfx_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx_index, linear_to_db(value))
	Global.sfx_value = sfx.value
	print(AudioServer.get_bus_volume_db(sfx_index))

func _on_music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music_index, linear_to_db(value))
	Global.music_value = music.value
	print(AudioServer.get_bus_volume_db(music_index))

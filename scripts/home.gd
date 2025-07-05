extends Control

@onready var record_label := $MarginContainer/VBoxContainer/Record

var save_path := "user://config.ini"

func _ready() -> void:
	load_settings()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_mute_pressed() -> void:
	var bus_idx = AudioServer.get_bus_index("Master")
	var current_mute = AudioServer.is_bus_mute(bus_idx)
	var new_mute = not current_mute
	AudioServer.set_bus_mute(bus_idx, new_mute)
	save_settings(new_mute)

func save_settings(mute_value: bool) -> void:
	var config = ConfigFile.new()
	config.set_value("Game", "mute", mute_value)
	var err = config.save(save_path)
	if err != OK:
		print("Errore nel salvataggio: ", err)

func load_settings() -> void:
	var config = ConfigFile.new()
	if config.load(save_path) == OK:
		var mute_value = config.get_value("Game", "mute", false)
		var bus_idx = AudioServer.get_bus_index("Master")
		AudioServer.set_bus_mute(bus_idx, mute_value)
		
		var record = config.get_value("Game", "record", 0)
		record_label.text = "Record: %s" % str(record)
	else:
		print("Nessun file di configurazione trovato, uso impostazioni di default")

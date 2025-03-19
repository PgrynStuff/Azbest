extends Control

func _ready() -> void:
	$CenterContainer/VBoxContainer/VBoxContainer/Local.grab_focus()
	$Settings.connect("SettingsQuit", SettingsClosed)

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_settings_pressed() -> void:
	$Settings.show()
	SettingsEnetered.emit()

signal SettingsEnetered

func SettingsClosed():
	$CenterContainer/VBoxContainer/VBoxContainer/Settings.grab_focus()

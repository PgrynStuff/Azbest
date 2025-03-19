extends Control

@onready var WindowModeOption = $VBoxContainer/WindowModeHBox/WModeOption
@onready var ResolutionOption = $VBoxContainer/ResolutionHBox/ResOption

#Consider adding borderless
const WindowModeArray :Array[String] = [
	"W OKNIE",
	"PEŁNY EKRAN"
]

func _ready():
	AddWindoWModeOptions()
	AddResolutionOptions()
	WindowModeOption.item_selected.connect(OnWindowModeSelected)
	ResolutionOption.item_selected.connect(OnResolutionSelected)
	
	$"..".connect("SettingsEnetered", SettingsOpened)


func AddWindoWModeOptions():
	for mode in WindowModeArray:
		WindowModeOption.add_item(mode)


func OnWindowModeSelected(index:int):
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
			ResolutionOption.disabled = false
			ResolutionOption.focus_mode = FOCUS_ALL
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
			ResolutionOption.disabled = true
			ResolutionOption.focus_mode = FOCUS_NONE
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
			ResolutionOption.disabled = false
			ResolutionOption.focus_mode = FOCUS_ALL

const ResolutionDictionary :Dictionary = {
	"1280x720": Vector2(1280, 720),
	"1920x1080": Vector2(1920, 1080),
	"2560x1440": Vector2(2560, 1440),
	"3840x2160": Vector2(3840, 2160),
	"7680x4320":Vector2(7680, 4320)
	
}

func AddResolutionOptions():
	for resolution in ResolutionDictionary:
		ResolutionOption.add_item(resolution)


func OnResolutionSelected(index:int):
	DisplayServer.window_set_size(ResolutionDictionary.values()[index])


func _on_save_and_exit_pressed() -> void:
	hide()
	SettingsQuit.emit()

signal SettingsQuit

func SettingsOpened():
	WindowModeOption.grab_focus()

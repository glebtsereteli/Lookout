
if (keyboard_check_pressed(vk_space)) {
	show_message(audio_bus_main.effects[0])
	audio_bus_main.effects[0] = undefined;
}

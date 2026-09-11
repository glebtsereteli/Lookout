
// Toggle Audio Effects' sound:
with (audioEffects) {
	if (playing) {
		if (not audio_is_playing(sound)) {
		    sound = audio_play_sound(sndDemoAudioEffects, 0, true);
		}
	}
	else if (audio_is_playing(sound)) {
	    audio_stop_sound(sound);
	}
}

if (keyboard_check_pressed(vk_space)) {
	Lookout.Resources();
}

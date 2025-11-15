
if (keyboard_check_pressed(vk_space)) {
	window_set_cursor(choose(cr_beam, cr_handpoint, cr_hourglass));
	display_set_timing_method(choose(tm_countvsyncs, tm_countvsyncs_winalt, tm_sleep, tm_systemtiming));
	display_set_sleep_margin(irandom(20));
}

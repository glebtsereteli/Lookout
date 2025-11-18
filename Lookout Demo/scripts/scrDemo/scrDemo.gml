
function DemoInit() {
	window_set_caption($"{__LOOKOUT_NAME} {__LOOKOUT_VERSION} ({__LOOKOUT_DATE}) Demo!");
	randomize();
	
	instance_create_depth(0, 0, -15000, objDemoControl);
	
	room_goto(rmDemoA);
}

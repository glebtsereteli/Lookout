// feather ignore all

function __LookoutAudioEffects() : __LookoutView("AudioEffects", 420, 500) constructor {
	// Shared
	static __Init = function() {
		dbg_section("Master"); {
			var _w = 130;
			var _h = 19;
			dbg_button("Remove All", function() {
				array_foreach(audio_bus_main.effects, function(_effect, _i) {
					delete audio_bus_main.effects[_i];
				});
			}, _w, _h);
			dbg_same_line();
			dbg_button("Bypass All", function() {
				array_foreach(audio_bus_main.effects, function(_effect) {
					with (_effect) {
						bypass = true;
					}
				});
			}, _w, _h);
			dbg_same_line();
			dbg_button("Unbypass All", function() {
				array_foreach(audio_bus_main.effects, function(_effect) {
					with (_effect) {
						bypass = false;
					}
				});
			}, _w, _h);
		}
		
		__Refresh();
	};
	static __Refresh = function() {
		array_foreach(__effects, function(_effect) {
			_effect.__Refresh();
		});
	};
	
	// Custom
	__effects = array_create_ext(8, function(_i) {
		return new __LookoutAudioEffect(_i);
	});
}

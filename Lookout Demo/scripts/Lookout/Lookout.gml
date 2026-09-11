
function Lookout() {
	#region Positioning
	
	
	#endregion
	#region Views
	
	/// Displays "ResourceCounts" and "DumpMemory" data from `debug_event()` + a few custom-tracked resources in a "Lookout: Resources" debug view.
	/// -
	/// Helps track memory leaks from data structures, surfaces, buffers, particles, time sources, and other runtime-created assets that can be accidentally left undisposed.
	/// -
	/// NOTE: This function is quite slow when the Debug Overlay is open, since `debug_event()` is being called every frame. Don't be alarmed if your FPS drops with this enabled.
	/// 
	/// @param {Bool} enabled Enable (true) or disable (false) the view. Leaving this `undefined` toggles the view.
	/// 
	/// @returns {Struct.Lookout}
	/// @self Lookout
	/// @url TODO
	static Resources = function(_enabled = undefined) {
		__View(__LookoutResources, _enabled);
		
		return self;
	};
	
	/// Displays the overall and per-object instance counts in a "Lookout: Instances" debug view, including differences between frames, with an option to destroy objects.
	/// -
	/// Helps track existing objects and their instance counts to identify objects that are out of place.
	/// 
	/// @param {Bool} enabled Enable (true) or disable (false) the view. Leaving this `undefined` toggles the view.
	/// 
	/// @returns {Struct.Lookout}
	/// @self Lookout
	/// @url TODO
	static Instances = function(_enabled = undefined) {
		__View(__LookoutInstances, _enabled);
		
		return self;
	};
	
	/// Provides info and controls for display, window, appsurf, and views in a "Lookout: Display" debug view. Inspired by Pixelated Pope's `display_write_all_specs()`.
	/// 
	/// @param {Bool} enabled Enable (true) or disable (false) the view. Leaving this `undefined` toggles the view.
	/// 
	/// @returns {Struct.Lookout}
	/// @self Lookout
	/// @url TODO
	static Display = function(_enabled = undefined) {
		__View(__LookoutDisplay, _enabled);
		
		return self;
	};
	
	/// Provides control over room switching and displays room history in a "Lookout: Rooms" debug view.
	/// Useful for quickly switching between rooms for testing, and identifying unintentional room changes.
	/// 
	/// @param {Bool} enabled Enable (true) or disable (false) the view. Leaving this `undefined` toggles the view.
	/// 
	/// @returns {Struct.Lookout}
	/// @self Lookout
	/// @url TODO
	static Rooms = function(_enabled = undefined) {
		__View(__LookoutRooms, _enabled);
		
		return self;
	};
	
	
	/// Provides controls for all 8 audio effects on `audio_bus_main` in a "Lookout: Audio Effects" debug view.
	/// Includes type selection and parameter tweaking.
	/// 
	/// @param {Bool} enabled Enable (true) or disable (false) the view. Leaving this `undefined` toggles the view.
	/// 
	/// @returns {Struct.Lookout}
	/// @self Lookout
	/// @url TODO
	static AudioEffects = function(_enabled = undefined) {
		__View(__LookoutAudioEffects, _enabled);
		
		return self;
	};
	
	#endregion
	
	#region __private
	
	static __views = [];
	
	static __View = function(_class, _enabled) {
		var _index = array_find_index(__views, method({_class}, function(_view) {
			return is_instanceof(_view, _class);
		}));
		var _exists = (_index != -1);
		
		_enabled ??= not _exists;
		
		if (_enabled) {
			if (not _exists) {
				array_push(__views, new _class().__Show());
			}
		}
		else if (_exists) {
			__views[_index].__Hide();
			array_delete(__views, _index, 1);
		}
	};
	
	time_source_start(time_source_create(time_source_global, 1, time_source_units_frames, function() {
		if (not is_debug_overlay_open()) return;
		
		array_foreach(Lookout.__views, function(_view) {
			_view.__Tick();
		});
	}, [], -1));
	
	#endregion
}

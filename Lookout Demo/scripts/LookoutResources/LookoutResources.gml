// feather ignore all

/// @func LookoutResources()
/// @param {Bool} startVisible? Whether the debug view starts visible (true) or not (false). [Default: true]
/// 
/// @desc Displays "ResourceCounts" and "DumpMemory" data from debug_event() + a few custom-tracked resources.
/// Helps track memory leaks from data structures, surfaces, buffers, particles, time sources,
/// and other runtime-created assets that can be accidentally left undisposed.
/// 
/// NOTE: This function is quite slow when the Debug Overlay is open, since debug_event() is being called every frame.
/// Don't be alarmed if your FPS drops with this enabled.
/// 
/// Call this function once at the start of the game.
function LookoutResources(_startVisible = true) {
	static __ = new (function(_startVisible) constructor {
		var _Refresh = function() {
			if (not is_debug_overlay_open()) return;
			
			var _resources = debug_event("ResourceCounts", true);
			
			var _syncGroup = audio_create_sync_group(false);
			_resources.__audioSyncGroups = _syncGroup;
			audio_destroy_sync_group(_syncGroup);
			
			var _cam = camera_create();
			_resources.__cameras = _cam;
			camera_destroy(_cam);
			
			_resources.__animCurves = array_length(asset_get_ids(asset_animationcurve));
			
			struct_foreach(_resources, function(_key, _value) {
				self[$ _key] ??= _value;
				self[$ $"{_key}Prev"] ??= _value;
				
				var _display = _value;
				var _delta = _value - self[$ $"{_key}Prev"];
				if (_delta != 0) {
					_display = $"{_display} ({(_delta > 0) ? "+" : "-"}{abs(_delta)})";
					self[$ _key] = _display;
				}
				self[$ $"{_key}Prev"] = _value;
			});
			
			struct_foreach(debug_event("DumpMemory", true), function(_key, _value) {
				self[$ _key] = $"{string_format(_value / 1_000_000, 1, 2)}mb";
			});
		};
		
		_Refresh();
		call_later(1, time_source_units_frames, _Refresh, true);
		
		dbg_view("Lookout: Resources", _startVisible, 16, 35, 420, 640);
		dbg_section("Resources"); {
			dbg_text_separator("Data Structures", 1); {
				dbg_watch(ref_create(self, "listCount"), "DS Lists");
				dbg_watch(ref_create(self, "mapCount"), "DS Maps");
				dbg_watch(ref_create(self, "queueCount"), "DS Queues");
				dbg_watch(ref_create(self, "gridCount"), "DS Grids");
				dbg_watch(ref_create(self, "priorityCount"), "DS Priority Queues");
				dbg_watch(ref_create(self, "stackCount"), "DS Stacks");
			}
			dbg_text_separator("Audio", 1); {
				dbg_watch(ref_create(self, "audioEmitterCount"), "Audio Emitters");
				dbg_watch(ref_create(self, "__audioSyncGroups"), "Audio Sync Groups");
			}
			dbg_text_separator("Particles", 1); {
				dbg_watch(ref_create(self, "partSystemCount"), "Particle Systems");
				dbg_watch(ref_create(self, "partEmitterCount"), "Particle Emitters");
				dbg_watch(ref_create(self, "partTypeCount"), "Particle Types");
			}
			dbg_text_separator("Others", 1); {
				dbg_watch(ref_create(self, "mpGridCount"), "MP Grids");
				dbg_watch(ref_create(self, "bufferCount"), "Buffers");
				dbg_watch(ref_create(self, "vertexBufferCount"), "Vertex Buffers");
				dbg_watch(ref_create(self, "surfaceCount"), "Surfaces");
				dbg_watch(ref_create(self, "timeSourceCount"), "Time Sources");
				dbg_watch(ref_create(self, "__cameras"), "Cameras");
			}
		}
		//dbg_watch(ref_create(self, "instanceCount"), "Instances");
		dbg_section("Assets"); {
			dbg_watch(ref_create(self, "spriteCount"), "Sprites");
			dbg_watch(ref_create(self, "pathCount"), "Paths");
			dbg_watch(ref_create(self, "fontCount"), "Fonts");
			dbg_watch(ref_create(self, "roomCount"), "Rooms");
			dbg_watch(ref_create(self, "__animCurves"), "Animation Curves");
			dbg_watch(ref_create(self, "timelineCount"), "Timelines");
		}
		dbg_section("Memory"); {
			dbg_watch(ref_create(self, "totalUsed"), "Used");
			dbg_watch(ref_create(self, "free"), "Free");
			dbg_watch(ref_create(self, "peakUsage"), "Peak");
		}
	})(_startVisible);
}

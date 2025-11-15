
/// @func LookoutResources()
/// @param {Bool} startVisible? Whether the debug view should start visible (true) or not (false). [Default: true]
/// @desc Displays the data fetched from debug_event("ResourceCounts") and debug_event("DumpMemory") in a Resource Counts debug overlay view.
/// Call anywhere in the project.
function LookoutResources(_startVisible = true) {
	static __ = new (function(_startVisible) constructor {
		var _Refresh = function() {
			if (not is_debug_overlay_open()) return;
			
			struct_foreach(debug_event("ResourceCounts", true), function(_key, _value) {
				self[$ _key] = _value;
			});
			struct_foreach(debug_event("DumpMemory", true), function(_key, _value) {
				self[$ _key] = $"{string_format(_value / 1_000_000, 1, 2)}mb";
			});
		};
		
		_Refresh();
		call_later(1, time_source_units_frames, _Refresh, true);
		
		dbg_view("Lookout: Resources", _startVisible, 8, 27, 350, 550);
		dbg_section("Resources"); {
			dbg_watch(ref_create(self, "instanceCount"), "Instances");
			dbg_text_separator("");
			dbg_watch(ref_create(self, "listCount"), "DS Lists");
			dbg_watch(ref_create(self, "mapCount"), "DS Maps");
			dbg_watch(ref_create(self, "queueCount"), "DS Queues");
			dbg_watch(ref_create(self, "gridCount"), "DS Grids");
			dbg_watch(ref_create(self, "priorityCount"), "DS Priority Queues");
			dbg_watch(ref_create(self, "stackCount"), "DS Stacks");
			dbg_watch(ref_create(self, "mpGridCount"), "DS Grids");
			dbg_watch(ref_create(self, "bufferCount"), "Buffers");
			dbg_watch(ref_create(self, "vertexBufferCount"), "Vertex Buffers");
			dbg_watch(ref_create(self, "surfaceCount"), "Surfaces");
			dbg_watch(ref_create(self, "audioEmitterCount"), "Audio Emitters");
			dbg_watch(ref_create(self, "partSystemCount"), "Particle Systems");
			dbg_watch(ref_create(self, "partEmitterCount"), "Particle Emitters");
			dbg_watch(ref_create(self, "partTypeCount"), "Particle Types");
			dbg_watch(ref_create(self, "timeSourceCount"), "Time Sources");
		}
		dbg_section("Assets"); {
			dbg_watch(ref_create(self, "spriteCount"), "Sprites");		
			dbg_watch(ref_create(self, "pathCount"), "Paths");
			dbg_watch(ref_create(self, "fontCount"), "Fonts");
			dbg_watch(ref_create(self, "roomCount"), "Rooms");
			dbg_watch(ref_create(self, "timelineCount"), "Timelines");
		}
		dbg_section("Memory"); {
			dbg_watch(ref_create(self, "totalUsed"), "Used");
			dbg_watch(ref_create(self, "free"), "Free");
			dbg_watch(ref_create(self, "peakUsage"), "Peak");
		}
	})(_startVisible);
}

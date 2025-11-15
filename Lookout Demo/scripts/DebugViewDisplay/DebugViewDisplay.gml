
/// @func DebugViewDisplay()
/// @param {Bool} startVisible? Whether the debug view should start visible (true) or not (false). [Default: true]
/// @desc Shows display, window, surface, GUI, and view information in a Display debug view.
/// Call once at the start of the game.
function DebugViewDisplay(_startVisible = true) {
	static __ = new (function(_startVisible) constructor {
		__display = undefined;
		__window = undefined;
		__appSurf = undefined;
		__gui = undefined;
		__views = array_create_ext(8, function(_i) {
			return {
				__index: _i,
				__visible: undefined,
				__size: undefined,
				__pos: undefined,
			};
		});
		
		__Refresh = function() {
			__display = __GetString(display_get_width(), display_get_height());
			__window = __GetString(window_get_width(), window_get_height());
			__appSurf = __GetString(surface_get_width(application_surface), surface_get_height(application_surface));
			__gui = __GetString(display_get_gui_width(), display_get_gui_height());
			
			array_foreach(__views, function(_view, _i) {
				_view.__visible = (view_visible[_i] ? "True" : "False");
				var _cam = view_camera[_i];
				_view.__size = __GetString(camera_get_view_width(_cam), camera_get_view_height(_cam));
				_view.__pos = $"{camera_get_view_x(_cam)},{camera_get_view_y(_cam)}";
			});
		};
		__GetString = function(_w, _h) {
			return $"{_w}x{_h}: {_w / _h}";
		};
		
		dbg_view("Display", _startVisible, 8, 27, 400, 500);
		
		dbg_section("Core", true);
		dbg_watch(ref_create(self, "__display"), "Display");
		dbg_watch(ref_create(self, "__window"), "Window");
		dbg_watch(ref_create(self, "__appSurf"), "Application Surface");
		dbg_watch(ref_create(self, "__gui"), "GUI");
		
		array_foreach(__views, function(_view, _i) {
			dbg_section($"View {_i}", (_i == 0));
			dbg_watch(ref_create(_view, "__visible"), "Visible");
			dbg_watch(ref_create(_view, "__size"), "Size");
			dbg_watch(ref_create(_view, "__pos"), "Position");
		});
		
		__Refresh();
		call_later(1, time_source_units_frames, __Refresh, true);
	})(_startVisible);
}

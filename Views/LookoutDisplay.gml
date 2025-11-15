
#region __private

function __LookoutDisplayParam(_name, _value, _setter) {
	if ((_value != self[$ _name]) and (_value != self[$ $"{_name}Prev"])) {
		self[$ _name] = _value;
		self[$ $"{_name}Prev"] = _value;
	}
	else if (self[$ _name] != self[$ $"{_name}Prev"]) {
		_setter(self[$ _name]);
		self[$ $"{_name}Prev"] = self[$ _name];
	}
}
function __LookoutDisplayGetWH(_w, _h) {
	return $"{_w}x{_h}";
}
function __LookoutDisplayGetWHAR(_w, _h) {
	return $"{_w}x{_h}: {_w / _h}";
}

#endregion

/// @func LookoutDisplay()
/// @param {Bool} startVisible? Whether the debug view should start visible (true) or not (false). [Default: true]
/// @desc Shows display, window, surface, GUI, and view information in a Display debug view.
/// Call anywhere in the project.
function LookoutDisplay(_startVisible = true) {
	static __ = new (function(_startVisible) constructor {
		__display = {
			__size: undefined,
			__gui: undefined,
			__appSurf: undefined,
			__orientation: undefined,
			__frequency: undefined,
			__dpi: undefined,
			__timingMethod: undefined,
			__timingMethodPrev: undefined,
			__sleepMargin: undefined,
			__sleepMarginPrev: undefined,
		};
		__window = {
			__pos: undefined,
			__size: undefined,
			__fullscreen: window_get_fullscreen(),
			__border: window_get_showborder(),
			__cursor: window_get_cursor(),
			__cursorPrev: window_get_cursor(),
			__caption: window_get_caption(),
			__captionPrev: window_get_caption(),
		};
		__views = array_create_ext(8, function(_i) {
			return {
				__visible: undefined,
				__pos: undefined,
				__size: undefined,
			};
		});
		
		__Refresh = function() {
			with (__display) {
				__size = __LookoutDisplayGetWHAR(display_get_width(), display_get_height());
				__gui = __LookoutDisplayGetWHAR(display_get_gui_width(), display_get_gui_height());
				__appSurf = __LookoutDisplayGetWHAR(surface_get_width(application_surface), surface_get_height(application_surface));
				switch (display_get_orientation()) {
					case display_landscape: __orientation = "Landscape"; break;
					case display_landscape_flipped: __orientation = "Landscape Flipped"; break;
					case display_portrait: __orientation = "Portrait"; break;
					case display_portrait_flipped: __orientation = "Portrait Flipped"; break;
				};
				__frequency = $"{display_get_frequency()}hz";
				__dpi = __LookoutDisplayGetWHAR(display_get_dpi_x(), display_get_dpi_y);
				
				__LookoutDisplayParam("__timingMethod", display_get_timing_method(), display_set_timing_method)
				__LookoutDisplayParam("__sleepMargin", display_get_sleep_margin(), display_set_sleep_margin)
			}
			
			with (__window) {
				__pos = __LookoutDisplayGetWH(window_get_x(), window_get_y);
				__size = __LookoutDisplayGetWHAR(window_get_x(), window_get_y);
				if (__fullscreen != window_get_fullscreen()) {
					window_set_fullscreen(__fullscreen);
				}
				if (__border != window_get_showborder()) {
					window_set_showborder(__border);
				}
				
				__LookoutDisplayParam("__cursor", window_get_cursor(), window_set_cursor);
				__LookoutDisplayParam("__caption", window_get_caption(), window_set_caption);
			}
			
			array_foreach(__views, function(_view, _i) {
				_view.__visible = (view_visible[_i] ? "True" : "False");
				var _cam = view_camera[_i];
				_view.__pos = __LookoutDisplayGetWH(camera_get_view_x(_cam), camera_get_view_y(_cam));
				_view.__size = __LookoutDisplayGetWHAR(camera_get_view_width(_cam), camera_get_view_height(_cam));
				_view.__port = $"Pos: {view_get_xport(_i)},{view_get_yport(_i)}. Size: {view_get_wport(_i)}x{view_get_hport(_i)}"
			});
		};
		
		dbg_view("Lookout: Display", _startVisible, 8, 27, 400, 600);
		
		// display
		dbg_section("Display", true);
		dbg_watch(ref_create(__display, "__size"), "Size");
		dbg_watch(ref_create(__display, "__gui"), "GUI");
		dbg_watch(ref_create(__display, "__appSurf"), "Application Surface");
		dbg_watch(ref_create(__display, "__orientation"), "Orientation");
		dbg_watch(ref_create(__display, "__frequency"), "Frequency");
		dbg_watch(ref_create(__display, "__dpi"), "DPI");
		
		static _timingMethods = [tm_sleep, tm_countvsyncs, tm_countvsyncs_winalt, tm_systemtiming];
		static _timingMethodNames = ["Sleep", "Count VSyncs", "Count Vsyncs Winalt", "System Timing"];
		dbg_drop_down(ref_create(__display, "__timingMethod"), _timingMethods, _timingMethodNames, "Timing Method");
		
		dbg_slider_int(ref_create(__display, "__sleepMargin"), 0, 20, "Sleep Margin");
		
		// window
		dbg_section("Window", true);
		dbg_watch(ref_create(__window, "__pos"), "Position");
		dbg_watch(ref_create(__window, "__size"), "Size");
		dbg_checkbox(ref_create(__window, "__fullscreen"), "Fullscreen");
		dbg_checkbox(ref_create(__window, "__border"), "Border");
		
		{static _cursors = [
			cr_none,
			cr_default,
			cr_arrow,
			cr_cross,
			cr_beam,
			cr_size_nesw,
			cr_size_ns,
			cr_size_nwse,
			cr_size_we,
			cr_uparrow,
			cr_hourglass,
			cr_appstart,
			cr_handpoint,
			cr_size_all,
		];}
		{static _cursorNames = [
		    "None",
		    "Default",
		    "Arrow",
		    "Cross",
		    "Beam",
		    "Size NESW",
		    "Size NS",
		    "Size NWSE",
		    "Size WE",
		    "Up Arrow",
		    "Hourglass",
		    "App Start",
		    "Hand Point",
		    "Size All"
		];}
		dbg_drop_down(ref_create(__window, "__cursor"), _cursors, _cursorNames, "Cursor");
		
		dbg_text_input(ref_create(__window, "__caption"), "Caption");
		
		array_foreach(__views, function(_view, _i) {
			dbg_section($"View {_i}", (_i == 0));
			dbg_watch(ref_create(_view, "__visible"), "Visible");
			dbg_watch(ref_create(_view, "__pos"), "Position");
			dbg_watch(ref_create(_view, "__size"), "Size");
			dbg_watch(ref_create(_view, "__port"), "Port");
		});
		
		__Refresh();
		call_later(1, time_source_units_frames, __Refresh, true);
	})(_startVisible);
}

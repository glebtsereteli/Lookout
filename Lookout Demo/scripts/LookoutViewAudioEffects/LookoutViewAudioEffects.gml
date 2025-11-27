// feather ignore all

/// @func LookoutAudioEffects()
/// @param {bool} [startVisible=true] Whether the debug view starts visible (true) or not (false).
///
/// @desc Provides controls for all 8 audio effects on the main audio bus in a "Lookout: Audio Effects" debug view.
/// Includes type selection and parameter tweaking. Automatically listens for remote changes to audio effects
/// and updates the interface accordingly.
///
/// Call this function once at the start of the game.
function LookoutAudioEffects(_startVisible = true) {
	static __ = new (function(_startVisible) constructor {
		__Refresh = function() {
			dbg_set_view(__view)
			array_foreach(__effects, function(_effect) {
				_effect.__Refresh();
			});
		};
		
		call_later(1, time_source_units_frames, function() {
			if (not is_debug_overlay_open()) return;
			
			__Refresh();
		}, true);
		
		__view = dbg_view("Lookout: Audio Effects", _startVisible, 16, 35, 420, 500);
		__effects = array_create_ext(8, function(_i) {
			return new __LookoutAudioEffect(_i);
		});
		__Refresh();
	})(_startVisible);
}

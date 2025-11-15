
/// @func LookoutInstances()
/// @param {Bool} startVisible? Whether the debug view should start visible (true) or not (false). [Default: true]
/// @desc Displays the overall and per object amounts of instances in an Instances debug overlay view.
/// Call anywhere in the project.
function LookoutInstances(_startVisible = true) {
	static __ = new (function(_startVisible) constructor {
		__objects = array_map(asset_get_ids(asset_object), function(_obj) {
			return {
				__ref: _obj,
				__name: object_get_name(_obj),
				__n: undefined,
			};
		});
		__totalInstances = undefined;
		__view = dbg_view("Lookout: Instances", _startVisible, 16, 35, 400, 500);
		__section = undefined;
		
		__Refresh = function() {
			__totalInstances = instance_count;
			array_foreach(__objects, function(_obj) {
				_obj.__n = instance_number(_obj.__ref);
			});
			array_sort(__objects, function(_a, _b) {
				var _diff = sign(_b.__n - _a.__n);
				return ((_diff != 0) ? _diff : ((_b.__name > _a.__name) ? -1 : +1));
			});
			
			if (__section != undefined) {
				dbg_section_delete(__section);
			}

			dbg_set_view(__view);
			__section = dbg_section($"Total: {instance_count}");
			array_foreach(__objects, function(_obj) {
				if (_obj.__n > 0) {
					dbg_watch(ref_create(_obj, "__n"), _obj.__name);
				}
			});
		};
		
		__Refresh();
		call_later(1, time_source_units_frames, function() {
			if (not is_debug_overlay_open()) return;
			if (instance_count == __totalInstances) return;
			
			__Refresh();
		}, true);
	})(_startVisible);
}

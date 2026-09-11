// feather ignore all

function __LookoutInstances() : __LookoutView("Instances", 375, 500) constructor {
	// Shared
	static __Init = function() {
		dbg_set_view(__view);
		dbg_section("Controls");
		dbg_text_input(ref_create(self, "__filter"), "Filter");
		dbg_same_line();
		dbg_button("Clear", method(self, function() {
			__filter = "";
		}), 50, 19);
		dbg_checkbox(ref_create(self, "__showZero"), "Show empty");
		
		__Refresh();
	};
	static __Refresh = function() {
		var _changed = (instance_count != __totalInstances);
		for (var _i = 0, _n = array_length(__watchNames); _i < _n; _i++) {
			var _name = __watchNames[_i];
			var _value = self[$ _name];
			if (_value != __watchPrev[$ _name]) {
				__watchPrev[$ _name] = _value;
				_changed = true;
			}
		}
		
		if (not _changed) return;
		
		__totalInstances = instance_count;
		
		array_foreach(__objects, function(_obj) {
			with (_obj) {
				__n = instance_number(__ref);
				if (__n != __nPrev) {
					__nDelta = __n - __nPrev;
				}
				__nPrev = __n;
			}
		});
		array_sort(__objects, function(_a, _b) {
			var _diff = sign(_b.__n - _a.__n);
			return ((_diff != 0) ? _diff : ((_a.__name > _b.__name) ? +1 : -1));
		});
		
		if (__section != undefined) {
			dbg_section_delete(__section);
		}
		dbg_set_view(__view);
		__section = dbg_section($"Total: {instance_count}");
		
		var _filter = string_lower(__filter);
		var _filtered = (_filter != "");
		for (var _i = 0, _n = array_length(__objects); _i < _n; _i++) {
			var _obj = __objects[_i];
			if ((_obj.__n <= 0) and not __showZero) continue;
			if (_filtered and (string_pos(_filter, string_lower(_obj.__name)) == 0)) continue;
			
			_obj.__display = _obj.__n;
			if (_obj.__nDelta != 0) {
				_obj.__display = $"{_obj.__display} ({(_obj.__nDelta > 0) ? "+" : "-"}{abs(_obj.__nDelta)})";
			}
			
			dbg_watch(ref_create(_obj, "__display"), _obj.__name);
			if (_obj.__n > 0) {
				dbg_same_line();
				dbg_button("Destroy", method({ ref: _obj.__ref }, function() {
					instance_destroy(ref);
				}), 60, 19);
			}
		}
	};
	
	// Custom
	__objects = array_map(asset_get_ids(asset_object), function(_obj) {
		return {
			__ref: _obj,
			__name: object_get_name(_obj),
			__n: 0,
			__nPrev: 0,
			__nDelta: 0,
			__display: undefined,
		};
	});
	__totalInstances = undefined;
	__filter = "";
	__showZero = false;
	
	__watchNames = ["__filter", "__showZero"];
	__watchPrev = {};
	array_foreach(__watchNames, method(self, function(_name) {
		__watchPrev[$ _name] = self[$ _name];
	}));
	
	__section = undefined;
}


// Limit this object to a single instance (singleton):
if (instance_number(object_index) > 1) {
	instance_destroy();
	exit;
}

// Initialize Lookout views:
LookoutResources(false);
LookoutInstances(false);
LookoutDisplay(false);
LookoutRooms(false);
LookoutAudioEffects(true);

// Initialize demo views:
dbg_view("Demo: Resources", false, 16, 35, 300, 850); {
	global.partSystem = part_system_create();
	
	Res = function(_name, _creator, _destructor) constructor {
		creator = _creator;
		destructor = _destructor;
		pool = [];
		
		array_push(other.resources, self);
		
		static Add = function() {
			array_push(pool, creator());
		};
		static Clear = function() {
			array_foreach(pool, function(_ds) {
				destructor(_ds);
			});
			pool = [];
		};
		
		dbg_text_separator(_name);
		var _w = 50;
		var _h = 20;
		dbg_button("Add", function() {
			Add();
		}, _w, _h);
		dbg_same_line();
		dbg_button("Remove", function() {
			if (array_length(pool) > 0) {
				destructor(array_pop(pool));
			}
		}, _w, _h);
		dbg_same_line();
		dbg_button("Clear", function() {
			Clear();
		}, _w, _h);
	};
	
	resources = [];
	dbg_section("Controls"); {
		var _w = 100;
		var _h = 20;
		dbg_button("Random Fill", function() {
			repeat (irandom_range(10, 50)) {
				method_call(choose, resources).Add();
			}
		}, _w, _h);
		dbg_same_line();
		dbg_button("Clear All", function() {
			array_foreach(resources, function(_res) {
				_res.Clear();
			});
		}, _w, _h);
	} 
	dbg_section("Resources"); {
		new Res("DS List", ds_list_create, ds_list_destroy);
		new Res("DS Map", ds_map_create, ds_map_destroy);
		new Res("DS Queue", ds_queue_create, ds_queue_destroy);
		new Res("DS Grid", function() {
			return ds_grid_create(1, 1);
		}, ds_grid_destroy);
		new Res("DS Priority", ds_priority_create, ds_priority_destroy);
		new Res("DS Stack", ds_stack_create, ds_stack_destroy);
		new Res("MP Grid", function() {
			return mp_grid_create(0, 0, 1, 1, 1, 1);
		}, mp_grid_destroy);
		new Res("Buffer", function() {
			return buffer_create(1, buffer_fixed, 1);
		}, buffer_delete);
		new Res("Vertex Buffer", vertex_create_buffer, vertex_delete_buffer);
		new Res("Surface", 
			function() { return surface_create(1, 1); }, 
			surface_free
		);
		new Res("Audio Emitter", audio_emitter_create, audio_emitter_free);
		new Res("Audio Sync Group",
			function() {
				return audio_create_sync_group(true);
			},
			audio_destroy_sync_group
		);
		new Res("Particle System", part_system_create, part_system_destroy);
		new Res("Particle Emitter",
			function() { return part_emitter_create(global.partSystem); }, 
			function(_emitter) { part_emitter_destroy(global.partSystem, _emitter); }
		);
		new Res("Particle Type", part_type_create, part_type_destroy);
		new Res("Time Source", 
			function() { return time_source_create(time_source_global, 1, time_source_units_frames, function() {}); },
			time_source_destroy
		);
		new Res("Camera", camera_create, camera_destroy);
	}
	dbg_section("Assets"); {
		new Res("Sprite",
			function() {
				return sprite_duplicate(sprDemo);
			},
			sprite_delete
		);
		new Res("Path", path_add, path_delete);
		new Res("Font", 
			function() {
				return font_add("fntDemo.ttf", 10, false, false, 32, 128);
			},
			font_delete
		);
		new Res("Animation Curve", animcurve_create, animcurve_destroy);
		new Res("Timeline", timeline_add, timeline_delete);
	}
}
dbg_view("Demo: Instances", false, 16, 35, 250, 320); {
	Obj = function(_ref) constructor {
		ref = _ref;
		pool = [];
		
		array_push(other.objects, self);
		
		static Spawn = function() {
			var _pad = 100;
			var _x = random_range(_pad, room_width - _pad);
			var _y = random_range(_pad, room_height - _pad);
			var _inst = instance_create_depth(_x, _y, -1000, ref);
			array_push(pool, _inst);
		};
		
		dbg_text_separator(object_get_name(ref));
		var _w = 70;
		var _h = 20;
		dbg_button("Spawn", function() {
			Spawn();
		}, _w, _h);
		dbg_same_line();
		dbg_button("Destroy", function() {
			if (array_length(pool) > 0) {
				instance_destroy(array_pop(pool));
			}
		}, _w, _h);
		dbg_same_line();
		dbg_button("Clear", function() {
			array_foreach(pool, function(_inst) {
				instance_destroy(_inst);
			});
			pool = [];
		}, _w, _h);
	};
	
	dbg_section("Controls"); {
		var _w = 100;
		var _h = 20;
		dbg_button("Random Fill", function() {
			repeat (irandom_range(10, 50)) {
				method_call(choose, objects).Spawn();
			}
		}, _w, _h);
		dbg_same_line();
		dbg_button("Destroy All", function() {
			instance_destroy(objDemoParent);
		}, _w, _h);
		
		objects = [];
		new Obj(objDemoParrot);
		new Obj(objDemoPenguin);
		new Obj(objDemoOwl);
		new Obj(objDemoSnake);
		new Obj(objDemoGorilla);
	}
}

audio_play_sound(sndElevatorMusic, 0, true);

// feather ignore all

function __LookoutRooms() : __LookoutView("Rooms", 420, 414) constructor {
	// Shared
	static __Init = function() {
		dbg_section("Control");
		dbg_drop_down(ref_create(self, "__room"), __rooms, __names, "Room");
		
		var _size = 19;
		dbg_same_line();
		dbg_button("-", function() {
			var _index = array_get_index(__rooms, room) - 1;
			if (_index == -1) _index = __n - 1;
			
			__GoTo(__rooms[_index]);
		}, _size, _size);
		dbg_same_line();
		dbg_button("+", function() {
			var _index = array_get_index(__rooms, room) + 1;
			if (_index == __n) _index = 0;
			
			__GoTo(__rooms[_index]);
		}, _size, _size);
		
		var _w = 127;
		dbg_watch(ref_create(self, "__size"), "Size");
		dbg_button("Restart", function() { __GoTo(room); }, _w, _size);
		dbg_same_line();
		dbg_button("First", function() { __GoTo(room_first); }, _w - 1, _size);
		dbg_same_line();
		dbg_button("Last", function() { __GoTo(room_last); }, _w - 1, _size);
		
		__history.__Init();
	};
	static __Refresh = function() {
		if (__prevRoom != room) {
			__room = room;
			__prevRoom = __room;
			__history.__Add(room);
		}
		if (__room != __prevRoom) {
			__GoTo(__room);
		}
		__size = $"{room_width}x{room_height}";
	};
	
	// Custom
	__rooms = asset_get_ids(asset_room);
	__names = array_map(__rooms, function(_room, _index) {
		return $"{_index}: {room_get_name(_room)}";
	});
	__n = array_length(__rooms);
	__prevRoom = room;
	__room = room;
	__size = undefined;
	__history = new __LookoutRoomsHistory();
	
	static __GoTo = function(_room) {
		room_goto(_room);
		__room = _room;
		__prevRoom = __room;
		__history.__Add(_room);
	};
}

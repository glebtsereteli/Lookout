// feather ignore all

function __LookoutView(_name, _w = 300, _h = 300) constructor {
	__name = _name;
	__w = _w;
	__h = _h;
	__view = undefined;
	
	static __Refresh = __LookoutNoop;
	static __Init = __LookoutNoop;
	
	static __Show = function() {
		__view = dbg_view($"Lookout: {__name}", true, LOOKOUT_VIEW_X, LOOKOUT_VIEW_Y, __w, __h);
		__Init();
		
		return self;
	};
	
	static __Hide = function() {
		dbg_view_delete(__view);
		__view = undefined;
		
		return self;
	};
	
	static __Tick = function() {
		__Refresh();
	};
}

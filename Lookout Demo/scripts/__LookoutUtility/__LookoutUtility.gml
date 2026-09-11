// feather ignore all

/// @ignore
function __LookoutLog(_message) {
	show_debug_message($"{__LOOKOUT_LOG_PREFIX} {_message}.");
}
/// @ignore
function __LookoutError(_message) {
	static _divider = string_repeat("=", 100);
	show_error($"\n\n{_divider}\n[{__LOOKOUT_NAME} {__LOOKOUT_VERSION}] ERROR.\n\n\n{_message}.\n{_divider}\n\n", true);
}

/// @ignore
function __LookoutCreateView(_name, _visible, _w, _h) {
	__view = dbg_view(_name, _visible, LOOKOUT_VIEW_X, LOOKOUT_VIEW_Y, _w, _h);
}
/// @ignore
function __LookoutMod2(_dividend, _divisor) {
    return (_dividend - floor(_dividend / _divisor) * _divisor);
}
/// @ignore
function __LookoutNoop() {}

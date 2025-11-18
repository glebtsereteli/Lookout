// feather ignore all

function __LookoutLog(_message) {
	show_debug_message($"{__LOOKOUT_LOG_PREFIX} {_message}.");
}
function __LookoutError(_message) {
	static _divider = string_repeat("=", 100);
	show_error($"\n\n{_divider}\n[{__LOOKOUT_NAME} {__LOOKOUT_VERSION}] ERROR.\n\n\n{_message}.\n{_divider}\n\n", true);
}

// feather ignore all

function __LookoutLog(_message) {
	show_debug_message($"{__LOOKOUT_LOG_PREFIX} {_message}.");
}
function __LookoutError(_message) {
	static _divider = string_repeat("=", 100);
	show_error($"\n\n{_divider}\n[{__LOOKOUT_NAME} {__LOOKOUT_VERSION}] ERROR.\n\n\n{_message}.\n{_divider}\n\n", true);
}

function __LookoutMod2(_dividend, _divisor) {
    return (_dividend - floor(_dividend / _divisor) * _divisor);
}
function __LookoutGetAudioEffectTypes() {
	static _types = [
		AudioEffectType.Reverb1,
		AudioEffectType.Delay,
		AudioEffectType.Bitcrusher,
		AudioEffectType.LPF2,
		AudioEffectType.HPF2,
		AudioEffectType.Gain,
		AudioEffectType.Tremolo,
		AudioEffectType.EQ,
		AudioEffectType.PeakEQ,
		AudioEffectType.HiShelf,
		AudioEffectType.LoShelf,
		AudioEffectType.Compressor,
	];
	return _types;
}

# Lookout
A collection of useful Debug Views for GameMaker.

## Views

* **Resources**. Displays `"ResourceCounts"` and `"DumpMemory"` data from [debug_event()](https://manual.gamemaker.io/monthly/en/GameMaker_Language/GML_Reference/Debugging/debug_event.htm). Helps track memory leaks from data structures, surfaces, buffers, particles, time sources, and other runtime-created assets that can be accidentally left undisposed.
* **Instances**. Displays the overall and per-object instance counts, including differences between frames, with an option to destroy objects. Helps track existing objects and their instance amounts to identify objects that are out of place.
* **Display**. Provides defailed information and controls for display, window, application surface, and views. Inspired by Pixelated Pope's [display_write_all_specs()](https://github.com/PixelatedPope/HelpfulGMLScripts/blob/master/Camera%20and%20Views/display_write_all_specs.gml).
* **Rooms**. Provides controls over room switching and displays room history. Useful for quickly switching between rooms for testing and identifying unintentional room changes.

## Credits
* Thanks to [Omar Cornut](https://www.miracleworld.net/) for making the infinitely useful [Dear ImGui](https://github.com/ocornut/imgui) and to the GameMaker team for implementing it in the [Debug Overlay](https://manual.gamemaker.io/monthly/en/GameMaker_Language/GML_Reference/Debugging/The_Debug_Overlay.htm).
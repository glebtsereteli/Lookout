# Lookout vX.X.X (PRE-RELEASE WIP)

Lookout is a compact [Free and Open Source](https://en.wikipedia.org/wiki/Free_and_open-source_software) GameMaker library offering a variety of [Debug Overlay](https://manual.gamemaker.io/monthly/en/GameMaker_Language/GML_Reference/Debugging/The_Debug_Overlay.htm) for identifying common, but often hard to diagnose problems.

These views have proven invaluable for tracking bugs and memory leaks across many projects. Use them alongside the [Debugger](https://manual.gamemaker.io/monthly/en/IDE_Tools/The_Debugger.htm) to quickly identify and resolve issues in your games.

## Views

* **Resources**. Displays `"ResourceCounts"` and `"DumpMemory"` data from [debug_event()](https://manual.gamemaker.io/monthly/en/GameMaker_Language/GML_Reference/Debugging/debug_event.htm). Helps track memory leaks from data structures, surfaces, buffers, particles, time sources, and other runtime-created assets that can be accidentally left undisposed.
* **Instances**. Displays the overall and per-object instance counts, including differences between frames, with an option to destroy objects. Helps track existing objects and their instance amounts to identify objects that are out of place.
* **Display**. Provides defailed information and controls for display, window, application surface, and views. Inspired by Pixelated Pope's [display_write_all_specs()](https://github.com/PixelatedPope/HelpfulGMLScripts/blob/master/Camera%20and%20Views/display_write_all_specs.gml).
* **Rooms**. Provides controls over room switching and displays room history. Useful for quickly switching between rooms for testing and identifying unintentional room changes.

## Usage

1. Download the `.yymps` local package from the latest [Release](https://github.com/glebtsereteli/Lookout/releases/v1.0.0) page if you'd like to install all available views or grab individual `.gml` scripts from the [Views](https://github.com/glebtsereteli/Lookout/tree/main/Views) folder. 
2. Import the local package (or individual `.gml` scripts) into your project.
3. Call the view functions you'd like to use at the start of your game.
4. Run the game and find your views under the Views menu in the top bar of the [Debug Overlay](https://manual.gamemaker.io/monthly/en/GameMaker_Language/GML_Reference/Debugging/The_Debug_Overlay.htm).

## Credits
* Thanks to [Omar Cornut](https://www.miracleworld.net/) for making the infinitely useful [Dear ImGui](https://github.com/ocornut/imgui) and to the GameMaker team for implementing it in the [Debug Overlay](https://manual.gamemaker.io/monthly/en/GameMaker_Language/GML_Reference/Debugging/The_Debug_Overlay.htm).
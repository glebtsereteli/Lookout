
<img width="1280" height="300" alt="banner" src="https://github.com/user-attachments/assets/ff3e8122-2e01-4c94-9419-aead1907452d" />

# Lookout v1.0.0

Lookout is a compact [Free and Open Source](https://en.wikipedia.org/wiki/Free_and_open-source_software) GameMaker library offering a variety of [Debug Overlay](https://manual.gamemaker.io/monthly/en/GameMaker_Language/GML_Reference/Debugging/The_Debug_Overlay.htm) views for identifying common but often hard-to-diagnose problems.

These views have proven invaluable for tracking bugs and memory leaks across many projects. Use them alongside the [Debugger](https://manual.gamemaker.io/monthly/en/IDE_Tools/The_Debugger.htm) to quickly identify and resolve issues in your games.

* **GameMaker Version**: [v2024.14](https://releases.gamemaker.io/release-notes/2024/14) (the latest Monthly).
* **Platforms**: All but HTML5.

## Views

* `LookoutResources()`. Displays `"ResourceCounts"` and `"DumpMemory"` data from [debug_event()](https://manual.gamemaker.io/monthly/en/GameMaker_Language/GML_Reference/Debugging/debug_event.htm). Helps track memory leaks from data structures, surfaces, buffers, particles, time sources, and other runtime-created assets that can be accidentally left undisposed.
* `LookoutInstances()`. Displays the overall and per-object instance counts, including differences between frames, with an option to destroy objects. Helps track existing objects and their instance counts to identify misplaced instances.
* `LookoutDisplay()`. Provides detailed information and controls for display, window, application surface, and views. Inspired by [Pixelated Pope](https://www.pixelatedpope.com/)'s [display_write_all_specs()](https://github.com/PixelatedPope/HelpfulGMLScripts/blob/master/Camera%20and%20Views/display_write_all_specs.gml).
* `LookoutRooms()`. Provides controls over room switching and displays room history. Useful for quickly switching between rooms for testing and identifying unintentional room changes.

## Usage

1. Download the `.yymps` local package from the latest [Release](https://github.com/glebtsereteli/Lookout/releases/v1.0.0).
2. Import the `Lookout v1.0.0.yymps` local package into your project via the *Tools ➜ Import Local Package* menu in the top toolbar, or just drag and drop the file into GameMaker.
3. Call any of the functions listed above at the start of your game to activate their corresponding views. Refer to each function's JSDoc comments for details.
4. Access your views under the Views menu in the top bar of the [Debug Overlay](https://manual.gamemaker.io/monthly/en/GameMaker_Language/GML_Reference/Debugging/The_Debug_Overlay.htm).

## Credits
* Wonderful promo art by the very talented [neerikiffu](https://bsky.app/profile/neerikiffu.bsky.social)!
* Thanks to [Omar Cornut](https://www.miracleworld.net/) for making the infinitely useful [Dear ImGui](https://github.com/ocornut/imgui) and to the GameMaker team for implementing it in the [Debug Overlay](https://manual.gamemaker.io/monthly/en/GameMaker_Language/GML_Reference/Debugging/The_Debug_Overlay.htm).
* Demo art by [Kenney](https://kenney.nl) the ✨*Asset Jesus*✨.

## Games Using Lookout
* [DirtWorld](https://krankenhaus-uk.itch.io/dirtworld) by [Joe Baxter-Webb/Indie Game Clinic/KRANKENHAUS](https://indiegameclinic.com/).
* Many other projects using early parts of the library.
* And more to come :)

## Upcoming Views

These are the views I plan to add in the future.

| View | Status | Comments |
| --- | --- | --- |
| Layers | Coming soon | - |
| Steam | Coming soon | - |
| System | Coming soon | - |
| Physics | Coming soon | - |
| Audio Effects | Coming soon | - |
| Asset Search | Coming soon | - |
| FMOD | Maybe | Niche |
| Twitch | Maybe | Niche |

# v1.2

- The Armory no longer stutters each time it recolors an item you hover: the mod refills its kept color textures instead of making new ones, which made the game wait for its renderer (one 7-15 ms frame per recolor in real play).
- New color textures are made only when none of the size is free, two spares at a time, so after the first recolors of a session none are made.
- New analyses go to the disk cache a few seconds after the last recolor while no preview is shown, spread over frames, instead of rewriting the whole file (up to 1.4 MB) on the frame of a recolor.
- Reading the disk cache at the first recolor of a session is spread over frames too.
- The log gives each recolor's apply time and how many textures it made.
- Played in joined missions and the Armory; measured in live play: 0.008 ms per frame in missions and 0.013 on the ship, and a frame over 2 ms in 3.5% of seconds on the ship and in the Armory, at most 5.6 ms (v1.1: 24-31%, mostly 7-15 ms).
- Known: the first new item of a session still opens the game's data in one frame (63 ms once in live play).

# v1.1

- First public release, renamed from Helmet Color Match: the log, the disk cache and the Mod Options Menu settings take the new name, so a test build's settings start from the defaults once.
- Only colors change now: every helmet and armor keeps its own material (metal, shine, fabric weave, wear, camo pattern), so fabric no longer turns to chrome or gold and shiny helmets stay shiny.
- Decals and patterns on recolored parts stay visible.
- Accents such as stripes and colored trims take the other item's accent color, even very small ones, or keep their own color when it has none.
- Painted patterns, such as the yellow stripes many helmets and armors share, take the other item's accent color too, and an item whose accent is a pattern passes that color on.
- A paint going to black, grey or white leaves no tint behind: its shading colors follow it instead of turning brown or teal.
- Every helmet and armor in the game was measured in the Armory, for which parts show, how much, and how each paint looks there; the mod ships that table and matches what you see.
- Parts the Armory never shows no longer count, so the Cinderblock's hidden lime and the cape mount's yellow no longer reach a helmet.
- Each part gets the color that makes it look like the other item, glossy and metal parts included, so the Salamander is as dark as the Doubt Killer's plates instead of lighter grey.
- Sheen and highlights no longer count as paint: armors matched to the Obedient stay dark instead of turning pale, and the Doubt Killer's glossy red trim gives red, not pink.
- An armor's main color is its most visible paint, its undersuit counting half, so the Fire Fighter gives its grey plates and never its tan padding.
- A dark armor with large light plates reads as those plates, so helmets matched to the Cinderblock are light grey like its chest plate.
- A small but visible emblem counts as an armor's accent, so the Cinderblock's orange reaches the Battle Master's stripes.
- A part that already matches one of the armor's main colors keeps it, so the Battle Master's light crest no longer turns black.
- The helmet's main part takes the armor's main color, a dark color goes to a dark part and a light one to a light part.
- An armor's undersuit black only goes to a helmet's dark parts now, so dark armors no longer turn white shells or grey panels black.
- A large area never takes a small trim color: a black cap with a gold band now gives a dark armor instead of a gold one.
- A dark but vivid red trim counts as an armor's accent, and a large muted part such as a tan hood is matched like a main part instead of taking the accent color.
- Armor and helmets released after the measurement keep the earlier model of what shows and how it looks.
- The measurement adds about 330 KB to the mod, read once at startup (about 1.5 ms offline); nothing runs per frame for it.
- Helmets and armor with large ID masks are analysed without a 2 MB buffer and with more pause points, for shorter frames while a new item is read.
- The disk cache also keeps the game's shared detail samples, so color matching needs no game file once an item was seen; older cache files are rebuilt once.
- The Armory's character view and the game's other UI previews of your Helldiver now show the matched colors too, including an item you hover; the Armory's thumbnails keep their original colors.
- Idle cost: one more 8-byte memory read every 4th frame to see whether such a preview is shown, and two reads every frame while it is.
- Tested offline on all 42,660 helmet and armor pairs and in the game on the ship and in the Armory (the sixteen pairs reported from play); not yet in a mission.
- Measured in real play: an earlier v1.1 build took 0.025 ms per frame on the ship, plus one frame of 7 to 15 ms each time the Armory preview recolors an item you hover; v1.0 took 0.012 ms per frame in missions.
- Steam build 25480438 only; requires Bingus Shared Loader v18 or newer.

# v1.0

- Recolors your helmet to match your armor, or your armor to match your helmet (Mod Options Menu: Color Matching).
- Colors come from the game's own files at runtime, so new armor and helmets work as released; nothing per item ships with the mod.
- Matching keeps visors, lenses, lights and skin as they are, keeps dark undersuits dark and copies whole paint rows (color, wear, metal, camo).
- Leaves complete sets (helmet and armor of the same set) unchanged unless you turn that off.
- Only your own Helldiver changes; other players never change, and they see your original colors.
- Remembers each helmet's and armor's analysis on disk (HelmetColorMatch.cache), so after the first time the recolor appears within a couple of frames of load-in.
- Puts the recolor back if the game ever restores an original color texture on your Helldiver.
- Idle cost: one memory read per frame (two with a preview slot), plus two reads every 30 frames; no allocation.
- Steam build 25480438 only; requires Bingus Shared Loader v18 or newer.
- Licensed under the Zero-Clause BSD license (0BSD).

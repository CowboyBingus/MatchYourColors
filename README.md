# Match Your Colors v1.1

Your helmet takes your armor's colors, or your armor takes your helmet's. Pick the direction in the MODS tab of
the escape menu (Mod Options Menu): **Color Matching**: Off, Helmet Matches Armor (default) or Armor Matches
Helmet.

The colors come from the game's own files while you play: for every helmet and armor the mod reads its paint,
wear, metal and camo rows and works out which paint of one fits which paint of the other. It also ships a
measurement of every helmet and armor in the game as the Armory shows it (which parts show and how much, how each
paint looks there), so a match follows what you see: a part you never see does not count and a glossy or metal
part gets the color that makes it look right. Armor and helmets released after that measurement still work, with
the earlier model of what shows.

**Status:** v1.0 was played in the game. v1.1 is tested offline on all 42,660 helmet and armor pairs and was
checked in the game on the ship and in the Armory's character view (the sixteen pairs reported from play, an item
hovered there); not yet in a mission. See [docs/TECHNICAL.md](docs/TECHNICAL.md).

## What changes

- **Helmet Matches Armor:** the helmet's main paint takes the armor's main color and its other paint takes the
  armor's other colors in the same light/dark relation; a large area never takes a small trim color.
- **Armor Matches Helmet:** the same the other way; dark undersuits stay dark.
- Only colors change: each item keeps its own material (metal, shine, fabric weave, wear, camo pattern), its decals
  and the shapes of its painted patterns. Visors, lenses, lights and skin keep their colors.
- Accents such as stripes, colored trims and painted patterns take the other item's accent color, even small ones,
  or keep their own when it has none.
- **Leave Complete Sets** (on by default): a helmet and armor from the same set keep their original colors.
- Only your own Helldiver changes: in the ship, in missions, and in the game's UI previews of your Helldiver such as
  the Armory's character view, including an item you hover there. The Armory's thumbnails keep their original
  colors. Other players' Helldivers never change.

## Multiplayer

The recolor is drawn on your screen only. The game sends other players only which helmet and armor you wear, and
each game draws them from its own data, so other players see your original colors (with or without the mod).

## Requirements and install

- Helldivers 2 Steam build **25480438** (EXE 1.8.46015.0). The mod checks the game.dll and EXE hashes and every
  engine function it calls, and does nothing on any other build.
- [Bingus Shared Loader v18 or newer](https://github.com/CowboyBingus/BingusSharedLoader/releases/latest).
- Optional: [Mod Options Menu](https://github.com/CowboyBingus/ModOptionsMenu/releases/latest) for the settings.
  Without it the defaults apply (Helmet Matches Armor, complete sets unchanged).

Import the release ZIP into Arsenal or HD2MM together with the loader, enable and deploy both, then restart the
game. Keep the shared loader as the winning Wwise startup replacement. The log is
`%LOCALAPPDATA%\CowboyBingus\Helldivers2\Logs\MatchYourColors.log`.

## Cost

On an idle frame the mod makes one memory read of your Helldiver's equipment slots (two when the game keeps a
preview slot for you), plus two reads every 30 frames per recolored texture to check the recolor is still on, plus
one 8-byte read every 4th frame to see whether a UI preview of your Helldiver is shown (two reads every frame while
it is), and allocates nothing.
When your equipment changes it works out the colors in the background, aiming at 1.5 ms of work per frame, and
applies them in one frame. It changes no game code, writes no game memory and never changes your equipment.

The first time it sees a helmet or armor it reads that item's colors from the game's files. In real play with
v1.0 that took 7 to 45 ms of work over 4 to 25 frames per item, and 64 to 181 ms over 31 to 37 frames (one frame
22 ms) for the two armors with large ID masks. v1.1 pauses inside every compressed chunk and no longer allocates a buffer the
size of the mask; it is not yet measured in the game. The analysis is kept in `MatchYourColors.cache` beside the
log, so an item seen before is recolored within a frame or two (2 ms of work). Fitting the colors of a new pair
takes up to about 5 ms of work in the game's Lua engine outside the game.

Measured in real play: v1.0 took 0.012 ms per frame in missions and 0.008 ms on the ship, with about 48 KB of
compiled Lua code. A v1.1 build before the measured appearance took 0.025 ms per frame on the ship, and applying a
recolor took one frame of 7 to 15 ms, once for each item you hover in the Armory. The measurement table is read once
at startup (about 1.5 ms outside the game, unmeasured in game).

## Build and test

`python -B scripts/build.py` runs every test in a LuaJIT and in the game's own `lua51.dll` (including the parity
test: the Lua matcher and color transfer against the research pipeline on all 293 helmets and armors, all 42,660
plans and the fitted colors of 287 of them, read from the installed game's files), then builds `releases/Match-Your-Colors-v1.1.zip`. `--test` also builds the live
test build (never publish it).

## License

Zero-Clause BSD (0BSD): use, copy, modify and distribute for any purpose, with no conditions. See `LICENSE`.

**AI disclosure:** Claude Opus 5.5 did the research, implementation, tests and documentation.

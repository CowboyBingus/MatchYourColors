# Match Your Colors v1.5

Your helmet takes your armor's colors, or your armor takes your helmet's, or both take your cape's or one of the
game's weapon paint schemes; your cape can follow. Pick them in the MODS tab of the escape menu (Mod Options Menu):
**Color Matching**: Off, Helmet Matches Armor (default), Armor Matches Helmet or Helmet and Armor Match Cape;
**Paint Scheme**: Off (default) or one of the 12 schemes. Five toggles beside them: **Leave Complete Sets**, **Recolor Hoods**, **Match Materials**,
**Recolor Cape** and **Recolor Weapons**; **Recolor Squadmates**: Off (default), Squadmates Without the Mod or Everyone;
**Squadmates' Colors**: Their Own Gear (default) or Your Colors; and **Hide Cape**: Off (default), Your Cape or
Everyone's Capes. Squadmates who use this mod see your colors and you theirs (**Sync With Mod Users**, always on,
below).

The colors come from the game's own files while you play: for every helmet and armor the mod reads its paint,
wear, metal and camo rows and works out which paint of one fits which paint of the other. It also ships a
measurement of every helmet and armor in the game as the Armory shows it (which parts show and how much, how each
paint looks there), so a match follows what you see: a part you never see does not count and a glossy or metal
part gets the color that makes it look right. Armor and helmets released after that measurement still work, with
the earlier model of what shows.

**Status:** played in the game on the ship, in the Armory's character view and in joined missions (v1.0 and v1.2),
and tested offline on all 42,660 helmet and armor pairs. v1.3's options were checked in the game in test sessions
(Recolor Hoods, Match Materials and Paint Scheme in the Armory; Sync With Mod Users with the test build's own value
through the real lobby; two LUT mods) and sync played between a host and a client, each seeing the other's colors. v1.3 was also
checked on screen in the Armory on 40 pairs (metal and vivid colors, and the pairs reported in manual testing), on
both body types and from the front, both sides and the rear: the recolored part ends a median 3 to 6 CIEDE2000 from
the other item's color in every view, and independent reviews of all the renders found the looks they flagged fixed;
mission lighting is not yet checked. Recolor Cape is tested offline on all 118 capes and was checked in the Armory on 23
outfits from the front and behind (tints, emblems and marks kept readable, recolored emblem sheets), and an independent
review of the renders cleared them. v1.4's Helmet and Armor Match Cape and SEAF scheme were checked on screen in
test sessions over many rounds of random helmet, armor and cape combinations in the Armory and on the ship (every
cape at least once, both body types, front, sides and rear, SEAF beside the game's SEAF troopers), with independent
reviews of the renders, and played on the ship and in the Armory; not yet played in missions. v1.5's color rules
were checked on screen in the Armory and on the ship over six rounds of renders (front, sides and rear) with
independent reviews and a comparison with v1.3 and v1.4 on 20 problem armors, the Cowboy Hat mod was recolored in the
game, and a test session ran on the ship and in one solo mission; Recolor Squadmates is tested offline only (a
simulated squad lobby). See [docs/TECHNICAL.md](docs/TECHNICAL.md).

## What changes

- **Helmet Matches Armor:** the helmet's main paint takes the armor's main color and its other paint takes the
  armor's other colors in the same light/dark relation; a large area never takes a small trim color.
- **Armor Matches Helmet:** the same the other way; dark undersuits stay dark, except on an armor that shows almost
  nothing but its suit (such as the O-3 Free Spirit), whose suit takes the helmet's colors.
- Either way, a vivid color covering a tenth of the other item or more, but less of it than that item's main color
  (the FS-05 Marksman's red), reaches plates and other parts; other vivid colors (the PH-9 Predator's red beret) stay
  accents, and clothing and brown leather, tan or khaki parts never take them. Clothing never takes a colored metal's flat
  paint (gold reads as mustard on cloth): it takes the other item's nearest plain color.
- **Helmet and Armor Match Cape:** both take the colors of the cape you wear (in the Armory, the cape you preview):
  the main color of its outside goes to your main parts, its second and accent colors to plates, trims and accents,
  and dark gloves, boots and straps stay dark. A cape of essentially one color repaints your gear's own colored parts
  and stripes too. The cape keeps its own colors (Recolor Cape does nothing in this mode).
- Only colors change: each item keeps its own material (metal, shine, fabric weave, wear, camo pattern), its decals
  and the shapes of its painted patterns, unless Match Materials is on. Visors, lenses, lights, glowing parts and
  skin keep their colors.
- **Paint Scheme** (Off by default): paints helmet and armor in one of the game's weapon paint schemes: Helldiver,
  Forest, Forest Camo, Arctic, Arctic Camo, Desert, Desert Camo, Urban, Urban Camo, Night, Venus or SEAF. The
  scheme's main paint goes where the item's main color is, its second paint and cloth color where they fit; the camo
  schemes bring their camo. SEAF is the game's SEAF trooper colors, matched against SEAF troopers in the game: plates
  and helmet shells slate blue, clothing grey, and vests, straps, pouches, padding, gloves, boots and colored visors
  black or dark. While a scheme is chosen, Color Matching and Leave Complete Sets do not apply; Recolor Hoods and
  Match Materials do.
- Accents such as stripes, colored trims and painted patterns take the other item's accent color, even small ones;
  a speck of accent (under 1% of the other item) recolors a bigger part only within its hue family. When it has no
  vivid accent, accents take its other colors as the matching gives them, small ones and patterns its second color; an
  item of one color (such as the all-dark AC-2 Obedient) leaves them their own. Light neutral painted patterns (such as
  the CM-14 Physician's cream panels) take the other item's nearest neutral color when it has two or more.
- **Leave Complete Sets** (on by default): a helmet and armor from the same set keep their original colors.
- **Recolor Hoods** (on by default): turned off, the hood of a hooded helmet (RS-100 Sanctioner, AC-2 Obedient,
  DS-10 Big Game Hunter, IE-12 Righteous, the SC-30 Trailblazer Scout helmets) keeps its own color like the visor;
  its mask and trims still match, as they would with the hood recolored.
- **Match Materials** (off by default): turned on, a bare-metal part that takes a painted color becomes that paint
  (the paint's metal, shine and gloss), so a chrome, steel or gold helmet with a white or green armor turns white or
  green instead of bronze or gold. It changes metal parts of at least 5% of the item and metal accents; bolts, rims
  and other small metal details keep their material. The other way, a hard painted part that takes a helmet's or
  armor's bare metal becomes that metal: the B-22 Model Citizen's chrome and the AD-26 Bleeding Edge's cobalt show as
  chrome and cobalt on the other item, no smoother than the game's usual metal (mirror chrome stays on parts made for
  it). Cloth, undersuits and the darker parts that only share a color never turn into metal. A cape's metallic color carries its metal the same way: under the Eye of Liberty your hard parts turn gold
  metal and your clothing takes the cape's black. A large colored part of an armor takes only a color covering a tenth
  of the helmet or cape (the O-44 Bonded Pilot's red-brown plates stay the RS-100 Sanctioner's black, not its small
  gold).
- An armor that would turn one color takes the other item's (or the cape's) second color on its clothing, a dark
  color on its straps, pouches and gloves and the accent on its trims, all from the other item's own colors. A second
  color must cover a tenth of that item (a twentieth for black or dark grey); without one the armor stays as matched,
  never a made-up shade. Prosthetic arms and legs (SA-12, SA-25, SA-32) take a dark color of the other item or keep
  their own.
- **Recolor Cape** (off by default): turned on, your cape takes the colors your recolored item takes: the armor's
  with Helmet Matches Armor, the helmet's with Armor Matches Helmet, the scheme's with a Paint Scheme. Its outside,
  stripes, sashes, lining and tinted bands (such as United in Equality's purple) are matched like a helmet's parts, so
  a red lining such as the Cover of Darkness's takes one of those colors too. Emblems and marks stay readable: one that
  would blend into the cloth around it takes the color that stands out most (by its lightness, or by its color when
  your colors are equally dark, as the UF-50 Bloodhound's red and black). A design drawn light on dark (or dark on
  light) keeps that contrast: on the Bloodhound it takes its silver, not a red as dark as the cloth; when none of your
  colors keeps it visible it takes a light or dark grey of its new background (Proof of Faultless Virtue and Botslayer
  with the FS-38 Eradicator's olive). An emblem printed from the cape's emblem
  sheet (such as the Drape of Glory's) takes it in a copy of that sheet, the rest of the sheet as it is. The cape keeps
  its design's shapes and its cloth, which takes your colors as they show in the game, its sheen counted. A complete
  set that Leave Complete Sets keeps as it is still gives its colors to the cape.
- **Recolor Weapons** (off by default): turned on, your primary, sidearm and support weapon take your colors the way
  the game's weapon paint schemes repaint a weapon: body, details and trims, attachments and magazines, in the colors
  your helmet and armor take (the armor's, the helmet's or the cape's); when those colors include a camo, the weapon
  takes it too. The steel the game's schemes keep stays steel, and lenses and lights keep their colors. With one of the game's weapon paint schemes as Paint Scheme, your weapons wear that scheme as the game
  paints it. In the Armory, the weapon you look at and the WEAPON CUSTOMIZATION preview follow; a reload, respawn or
  new mission keeps the colors. Grenades and backpacks keep theirs.
- Your own Helldiver changes in the ship, in missions, and in the game's UI previews of your Helldiver such as the
  Armory's character view, including an item you hover there. The Armory's thumbnails keep their original colors.
- Helmets and armors changed by other mods (LUT edits: recolored helmets, glowing visors) are read as the game shows
  them: the mod recolors from the modded colors and keeps a modded glowing visor glowing. A part whose finish (shine,
  metal) a mod changed, and an item whose shape a mod replaced, are matched by the model instead of the Armory
  measurement. Transmog mods that rebuild an item at runtime are followed: a rebuilt item gets its own recolor.
  Modded LUTs, paint schemes included, can be in the game's half-float format or in 32-bit floats.
- Modded helmets and armor whose colors are painted into their texture instead of the game's color table (such as
  the Cowboy Hat mod) give their colors and take yours: the mod reads up to 8 colors from that texture (BC1 or BC3)
  as they look in the game and recolors a copy of it, keeping its shading, grain and metal. Parts of the same color change together. Such a
  material the mod cannot read (another texture format) keeps its look, and the log names it and why.

## Multiplayer

The game sends other players only which helmet and armor you wear, and each game draws them from its own data,
so players without this mod see your original colors.

**Sync With Mod Users** (always on; no option) lets players who use this mod see each other's colors: your
settings (Color Matching, Paint Scheme and the toggles; no colors, names or other data) are stored as a value of
your squad's online lobby, and the mod reads the values of the squadmates who use it too and recolors their
Helldivers on your screen with their settings, their capes too when they turned Recolor Cape on, and their weapons
when they turned Recolor Weapons on (both of you need 1.5 or newer for weapons). Squadmates need 1.3 or newer; on
1.3 they see your gear in its own colors while you use Helmet and Armor Match Cape, and with your Color Matching
instead of the SEAF scheme. From 1.5 the settings are stored in a form later options can extend without a new lobby
value; the 1.3-1.4 form is stored beside it for older copies. Players without the mod see no change and are not recolored. It makes your use of the
mod visible to anyone who reads the lobby's data. Squadmates are matched by their game account id (played between a
host and a client); the log notes a squadmate who shares settings but whose Helldiver it cannot find.

**Recolor Squadmates** (Off by default) recolors squadmates on your screen only, with your own settings:
**Squadmates Without the Mod** does it for squadmates who do not share settings (players without this mod, or with
a version before 1.3), while those who share keep theirs; **Everyone** does it for every squadmate. Nobody else sees
it, and it is not shared with the lobby. A squadmate who dies keeps their colors ready for when they respawn in the
same gear. The squad cards of the loadout screen show each player's Helldiver in the colors you see them in during
the mission.

**Squadmates' Colors** decides which colors those squadmates take. **Their Own Gear** (default) applies your Color
Matching to their own gear: with Armor Matches Helmet their armor takes their own helmet's colors, so a squadmate in a
matching set barely changes. **Your Colors** gives their helmet and armor your colors: those of the item your Color
Matching matches (your armor with Helmet Matches Armor, your helmet with Armor Matches Helmet, your cape with Helmet
and Armor Match Cape), so the squad matches you; their cape (with Recolor Cape) and weapons (with Recolor Weapons) take
them too. With a Paint Scheme every squadmate takes the scheme either way.

**Hide Cape** (Off by default) hides capes on Helldivers on the ship and in missions. **Your Cape** hides yours,
on your screen and on the screens of squadmates who use this mod (it is shared like your colors);
**Everyone's Capes** also hides every squadmate's cape on your screen. Players without this mod still see your
cape. The Armory and the squad cards of the loadout screen keep showing capes, so you can still pick one. It works
with Color Matching off too, and turning it off shows the capes again.

## Requirements and install

- Helldivers 2 Steam build **25480438** (EXE 1.8.46015.0). The mod checks the game.dll and EXE hashes and every
  engine function it calls, and does nothing on any other build.
- [Bingus Shared Loader v18 or newer](https://github.com/CowboyBingus/BingusSharedLoader/releases/latest).
- Optional: [Mod Options Menu](https://github.com/CowboyBingus/ModOptionsMenu/releases/latest) for the settings.
  Without it the defaults apply (Helmet Matches Armor, no paint scheme, complete sets unchanged, hoods recolored,
  materials kept, cape unchanged, squadmates unchanged, weapons unchanged).

Import the release ZIP into Arsenal or HD2MM together with the loader, enable and deploy both, then restart the
game. Keep the shared loader as the winning Wwise startup replacement. The log is
`%LOCALAPPDATA%\CowboyBingus\Helldivers2\Logs\MatchYourColors.log`.

## Cost

On an idle frame the mod makes one memory read of your Helldiver's equipment slots, plus one on every other frame
when the game keeps a body-copy slot for you, two reads every 30 frames to check one recolored texture is still on
(each texture in turn), one 16-byte read every 4th frame to see whether a UI preview of your Helldiver is shown (one
read every frame while it is), and every 2 seconds about 20 reads to check your Helldiver and equipment; it
allocates nothing.
When your equipment changes it works out the colors in the background, aiming at 1.5 ms of work per frame (with a
pause point at least every 0.5 ms of work outside the game), and applies them in one frame of their own, the one
after the work ends. A file read the disk does not answer at once lets the work wait a frame instead of holding the
game's frame. A respawn binds the existing colors to the new units at once. It keeps its color textures and refills
them for the next colors: making a texture makes the game wait for its renderer (about one frame), so the textures a
session needs are made while the game loads (75 in under 4 ms, in a loading frame) and later only when none of the
size is free. The game files it reads while you browse the Armory are closed a few at a time afterwards. It changes
no game code, writes no game memory and never changes your equipment.

Every 120 frames (Sync With Mod Users, always on) it reads the squad's lobby (7 memory reads, one PlayFab member list
and one member value per squadmate, read from PlayFab's local copy of the lobby) while your Helldiver exists, and
posts your settings only when they change (once per lobby, five seconds after the last change and once the lobby has
stayed joined for ten seconds). While a squadmate's Helldiver is recolored, one
memory read of their equipment slots runs on 1 frame in 4 and two reads per texture every 30 frames. Between lobby
reads nothing is allocated; a lobby read allocates a few hundred bytes. Unmeasured in game.

Recolor Weapons adds nothing while it is Off. On, it reads your weapon slots (48 bytes) on 1 frame in 4, and while a
recolored weapon is in your hands one 8-byte read every frame of its color texture's slot: the game puts the
weapon's own colors back on every reload, and the mod binds its colors again on the next frame. A reload, respawn,
new mission or pickup of a weapon already recolored binds the existing colors again (about 15 reads per weapon); new
weapons or paint work out their colors in the background like an item's. In the Armory its preview check shares the
UI preview's read. A squadmate who shares Recolor Weapons adds two reads on their turn of
the squadmate check and four on their binding check (two of them make sure the game has not moved their weapons'
record to another place, which it does when a Helldiver dies). It allocates nothing on frames without a change.
Unmeasured in game.

Recolor Squadmates adds nothing while it is Off. On, a squadmate it recolors costs what a sharing squadmate does: the
lobby read every 120 frames also finds their Helldiver (27 memory reads in all with one such squadmate, 13 without),
then one memory read on 1 frame in 4 and two every 30 frames. Their recolor runs as a squadmate's job does. It makes
no memory-protection checks on any frame. Unmeasured in game.

A modded helmet or armor without a color table (v1.5) adds no per-frame work. The first time a session sees it, the
mod reads one 256 x 256 level of its texture and groups its colors (about 2 ms of work outside the game for the
Cowboy Hat's kind of texture, up to 19 ms for a texture of random colors); a new look rewrites a copy of the whole
texture (about 1.4 ms outside the game for a 2048 x 2048 texture, up to 77 ms), with a pause point at least every
0.9 ms outside the game. The copy is one more texture of its size to make or refill (2.8 MB for 2048 x 2048, with up
to one free copy kept), and the analysis is read again each session (not cached). In the game, making the Cowboy
Hat's copy took 4.3 to 7.8 ms on the frame it was applied in the Armory (2026-10-14); a later look refills a free copy
instead, and those applies took 0.1 to 0.5 ms (four looks). The reading and rewriting work is unmeasured in game.

The first job of a session lists the installed mods' patch files and reads their tables of contents (two reads per
patch file) to find the textures, materials and units they replace. In later sessions an item that mods change is
checked against only the bytes this mod read from their files, not the whole files (a modded mesh is never read), and
a modded ID mask larger than the game's is read at a 512 x 512 mip.

Recolor Cape adds no per-frame work of its own: the cape is among the equipment slots the mod reads anyway, and with
the option on it is one to three more recolored textures (the cape's tint has one of its own, and a recolored emblem a
copy of the cape's emblem sheet), checked in the same rotation as the others (two reads every 30 frames, whatever their
number). The first time it sees a cape it reads the cape's colors and one small level of its pattern, gradient and
emblem sheet textures: about 23 ms of work outside the game, spread over frames with 99% of the stretches between
pause points under 0.4 ms. When an emblem needs a new color, the work reads the cape's whole emblem sheet (5.6 MB, kept
for the session while it is the last one read), copies it and recolors the emblem: about 10 ms of work outside the
game, spread over frames. That is up to about 17 MB of memory outside the game's Lua heap (the sheet and the last two
recolored copies) and 5.6 MB on the graphics card for each copy shown. Unmeasured in game.

The first time it sees a helmet or armor it reads that item's colors from the game's files. In real play with
v1.0 that took 7 to 45 ms of work over 4 to 25 frames per item, and 64 to 181 ms over 31 to 37 frames (one frame
22 ms) for the two armors with large ID masks. v1.1 pauses inside every compressed chunk and no longer allocates a buffer the
size of the mask. In real play with v1.2 a new item's frames stayed at a few ms at most (9 ms once), except the
first analysis of a session, whose opening of the game's data took one 63 ms frame. The analysis is kept in `MatchYourColors.cache` beside the
log, so an item seen before is recolored within a frame or two (2 ms of work). Fitting the colors of a new pair
takes up to about 5 ms of work in the game's Lua engine outside the game.

Measured in real play: v1.0 took 0.012 ms per frame in missions and 0.008 ms on the ship, with about 48 KB of
compiled Lua code. A v1.1 build before the measured appearance took 0.025 ms per frame on the ship, and applying a
recolor took one frame of 7 to 15 ms, once for each item you hover in the Armory. v1.2 refills kept textures
instead: 0.008 ms per frame in missions and 0.013 ms on the ship, and a frame over 2 ms in 5.8% of seconds on the
ship and in the Armory (3.5% counting that launch's mission time too, which had none), at most 5.6 ms (that v1.1
build: 24-31%); applying a recolor takes 0.05-0.13 ms, or up to 5 ms when it has to make new textures. The measurement table is read once at startup (about 1.5 ms outside the
game, unmeasured in game). New analyses are written to the cache file a few seconds after the last recolor, while
no preview is shown, spread over frames.

v1.4 in 7 minutes of real play on the ship and in the Armory (Helmet and Armor Match Cape with SEAF): applying a
recolor took 0.56-0.61 ms at the median and 1.33 ms at most, no texture was made during play, and one frame of its
work went over 2 ms (2.3 ms, an Armory item's first analysis). In the same scripted test session as v1.3, no frame of
its work went over 2 ms outside loading (v1.3: one of 2.2 ms) and applying took at most 1.5 ms (v1.3: 2.1 ms). Its
per-frame cost in real play is not measured yet.

## Build and test

`python -B scripts/build.py` runs every test in a LuaJIT and in the game's own `lua51.dll` (including the parity
test: the Lua matcher and color transfer against the research pipeline on all 293 helmets and armors, all 42,660
plans and the fitted colors of 287 of them, the hooded helmets' 1,620 plans with their hoods kept and the 9,346 plans
Match Materials changes, read from the installed game's files, and every cape's rows and its plans against six
helmets and armors: 118 capes, 702 plans), the paint schemes, a synthetic LUT mod and the Cover of Darkness on the
real game data, sync against a simulated PlayFab lobby, then builds `releases/Match-Your-Colors-v1.5.zip`.
`--test` also builds the live test build (never publish it). `python -B scripts/make_fixtures.py --quality` judges the
shipped planner and color fit on every pair (`research/quality.py`, results in `research/results/quality13.json`).

## License

Zero-Clause BSD (0BSD): use, copy, modify and distribute for any purpose, with no conditions. See `LICENSE`.

**AI disclosure:** Claude Opus 5.5 did the research, implementation, tests and documentation.

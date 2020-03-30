Thank you for downloading CS2D!
(...and for actually reading a readme file)

CS2D is freeware
Copyright © 2002-2019 Unreal Software
www.UnrealSoftware.de
www.CS2D.com

- Using Sounds/Textures from the original Counter-Strike Copyright © Valve Corporation

- Using BNetEx Copyright © Oliver Skawronek & Inkubus

- Using Lua Copyright © 1994–2010 Lua.org, PUC-Rio.
  License: http://www.lua.org/license.html
  
 
Please read Changelog.txt for a list of changes!

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

How to use:

- Please extract/unzip or install before playing
- Run CS2D or Launcher to start the game
- Visit www.CS2D.com/faq if you have any problems

Command line parameters (order does not matter):

-full / -fullscreen (Run in full-screen mode)
-win / -windowed (Run in windowed mode [Default])
-dx / -directx (Use DirectX [Windows only])
-gl / -opengl (Use OpenGL [Default])
-16bit (Use 16 bit colordepth)
-24bit (Use 24 bit colordepth [Default for Linux])
-32bit (Use 32 bit colordepth [Default for Win/Mac])
-w X (Screen resolution width [Default: 850])
-h Y (Screen resolution height [Default: 480])
-noopenal (disable OpenAL audio drivers)
-nosfx (disable loading of audio files)
-j ADDRESS / -join ADDRESS (Join a server)
-pw PW / -password PW (join or host with this password)
-map MAP (Host with this map)
-name NAME (Host with this name)
-maxplayers MAXPL (Host with this max players amount)*
-port PORT (Host on this port)*
-rcon PW (Host with this remote control password)*
-lua LUAFILE (Host with this Lua file, relative to "sys/lua/"-folder)
-nointro (Don't show the intro sequence)
-sys PATH (Use alternative "sys"-folder for settings)
-path PATH (Use alternative working directory)**
-offline / -off (Offline mode, no U.S.G.N. connection)
-nocache (Never load the cached serverlist)
-realport (Use this if players are not able to join via serverlist)
-rconlua (Allow to execute Lua via RCon. WARNING! SECURITY RISK!)
-mod "PATH,PATH,..." (Load media data from this/these mod folder(s), comma separated)
-systemmouse (Use the mouse pointer from the OS instead of CS2D's pointer)

*) setting will become unchangeable at runtime
**) new directory must contain all required CS2D files
ATTENTION: Do not use any whitespaces!
Use ? (question mark) instead of spaces (for paths etc)

Example Commandline:
CS2D.exe -map de_dust -pw SECRETPASS -win

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Editor Controls:

- Left Click: Set tile / entity
- Right Click  Select tile for drawing / context menu
- Middle Click: Rotate tile

- W/A/S/D or Cursor Keys: Scroll map
- Home/Pos1: Scroll to tile 0|0
- G: Enable/Disable tile grid
- Del (while pointing at entity): Remove entity
- Ctrl + C (while pointing at entity): Copy entity
- Ctrl + X (while pointing at entity): Cut entity
- Ctrl + V: Paste copied entity to current mouse position
- Ctrl + Z: Undo latest action(s) (tile operations only)
- Ctrl + Shift + Del: Remove ALL entities
- Shift (hold while resizing sprite): Keep w/h ratio
- Space (hold): Show areas, trigger relations, tile modes/modifiers
- 1: Distance tool
- 2: Path distance tool
- 3: Pathfinder tool
- 4: Tile blender tool
- 5: Decal painter tool
- F12: Test map (also works in-game to return to editor)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

TERMS OF USE:

THIS SOFTWARE IS PROVIDED "AS IS"
AND COMES WITH ABSOLUTELY NO WARRANTY.
USE THIS SOFTWARE AT YOUR OWN RISK!

YOU ARE ALLOWED TO COPY AND SHARE THIS GAME FOR FREE.
YOU ARE NOT ALLOWED TO SELL THIS GAME OR PARTS OF IT.

IT IS FORBIDDEN TO MODIFY OR MANIPULATE CS2D.EXE!
FURTHERMORE IT IS FORBIDDEN TO MODIFY ANY DATA OF THE GAME
IN THE SYSTEM MEMORY/RAM WHILE IT IS RUNNING.
IT IS NOT ALLOWED TO REVERSE ENGINEER CS2D.

ANY USAGE OF PROGRAMS WHICH SOMEHOW CHANGE THE WAY THIS
GAME WORKS AND RUNS (HACKS/CHEATS) IS NOT ALLOWED.
THE GAME CONTAINS AUTOMATED CHECKS WHICH MAY AUTOMATICALLY
BAN YOUR U.S.G.N. ACCOUNT WHEN USING SUCH ILLEGAL PROGRAMS!

IT IS NOT ALLOWED TO SEND MESSAGES/REQUESTS TO CS2D
CLIENTS/SERVERS OR THE UNREAL SOFTWARE GAMING NETWORK
MASTER SERVER IN ORDER TO CAUSE DAMAGE/CONFUSION/ERRORS.

YOU DO NOT HAVE THE PERMISSION TO USE AND RUN THIS GAME
IF YOU DO NOT AGREE WITH THESE TERMS AND CONDITIONS.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Special thanks to:

Simonas 'SQ' Kuzmickas - code
DarkShadow - many dropped weapon images
Heavy - death notice weapon images
DivineDominion - CS2D guys pyramide image
Dairy - weapon buy menu images
Aregger 'k.o.g.' Benjamin - code/security support
Vertex & Inkubus - UDP network module "BNetEX"
KimKat - for awesome laserbeam1.bmp
FaqAp - for M134 and FN F2000 skin/sound
Klin - code support
Starkkz - LuaJIT integration support
mafia_man - UTF-8 language file support, code/security support
smn - Currently used player/weapon skin pack (http://unrealsoftware.de/files_show.php?file=14223)
Reaxter - Spanish translation (http://www.unrealsoftware.de/files_show.php?file=10363)
EngiN33R - Russian translation (http://www.unrealsoftware.de/files_show.php?file=10356)
BetaM - Polish translation (http://www.unrealsoftware.de/files_show.php?file=10378)
Light Corner - Czech translation (http://www.unrealsoftware.de/files_show.php?file=10598)
HaNwKs - Portuguese (Brazil) translation (http://www.unrealsoftware.de/files_show.php?file=10355)
buraxia3 - Turkish translation (http://www.unrealsoftware.de/files_show.php?file=10833)
Rian2_idih - Indonesian translation (http://www.unrealsoftware.de/files_show.php?file=10403)
Alistaire - Dutch translation (http://www.unrealsoftware.de/files_show.php?file=10359)
Happy Camper - Swedish translation (http://www.unrealsoftware.de/files_show.php?file=11638)
G-Unit - Romanian translation (http://www.unrealsoftware.de/files_show.php?file=13971)
Silverlike3 - French Translation (http://www.unrealsoftware.de/files_show.php?file=15034)
useigor - Russian translation (using real Russian UTF-8 letters)
ZxC - Italian translation (http://www.unrealsoftware.de/files_show.php?file=16078)
Marcell - Hungarian translation (http://www.unrealsoftware.de/files_show.php?file=12023)
Eternal - Thai translation (http://www.unrealsoftware.de/files_show.php?file=11703)
SlimPT - Portuguese (Portugal) translation (http://www.unrealsoftware.de/files_show.php?file=14920)
joni agent - Finnish translation (http://www.unrealsoftware.de/files_show.php?file=12835)

UnrealSoftware.de community - bug reports, ideas, feedback

YOU - for playing this game and being awesome

and many others	- for many other things

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

More info and help at the offical CS2D website
www.CS2D.com

Unreal Software Gaming Network (U.S.G.N.)
www.USGN.de

More games, official CS2D forums and custom files at
www.UnrealSoftware.de

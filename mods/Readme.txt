The mods folder is a new feature introduced with CS2D v 1.0.0.2!
It allows you to easily create and manage custom files which are used instead of the original graphics/sounds, as well as Lua scripts and configs.
This new system makes mods possible without actually touching or replacing the original game files.

For this to work you just have to do the following:

- create a folder for your mod inside the "mods"-folder (name it whatever you want)
- create a "gfx" and/or "sfx" folder inside that folder
- put files with the same names as in the original "sfx" and "gfx" folders inside the folder
- this works also with files in subfolders of "gfx"/"sfx"! Just make sure the folder structure is the same
- Start CS2D and select the mods in the mods menu. If you start a server you can also enable server-sided mods (all clients will receive and see/hear the mod skins/sounds!)
- (OPTIONAL) create a "lua" folder and create a file called "main.lua" - it will be executed on start! more info below
- (OPTIONAL) create a file called "config.cfg" in the mod folder to execute those commands on game start
- (OPTIONAL) create a file called "mod.txt" to give information about a mod. each line has one property (name=My Mod; description=My super mod; etc.). it is recommended to provide a name, description, author and version

Keep in mind:

- Only works for main skins/sounds of the game
- Custom sounds and sprites used in Lua scripts and maps will still be loaded from the original folder
- Maps or settings are NOT loaded from mod folders either
- Mod files do NOT need to be added to servertransfer.lst! (you will even get an error message for trying)

Lua information:

- as always, mod Lua files are only executed when you start a server with a mod (no client-sided Lua script execution)
- main.lua has two special global variables:
    - MOD_DIR is a string containing the path to the current mod folder - not the lua folder! (includes trailing slash)
    - MOD_INFO is a table containing all the information from mod.txt - keys are the property names and values are their values
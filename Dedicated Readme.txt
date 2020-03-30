Readme Document for CS2D Dedicated Server
Please read the WHOLE text BEFORE(!) using this software!
web: www.CS2D.com / www.UnrealSoftware.de

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Note:

Make sure that you have the right and latest version.
The dedicated server is available for Windows and Linux!
The latest version is available at www.CS2D.com/download

Unreal Software assumes no liability for any damages or
problems caused by this software. Use at your own risk!
It is forbidden to modify the executable/binary file!

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

How to use:

 - get CS2D (www.CS2D.com/download)
 - extract CS2D to a folder of your choice
 - extract "cs2d_dedicated" to the same folder
 - Linux: make sure to set the correct rights (chmod)
 - run "cs2d_dedicated"

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Additional Information:

 - Read www.CS2D.com/serverhosting

 - Don't forget to setup your router/firewall!
   Please read www.CS2D.com/faq for details!
 
 - You don't have to upload the whole CS2D folder if you
   want to run the dedicated server on a server!
   The dedicated server does not need the files in the
   "gfx" and "sfx" folders. However if you want to allow
   maptransfer you have to upload all media files which are
   used in maps you run on your server. Otherwise maptransfer
   is not going to work properly.
   The "logos" folder is required unless you disable the
   spraylogo transfer!

 - Use CS2D to setup your server settings as you like.
   Also have a look at "options" -> "more"! All settings are
   saved in the "sys" folder. The dedicated server works
   exactly like the regular CS2D game client. Both use the 
   same configuration files.

 - Write all maps you want to use on your server to the
   file "sys\mapcycle.cfg"!

 - You probably have to install the "libstdc++" library on
   Linux systems in order to run "cs2d_dedicated"!
   You may also need more/other libraries.

 - Read the logfiles in "sys\logs" if you have problems
   with your dedicated server ("debuglog" has to be "1")

 - Use the commandline parameters -port and -maxplayers if
   you want to make these values unchangable. This is useful
   if you setup a server for others and if you don't want
   them to change these settings.
   Please read www.CS2D.com/faq for details!

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

More info and help at the offical CS2D website
www.CS2D.com

Unreal Software Gaming Network (U.S.G.N.) for CS2D
www.USGN.de

More games, the official CS2D forums and custom maps at
www.UnrealSoftware.de
**You need a decorate script installed for this to not crash when placing furniture**

in `customScripts.lua` add 
```lua
decorateHelp = require("custom.decorateHelp")
kanaFurniture = require("custom.kanaFurniture")
kanaHousing = require("custom.kanaHousing")
require("custom.furnitureHelper")
```

place files in `server/scripts/custom`

to spawn with the furniture tool put your name inside `config.names` at the top of furnitureHelper or to just spawn one use `player->additem furn_selection_tool 1` in console  or in chat `/placeat pid furn_selection_tool`

`/dh` to open decorate menu.

use `/fsm` to turn on furniture selection mode and then actvite or hit any object with the furniture selection tool (looks like stendars hammer) which will be added to your inventory automatically on login if you are an admin/name required player.

tip for selecting objects like banners that you can't activate or hit is to open your inventory and then click on it with your cursor (need to be fairly close)

use `/fdm` to turn on furniture deletion mode and then hit any object with the furniture selection tool (looks like stendars hammer) to disable objects and `/undo` to re-enable them. It's meant to be used with kanahousing in cells that the player owns (cell won't reset). (kanahousing required for this to work for now)

`/furn` will bring up the furniture menu for purchasing and using furniture.

`/house` general house menu

`/adminhouse` admin house menu


**old commands that still work in case you need to add something that you can't select by activating or hitting. using `/fsm` is much easier**


to create a new category

```/ac category```


to select an existing category and add a piece of furniture

```
/af category category

/af name name 

/af refid refid

/af price price

/af addfurn
```

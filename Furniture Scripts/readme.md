in `customScripts.lua` add 
```lua
kanaFurniture = require("custom.kanaFurniture")
require("custom.furnitureHelper")
```

place both files in `server/scripts/custom`


use `/fsm` to turn on furniture selection mode and then actvite or hit any object with the furniture selection tool (looks like stendars hammer) which will be added to your inventory automatically on login if you are an admin/name required player.

`/furn` will bring up the furniture menu for purchasing and using furniture.


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

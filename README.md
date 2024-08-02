## Dependencies
### QBCore
### PS/QB Inventory

## Overlay Images
### Open the Index.html file located in the NUI folder. Place your FIVERMERR image url in the src="" of the img tag.

## Place the images in IMAGES TO ADD inside of your inventory images folder.

## Add the below to your qbcore\shared\items.lua
```
['gopro'] = {
    ['name'] = 'gopro',
    ['label'] = 'GoPro 11',
    ['weight'] = 500,
    ['type'] = 'item',
    ['image'] = 'gopro.png',
    ['unique'] = false,
    ['useable'] = true,
    ['shouldClose'] = false,
    ['combinable'] = nil,
    ['description'] = 'A GoPro to record SICK things'
},
["bodycam"] = {
    ["name"] = "bodycam",
    ["label"] = "PD Body Camera",
    ["weight"] = 20,
    ["type"] = "item",
    ["image"] = "bodycam.png",
    ["unique"] = false,
    ["useable"] = true, 
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Body Camera"
},
```

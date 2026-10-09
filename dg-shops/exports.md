# Exports

## Client

```lua
-- Opens a shop. The player must be close to it.
exports['dg-shops']:openShop(shopId)

-- Closes the shop UI.
exports['dg-shops']:closeShop()

-- true while the shop UI is open.
local open = exports['dg-shops']:isShopOpen()
```

## Server

```lua
-- Owner identifier of a shop, or nil when nobody owns it.
local owner = exports['dg-shops']:getShopOwner(shopId)

-- Balance of an owned shop, or 0.
local balance = exports['dg-shops']:getShopBalance(shopId)

-- Adds money to a shop balance (a negative amount removes it).
-- Returns false if the shop doesn't exist, isn't owned, or the balance would go below 0.
local ok = exports['dg-shops']:addShopBalance(shopId, amount)

-- true if the player owns or works at the shop.
local staff = exports['dg-shops']:isShopStaff(source, shopId)
```

`shopId` is the `id` of a location in `config/shops.lua`, e.g. `'247_innocence'`.

## Example: open a shop from your own target

```lua
exports.ox_target:addBoxZone({
    coords = vec3(24.47, -1346.62, 29.5),
    size = vec3(1.5, 1.5, 2.0),
    options = {
        {
            label = 'Open shop',
            icon = 'fa-solid fa-store',
            onSelect = function()
                exports['dg-shops']:openShop('247_innocence')
            end,
        },
    },
})
```

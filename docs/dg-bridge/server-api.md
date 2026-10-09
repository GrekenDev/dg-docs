# Server API

Server functions, available as `Bridge.*` once your resource loads `@dg-bridge/imports/server.lua` (see [Installation](installation.md#using-dg-bridge-in-your-own-scripts)). `source` is always the player's server ID.

Money functions take the account names `'cash'`, `'bank'` and `'black'`; dg-bridge maps them to your framework (see [Money accounts](configuration.md#money-accounts)).

## Players

```lua
local player     = Bridge.getPlayer(source)        -- normalised player, or nil
local raw        = Bridge.getPlayerData(source)    -- the framework's own player data, or nil
local identifier = Bridge.getIdentifier(source)    -- '' when the player isn't loaded
local name       = Bridge.getPlayerName(source)    -- character name (FiveM name if not loaded)
local job        = Bridge.getJob(source)           -- { name, label, grade, gradeLabel, isBoss, onDuty, salary }
local gang       = Bridge.getGang(source)          -- { name, label, grade, gradeLabel, isBoss } or nil
local sources    = Bridge.getPlayers()             -- server IDs of all loaded players

local online = Bridge.getPlayerByIdentifier(identifier) -- normalised player if they are online, or nil

Bridge.setJob(source, 'police', 2)
Bridge.setGang(source, 'ballas', 1)                -- QBCore / QBox only
```

The identifier is the character's citizen ID on QBCore and QBox, the ESX identifier on ESX, the character ID on ND_Core and the Rockstar licence in standalone mode.

`getPlayer` returns a table with the same fields on every framework:

```lua
player.source
player.identifier
player.name
player.raw                                -- the framework's player object
player.getJob()
player.getGang()
player.getMoney('bank')
player.addMoney('bank', 500, 'reason')
player.removeMoney('bank', 500, 'reason')
player.setMoney('bank', 1000)
player.setJob('police', 2)
player.getInventory()
```

## Money

```lua
local cash = Bridge.getMoney(source, 'cash')
Bridge.addMoney(source, 'bank', 500, 'Paycheck')
Bridge.removeMoney(source, 'cash', 50, 'Parking fine')
```

{% hint style="warning" %}
`removeMoney` returns `true` without checking the balance, and some frameworks then let the balance go below zero. Check `getMoney` before you charge a player.
{% endhint %}

### Offline players

Pay or charge a character who isn't connected, by identifier:

```lua
local bank = Bridge.getOfflineMoney(identifier, 'bank')
Bridge.addOfflineMoney(identifier, 'bank', 500, 'Shop sale')
Bridge.removeOfflineMoney(identifier, 'bank', 500, 'Invoice')
```

Supported on QBox and QBCore. On ESX, ND_Core and standalone the functions return `0` / `false` and print a console warning once.

## Metadata and licences

```lua
local hunger = Bridge.getMetadata(source, 'hunger')
Bridge.setMetadata(source, 'hunger', 100)

local licences = Bridge.getLicenses(source)
local canBuy   = Bridge.hasLicense(source, 'weapon')
Bridge.addLicense(source, 'driver')
Bridge.removeLicense(source, 'driver')
```

| Framework | Metadata | Licences |
| --- | --- | --- |
| QBCore / QBox | Player metadata | The `licences` metadata |
| ESX | Player state bags | ESX licences |
| ND_Core | Player data | Not supported (`hasLicense` is always `false`) |
| Standalone | Not supported | Not supported |

## Inventory

```lua
local has   = Bridge.hasItem(source, 'lockpick', 1)
local count = Bridge.getItemCount(source, 'water')
local item  = Bridge.getItem(source, 'phone')       -- the inventory's item table, or nil
local items = Bridge.getInventory(source)

Bridge.addItem(source, 'water', 2, { quality = 100 }) -- item, count, metadata, slot
Bridge.removeItem(source, 'water', 1)
Bridge.clearInventory(source)

Bridge.registerUsableItem('bandage', function(source)
    -- the player used a bandage
end)

Bridge.openInventory(source)
Bridge.openInventoryFor(source, targetSource)        -- open another player's inventory
```

`metadata` and `slot` are passed on where the inventory supports them. `openInventoryFor` does nothing with the ESX inventory.

### Item definitions

```lua
local info = Bridge.getItemInfo('water')
-- { name = 'water', label = 'Water', weight = 500, description = '...', image = 'nui://ox_inventory/web/images/water.png' }

local fits = Bridge.canCarryItem(source, 'water', 5)
```

Available with ox_inventory, qb-inventory, ps-inventory and ESX. With other inventories `getItemInfo` returns `nil` and `canCarryItem` returns `true`.

## Society and gang accounts

```lua
local balance = Bridge.getSocietyMoney('police')
Bridge.addSocietyMoney('police', 5000)
Bridge.removeSocietyMoney('police', 250)

local gangBalance = Bridge.getGangMoney('ballas')
Bridge.addGangMoney('ballas', 1000)
Bridge.removeGangMoney('ballas', 1000)
```

The banking resource is set in `Config.SocietyManagement`. Gang accounts work with dg-banking (coming soon), Renewed-Banking, qb-management and fd_banking. With esx_society, wasabi_banking and crm-banking the gang functions return `0` / `false`.

## Notifications

```lua
Bridge.notify(source, 'Order delivered', 'success', 5000) -- source -1 = everyone
Bridge.notifyAll('Server restart in 5 minutes', 'warning')
Bridge.notifyJob('police', 'Backup requested', 'error')
```

## Logging

```lua
-- source 0 = a system event; level: 'info' | 'warn' | 'error' | 'critical'
Bridge.log(source, 'garage:spawn', { plate = 'ABC123' }, 'info')
```

Where the log goes is set in `Config.Logging` (see [Logging](configuration.md#logging)).

## Phone

```lua
local number = Bridge.getPhoneNumber(source)               -- nil if there is none
Bridge.sendSMS(number, 'Garage', 'Your car is ready.')     -- title, message
```

Messages are sent from `Config.PhoneBotNumber`. GKSPhone has no export for messages, so `sendSMS` does nothing there.

## Vehicle keys

```lua
Bridge.giveVehicleKeys(source, 'ABC123')
Bridge.removeVehicleKeys(source, 'ABC123')
local has = Bridge.hasVehicleKeys(source, 'ABC123')
```

Plates are trimmed and upper-cased for you. With qb-vehiclekeys, t1ger_keys and standalone, keys can't be checked from the server, so `hasVehicleKeys` returns `nil`; use the [client function](client-api.md#vehicle-keys) there.

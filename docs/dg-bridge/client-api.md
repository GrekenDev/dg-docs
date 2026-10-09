# Client API

Client functions, available as `Bridge.*` once your resource loads `@dg-bridge/imports/client.lua` (see [Installation](installation.md#using-dg-bridge-in-your-own-scripts)). Every function goes to the resource chosen in [Configuration](configuration.md).

## Player

```lua
-- Waits until the character is loaded, so call it from a thread.
local data = Bridge.getPlayerData()

-- true once the character is loaded.
local loaded = Bridge.playerLoaded()
```

`getPlayerData()` returns the same shape on every framework:

```lua
{
    cid       = 'ABC12345',   -- citizen id / identifier
    firstName = 'John',
    lastName  = 'Doe',
    phone     = '5551234',
    gender    = 'male',       -- 'male' | 'female'
    dob       = '01/31/1990', -- MM/DD/YYYY
    money     = { cash = 500, bank = 12000 },
    job       = { name, label, grade, gradeLabel, isBoss, onDuty, salary },
    gang      = { name, label, grade, gradeLabel, isBoss }, -- nil on ESX and ND_Core
}
```

* `money` uses the framework's own account names on QBCore and QBox (for example `crypto`), and `cash` / `bank` / `black` on ESX.
* On ESX and ND_Core `job.onDuty` is always `true`. On ND_Core `phone` is `'Unknown'` and `job.salary` is `0`.

To react to changes, listen to the [events](events.md).

## Notifications

```lua
-- type: 'success' | 'error' | 'warning' | 'info' | 'primary'
-- duration in ms, default Config.NotifyDuration
Bridge.notify('Saved!', 'success', 3000)
```

## Progress bar

```lua
Bridge.showProgress({
    label = 'Repairing',
    duration = 5000,
    canCancel = true,        -- default true
    useWhileDead = false,
    disable = { move = true, car = true, combat = true, mouse = false },
    anim = { dict = 'mini@repair', clip = 'fixing_a_ped', flag = 49 },
    prop = { model = 'prop_tool_wrench', bone = 57005, pos = vec3(0, 0, 0), rot = vec3(0, 0, 0) },
}, function(cancelled)
    if not cancelled then
        -- finished
    end
end)

Bridge.cancelProgress()
local busy = Bridge.isProgressActive()
```

`anim` and `disable` are passed to every progress resource (the standalone timer ignores them). `prop` is only used by ox_lib. With ox_lib, `showProgress` waits until the bar is done before it returns.

## Text UI

```lua
-- type: 'default' | 'success' | 'error' | 'warning'
-- position: 'left-center' | 'top-center' | 'right-center'
Bridge.showTextUI('[E] Open shop', 'default', 'left-center')
Bridge.hideTextUI()
local open = Bridge.isTextUIOpen()
```

`type` sets the icon in ox_lib and the style in lation_ui. `position` is only used by ox_lib.

## Input dialog

```lua
Bridge.showInput({
    title = 'Order stock',
    inputs = {
        { type = 'number', name = 'amount', label = 'Amount', min = 1, max = 100, required = true },
        { type = 'select', name = 'account', label = 'Pay with', options = {
            { value = 'cash', label = 'Cash' },
            { value = 'bank', label = 'Bank' },
        } },
    },
}, function(result)
    if not result then return end -- cancelled
    print(result.amount, result.account)
end)
```

The result is keyed by each input's `name`. `type` is passed to the input resource, so use that resource's type names: with ox_lib a text field is `'input'`; with qb-input it is `'text'`, and `'select'` is shown as radio buttons.

## Context menu

```lua
Bridge.openContext({
    id = 'garage_menu',
    title = 'Garage',
    options = {
        { title = 'Take out', description = 'Spawn your car', icon = 'fa-solid fa-car', onSelect = function() end },
        { title = 'Broken', disabled = true },
        { title = 'More', menu = 'garage_more' }, -- ox_lib: opens another registered menu
    },
})

Bridge.closeContext()
```

`title`, `description`, `icon`, `disabled` and `onSelect` are passed to every menu resource. `metadata`, `arrow` and `menu` are ox_lib only.

## Radial menu

```lua
Bridge.addRadialItem({
    id = 'toggle_duty',
    label = 'Toggle duty',
    icon = 'clipboard',
    onSelect = function() end,
})

Bridge.removeRadialItem('toggle_duty')
```

`menu` (open a nested radial) is ox_lib only. qb-radialmenu can't remove items, so `removeRadialItem` has no effect there.

## NPC dialog

```lua
Bridge.showDialog({
    ped = shopkeeperPed,   -- for the bl_dialog camera
    title = 'Shopkeeper',  -- used by the ox_lib fallback
    dialogs = {
        {
            id = 'start',
            name = 'Shopkeeper',
            text = 'What can I do for you?',
            buttons = {
                { label = 'Tell me more', nextDialog = 'more' },
                { label = 'Bye', close = true },
            },
        },
        {
            id = 'more',
            name = 'Shopkeeper',
            text = 'We sell everything.',
            buttons = { { label = 'Thanks', close = true } },
        },
    },
})
```

A button can also have `onSelect = function(switchDialog) end`. With `Config.NPCDialog = 'ox_lib'` every page is shown as a context menu.

## Target

```lua
local options = {
    {
        label = 'Open shop',
        icon = 'fa-solid fa-store',
        distance = 2.0,                              -- optional, overrides the call's distance
        job = 'police',                              -- optional: a job or { 'police', 'sheriff' }
        gang = 'ballas',                             -- optional: a gang or a list
        item = 'lockpick',                           -- optional: required item(s)
        canInteract = function(entity) return true end,
        action = function(entity) end,
    },
}

Bridge.addEntityTarget(entity, options, 2.5)
Bridge.addModelTarget({ 'prop_atm_01', 'prop_atm_02' }, options, 2.5)
Bridge.addBoxZone('my_zone', vec3(x, y, z), 1.5, 1.5, 0.0, options, 2.5) -- name, coords, width, length, heading
Bridge.addSphereZone('my_sphere', vec3(x, y, z), 1.5, options, 2.5)      -- name, coords, radius

Bridge.removeZone('my_zone')
Bridge.removeEntityTarget(entity)
```

The last argument is the interaction distance (default `2.5`).

{% hint style="info" %}
* With ox_target and i_interaction, `gang` is only applied when `job` is set too. `addEntityTarget` works with both networked and local entities.
* With `Config.Target = 'standalone'` only `job` is checked; `gang` and `item` are ignored.
{% endhint %}

## Inventory

```lua
local has = Bridge.hasItem('lockpick', 1)
local count = Bridge.getItemCount('water')
Bridge.openInventory()
```

Client checks are for showing things in the UI. Do anything that matters (removing items, paying) with the [server functions](server-api.md#inventory).

## Dispatch

```lua
Bridge.sendDispatch({
    message = 'Store robbery',
    code = '10-31',
    icon = 'fas fa-store',
    coords = GetEntityCoords(PlayerPedId()), -- default: the player's position
    jobs = { 'police' },                     -- default: Config.DispatchJobs
    priority = 2,
    metadata = { { label = 'Store', value = '24/7 Innocence Blvd' } },
})
```

The alert is sent to the server and on to the dispatch resource set in `Config.Dispatch`.

## Fuel

```lua
local fuel = Bridge.getVehicleFuel(vehicle) -- 0.0 to 100.0
Bridge.setVehicleFuel(vehicle, 100.0)
```

## Vehicle keys

```lua
-- Pass the vehicle, the plate, or both.
Bridge.giveVehicleKeys(vehicle, plate)
Bridge.removeVehicleKeys(vehicle, plate)
local has = Bridge.hasVehicleKeys(plate)
Bridge.setVehicleLocked(vehicle, true)
```

qbx_vehiclekeys works with vehicles, not plates: when you only pass a plate, dg-bridge looks for a nearby vehicle with that plate.

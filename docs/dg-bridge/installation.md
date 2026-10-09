# Installation

## Requirements

* OneSync
* The resources you choose in `config.lua` (your framework, inventory, target and so on)

## Steps

{% stepper %}
{% step %}
### Download

Open [GrekenDev/dg-bridge](https://github.com/GrekenDev/dg-bridge) and click **Code → Download ZIP**.
{% endstep %}

{% step %}
### Name the folder `dg-bridge`

Put the folder in your resources and rename it to exactly `dg-bridge`. The ZIP unpacks as `dg-bridge-main`, and DG scripts load `@dg-bridge/...` and call `exports['dg-bridge']`, so any other name breaks them.
{% endstep %}

{% step %}
### Configure it

Open `config.lua` and pick your framework, inventory and the other systems. See [Configuration](configuration.md).

{% hint style="warning" %}
The `config.lua` in the repository is not a neutral default: it is set to `qbox`, `i_interaction`, `Renewed-Banking`, `qbx_vehiclekeys`, `bl_dialog` and more. Go through every option and set it to what your server runs.
{% endhint %}
{% endstep %}

{% step %}
### Set the start order

dg-bridge looks up the configured resources when it starts, so start it **after** them and **before** any DG script:

```
ensure ox_lib
ensure qbx_core        # your framework
ensure ox_inventory    # your inventory, target, banking, ...
ensure dg-bridge
ensure dg-shops        # DG scripts
```
{% endstep %}

{% step %}
### Restart

Restart the server. If you change `config.lua` later, restart dg-bridge **and** the DG scripts that use it.
{% endstep %}
{% endstepper %}

## Using dg-bridge in your own scripts

Add the import file for each side to your resource's `fxmanifest.lua`:

```lua
client_scripts {
    '@dg-bridge/imports/client.lua',
    'client/*.lua',
}

server_scripts {
    '@dg-bridge/imports/server.lua',
    'server/*.lua',
}
```

That gives you a global `Bridge` table. Functions are looked up the first time you use them:

{% tabs %}
{% tab title="Client" %}
```lua
Bridge.notify('Hello!', 'success', 3000)

Bridge.showProgress({ label = 'Working...', duration = 5000 }, function(cancelled)
    if not cancelled then
        -- done
    end
end)
```
{% endtab %}

{% tab title="Server" %}
```lua
local player = Bridge.getPlayer(source)
Bridge.addItem(source, 'bread', 1)
Bridge.notify(source, 'You received bread!', 'success', 4000)
```
{% endtab %}
{% endtabs %}

Every function is also an export, but the export **returns the function** instead of calling it:

```lua
local notify = exports['dg-bridge']:notify()
notify('Hello!', 'success')
```

{% hint style="info" %}
The import files do this for you, so use them where you can.
{% endhint %}

See [Client API](client-api.md), [Server API](server-api.md) and [Events](events.md) for everything you can call.

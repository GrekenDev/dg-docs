# FAQ & troubleshooting

## "No such export" or "attempt to index a nil value" when the server starts

dg-bridge calls the resources set in `config.lua` as soon as it starts. Check that:

* every option is set to a resource your server actually runs (the repository's `config.lua` is set up for one specific server; see [Installation](installation.md)),
* those resources start **before** dg-bridge in `server.cfg`,
* the folder is named exactly `dg-bridge`.

## A DG script stopped working after I restarted dg-bridge

Scripts keep a reference to dg-bridge's functions. After restarting dg-bridge, restart the scripts that use it too (or restart the server).

## Society balance is always 0 / society payments fail

`Config.SocietyManagement` doesn't match your banking resource, or is `'none'`. An unknown value prints `Unknown Config.SocietyManagement value` in the server console.

## Money for offline players isn't paid

Offline payments only work on QBox and QBCore. On other frameworks the console shows `offline money is not supported for Config.Framework = "..."` once.

## Licence checks always fail on ND_Core

dg-bridge has no licence system for ND_Core, so `hasLicense` is always `false` there.

## Item names show as the item's code name

dg-bridge reads labels and images from ox_inventory, qb-inventory, ps-inventory and ESX. With codem-inventory or origen_inventory, set the labels in the script's own config.

## Nothing is logged

* `Config.Logging` must be `'ox_lib'` or `'discord'`.
* For Discord, `Config.LoggingWebhook` must be a valid webhook URL.
* For ox_lib, set up the log service in your ox_lib config.
* The script itself must have the action turned on (for DG Shops: `config/logs.lua`).

## Need help?

Join our [Discord](https://discord.gg/TyxgU2Cwj).

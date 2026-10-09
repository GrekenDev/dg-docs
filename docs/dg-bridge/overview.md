---
description: >-
  Free bridge resource that connects every DG script to your framework,
  inventory, target, banking and UI resources.
cover: ../.gitbook/assets/dg-bridge-cover.png
coverY: 0
layout:
  cover:
    visible: true
    size: hero
  title:
    visible: true
  description:
    visible: true
  tableOfContents:
    visible: true
  outline:
    visible: true
  pagination:
    visible: true
---

# dg-bridge

dg-bridge sits between your server and our scripts. DG scripts never call a framework, inventory or UI resource directly; they call dg-bridge, and dg-bridge calls whatever you chose in its `config.lua`.

* **One setting per system.** Switch from QBCore to QBox, or from qb-target to ox_target, by changing one line in dg-bridge. No DG script needs to change.
* **Free and public.** Download it from [GitHub](https://github.com/GrekenDev/dg-bridge). You can also use it in your own scripts (see [Client API](client-api.md) and [Server API](server-api.md)).

{% hint style="info" %}
Every DG script needs dg-bridge. Install and configure it first; the script's own installation page says which version it needs.
{% endhint %}

## Supported resources

Each row is a value for one `Config` option. See [Configuration](configuration.md) for what each option does.

### Core

| System | Option | Supported |
| --- | --- | --- |
| Framework | `Config.Framework` | ESX, QBCore, QBox, ND_Core, standalone |
| Inventory | `Config.Inventory` | ox_inventory, qb-inventory, ps-inventory, codem-inventory, origen_inventory, ESX, standalone |
| Target | `Config.Target` | ox_target, i_interaction, qb-target, qtarget, standalone |
| Society banking | `Config.SocietyManagement` | Renewed-Banking, qb-management, esx_society, fd_banking, wasabi_banking, crm-banking, dg-banking (coming soon) |

### UI

| System | Option | Supported |
| --- | --- | --- |
| Notifications | `Config.Notify` | ox_lib, QBCore, ESX, okokNotify, mythic_notify, lation_ui, ps-ui, GTA notification |
| Progress bar | `Config.Progress` | ox_lib, QBCore, esx_progressbar, mythic_progbar, standalone timer |
| Text UI | `Config.TextUI` | ox_lib, okokTextUI, QBCore DrawText, ps-ui, lation_ui, 3D text |
| Input dialog | `Config.Input` | ox_lib, qb-input |
| Context menu | `Config.ContextMenu` | ox_lib, qb-menu, lation_ui |
| Radial menu | `Config.RadialMenu` | ox_lib, qb-radialmenu |
| NPC dialog | `Config.NPCDialog` | bl_dialog, ox_lib (context menu) |

### Other

| System | Option | Supported |
| --- | --- | --- |
| Dispatch | `Config.Dispatch` | ps-dispatch, cd_dispatch, qs-dispatch, standalone (notification + blip) |
| Vehicle keys | `Config.VehicleKeys` | qb-vehiclekeys, qbx_vehiclekeys, Renewed-vehiclekeys, mrnewbs_vehiclekeys, wasabi_carlock, t1ger_keys, mono_keys, codem-vehiclekeys, standalone |
| Fuel | `Config.Fuel` | ox_fuel, LegacyFuel, ps-fuel, cdn-fuel, standalone |
| Phone | `Config.Phone` | lb-phone, GKSPhone (phone numbers only), npwd |
| Logging | `Config.Logging` | ox_lib logger (Loki, Datadog, Fivemanage), Discord webhook |

Some systems can't do everything on every framework or resource, for example offline payments or gang accounts. The [Server API](server-api.md) notes where.

## Next steps

<table data-view="cards"><thead><tr><th></th><th></th><th></th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody><tr><td><h4><i class="fa-download">:download:</i></h4></td><td><h4>Installation</h4></td><td>Start order, and how to use dg-bridge in your own scripts.</td><td><a href="installation.md">installation.md</a></td></tr><tr><td><h4><i class="fa-sliders">:sliders:</i></h4></td><td><h4>Configuration</h4></td><td>Every option in <code>config.lua</code>.</td><td><a href="configuration.md">configuration.md</a></td></tr><tr><td><h4><i class="fa-code">:code:</i></h4></td><td><h4>Server API</h4></td><td>Players, money, items, society accounts and more.</td><td><a href="server-api.md">server-api.md</a></td></tr></tbody></table>

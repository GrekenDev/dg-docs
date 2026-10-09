# Configuration

Everything is in `config.lua`. Each option picks the resource dg-bridge talks to for one system. Restart dg-bridge and the DG scripts after changing it.

The **Default** column is the value in the repository's `config.lua`.

## Framework

| Option | Default | Values |
| --- | --- | --- |
| `Config.Framework` | `'qbox'` | `'esx'`, `'qbcore'`, `'qbox'`, `'nd'` (ND_Core), `'standalone'` |

`'standalone'` runs without a framework: players are identified by their licence, every job is `unemployed`, and money functions return `0` / `false`.

### Money accounts

DG scripts use three account names: `cash`, `bank` and `black` (dirty money). `Config.MoneyAccounts` maps them to your framework's names:

```lua
Config.MoneyAccounts = {
    cash  = 'cash',
    bank  = 'bank',
    black = 'crypto',
}
```

{% tabs %}
{% tab title="QBCore / QBox" %}
This table is used as is. Change a value if your server stores that money under another name.
{% endtab %}

{% tab title="ESX" %}
The table isn't used. dg-bridge maps `cash` → `money` and `black` → `black_money` itself; `bank` stays `bank`.
{% endtab %}

{% tab title="ND_Core" %}
The table isn't used. The names are passed to ND_Core as they are (`cash`, `bank`).
{% endtab %}
{% endtabs %}

## Inventory

| Option | Default | Values |
| --- | --- | --- |
| `Config.Inventory` | `'dg_inventory'` | `'ox_inventory'`, `'qb-inventory'`, `'ps-inventory'`, `'codem-inventory'`, `'origen_inventory'`, `'esx'`, `'standalone'` |

{% hint style="warning" %}
Set this to the inventory your server runs: the repository default doesn't match a public inventory.
{% endhint %}

Item labels, images and weight checks (used by DG Shops, for example) come from ox_inventory, qb-inventory, ps-inventory and ESX. With codem-inventory and origen_inventory they aren't available, so scripts fall back to their own config. `'standalone'` means no inventory: item functions return `false` / `0`.

## Target

| Option | Default | Values |
| --- | --- | --- |
| `Config.Target` | `'i_interaction'` | `'ox_target'`, `'i_interaction'`, `'qb-target'`, `'qtarget'`, `'standalone'` |

`'standalone'` needs no resource: the player presses **E** near the zone or entity. The prompt text is only drawn when `Config.TextUI` is `'standalone'` too.

## Society banking

| Option | Default | Values |
| --- | --- | --- |
| `Config.SocietyManagement` | `'Renewed-Banking'` | `'Renewed-Banking'`, `'qb-management'`, `'esx_society'`, `'fd_banking'`, `'wasabi_banking'`, `'crm-banking'`, `'dg-banking'` (coming soon), `'none'` |

Used for job accounts (and gang accounts where the resource has them). `esx_society` uses the `society_<job>` accounts of esx_addonaccount. With `'none'`, society balances are `0` and payments fail.

## Notifications

| Option | Default | Values |
| --- | --- | --- |
| `Config.Notify` | `'ox_lib'` | `'ox_lib'`, `'qbcore'`, `'esx'`, `'okok'` (okokNotify), `'mythic'` (mythic_notify), `'lation'` (lation_ui), `'ps-ui'`, `'standalone'` (GTA notification) |
| `Config.NotifyDuration` | `5000` | Milliseconds a notification shows when a script doesn't pass its own duration. |

## Progress bar

| Option | Default | Values |
| --- | --- | --- |
| `Config.Progress` | `'ox_lib'` | `'ox_lib'`, `'qbcore'`, `'esx'` (esx_progressbar), `'mythic'` (mythic_progbar), `'standalone'` (a timer without a bar) |

## Text UI

| Option | Default | Values |
| --- | --- | --- |
| `Config.TextUI` | `'ox_lib'` | `'ox_lib'`, `'okok'` (okokTextUI), `'qbcore'` (DrawText), `'ps-ui'`, `'lation'` (lation_ui), `'standalone'` (3D text above the player) |

Used for "press E" prompts.

## Input and menus

| Option | Default | Values |
| --- | --- | --- |
| `Config.Input` | `'ox_lib'` | `'ox_lib'`, `'qb-input'` |
| `Config.ContextMenu` | `'ox_lib'` | `'ox_lib'`, `'qb-menu'`, `'lation'` (lation_ui) |
| `Config.RadialMenu` | `'ox_lib'` | `'ox_lib'`, `'qb-radial'` (qb-radialmenu) |
| `Config.NPCDialog` | `'bl_dialog'` | `'bl_dialog'`, `'ox_lib'` (shown as a context menu), `'standalone'` (no dialog) |

{% hint style="info" %}
There is no built-in input dialog or context menu. With any other value, input dialogs return their default values without showing anything, and menus are only printed to the console. Pick one of the resources above.
{% endhint %}

## Dispatch

| Option | Default | Values |
| --- | --- | --- |
| `Config.Dispatch` | `'ps-dispatch'` | `'ps-dispatch'`, `'cd_dispatch'`, `'qs-dispatch'`, `'standalone'` |
| `Config.DispatchJobs` | `{ 'police', 'sheriff', 'ambulance' }` | Jobs that receive an alert when a script doesn't say which jobs to alert. |

`'standalone'` sends a notification and a map blip (shown for 30 seconds) to every online player with one of those jobs.

## Vehicle keys and fuel

| Option | Default | Values |
| --- | --- | --- |
| `Config.VehicleKeys` | `'qbx_vehiclekeys'` | `'qb-vehiclekeys'`, `'qbx_vehiclekeys'`, `'Renewed-vehiclekeys'`, `'mrnewbs_vehiclekeys'`, `'wasabi_carlock'`, `'t1ger_keys'`, `'mono_keys'`, `'codem-vehiclekeys'`, `'standalone'` |
| `Config.Fuel` | `'ox_fuel'` | `'ox_fuel'`, `'LegacyFuel'`, `'ps-fuel'`, `'cdn-fuel'`, `'standalone'` (the game's own fuel level) |

## Phone

| Option | Default | Values |
| --- | --- | --- |
| `Config.Phone` | `'none'` | `'lb-phone'`, `'gksphone'`, `'npwd'`, `'none'` |
| `Config.PhoneBotNumber` | `'555-0000'` | Sender number for messages sent by scripts (lb-phone and npwd). |

GKSPhone has no export for sending messages, so with `'gksphone'` scripts can read phone numbers but not send SMS.

## Logging

| Option | Default | Values |
| --- | --- | --- |
| `Config.Logging` | `'none'` | `'ox_lib'`, `'discord'`, `'none'` |
| `Config.LoggingWebhook` | `''` | Discord webhook URL. Only used with `'discord'`. |

* `'ox_lib'` sends logs to ox_lib's logger, which forwards them to the service set in your ox_lib config (Loki, Datadog, Fivemanage).
* `'discord'` posts each entry as an embed to `Config.LoggingWebhook`.

Each DG script chooses **which** actions it logs in its own config (for DG Shops: [Logging](../dg-shops/logging.md)).

{% hint style="info" %}
An unknown value for `SocietyManagement`, `Logging` or `Phone` prints a warning in the console and turns that system off. For `Fuel` it prints a warning and uses the game's own fuel level.
{% endhint %}

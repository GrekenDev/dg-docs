# FAQ & troubleshooting

## There are two shopkeepers at the same store

Your inventory has its own shops at the same coordinates (for example `ox_inventory/data/shops.lua`). Remove those entries, or remove the location from `config/shops.lua`.

## The shop doesn't open / "You are too far from the shop."

The server only accepts actions from players within `Config.MaxServerDistance` of the store. Check that the location's `coords` match where the ped stands.

## Players can open the shop but can't buy

The error message tells you why:

| Message | Cause |
| --- | --- |
| "The shop is closed right now." | The owner set opening hours under **Settings**, and it's outside them (in-game time). |
| "You are not allowed to shop here." | The location has `jobs`, and the player doesn't have the job or grade. |
| "You are banned from this shop." | The owner or staff banned the player under **Customers**. |

## Item images or names are missing

Labels and images come from your inventory through dg-bridge. Make sure the item exists in your inventory, or set `label` / `image` on the catalog entry.

{% hint style="info" %}
dg-bridge reads item labels and images from ox_inventory, qb-inventory, ps-inventory and ESX. With other inventories, set `label` and `image` on each catalog entry.
{% endhint %}

## A licence-locked item can't be bought

Licences are checked through dg-bridge. ND_Core has no licence system there, so on ND_Core remove `license` from the catalog entry.

## Society payment isn't offered

* `society` must be on in `Config.PaymentMethods`, and in the location's `payments` if it has one.
* The player's job must be in `Config.SocietyPayments` with a high enough grade.
* Your banking resource must be supported by dg-bridge.

## The loyalty tab isn't there

Check `Config.Features.loyalty` and the location's `features`. In owned shops the owner also needs the **Loyalty Program** upgrade and must turn the program on.

## An employee can't see a menu section

Parts of the menu are hidden when the employee lacks the permission. The owner can change it under **Employees → Permissions**.

## Some text is still in English

Texts missing from your locale file fall back to English. Add the missing keys from `locales/en.json`. Product, category and upgrade names come from the config files, not the locale.

## I changed `config/shops.lua` and an owned shop lost its data

Ownership is stored by the location `id`. Changing an `id` creates a new, unowned store. Change it back to restore the data.

## Need help?

Join our [Discord](https://discord.gg/TyxgU2Cwj).

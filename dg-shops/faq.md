# FAQ & troubleshooting

## There are two shopkeepers at the same store

Your inventory has its own shops at the same coordinates (for example `ox_inventory/data/shops.lua`). Remove those entries, or remove the location from `config/shops.lua`.

## The shop doesn't open / "You are too far away"

The server only accepts actions from players within `Config.MaxServerDistance` of the store. Check that the location's `coords` match where the ped stands.

## Item images or names are missing

Labels and images come from your inventory through dg-bridge. Make sure the item exists in your inventory, or set `label` / `image` on the catalog entry.

## Society payment isn't offered

* `society` must be enabled in `Config.PaymentMethods` (or the location's `payments`).
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

# Logging

DG Shops logs through dg-bridge. The **destination** (Discord webhook, ox_lib → Loki / Datadog / Fivemanage, or nothing) is set in `dg-bridge/config.lua` under `Config.Logging`.

**Which actions** are logged is set in `config/logs.lua`. Set any of them to `false` to stop logging it:

```lua
Config.Logs = {
    purchase = true,
    sell = true,              -- pawn sales
    shop_bought = true,
    shop_sold = true,
    shop_transferred = true,
    stock_ordered = true,
    stock_delivered = true,
    stock_transfer = true,
    price_changed = true,
    product_added = true,
    product_removed = true,
    sale_created = true,
    sale_deleted = true,
    coupon_created = true,
    coupon_deleted = true,
    coupon_redeemed = true,
    employee_hired = true,
    employee_fired = true,
    permissions_changed = true,
    customer_banned = true,
    customer_unbanned = true,
    deposit = true,
    withdraw = true,
    upgrade_bought = true,
    settings_changed = true,
    reward_redeemed = true,
}
```

Separately from these logs, owners see a stock history and an employee log in the management menu.

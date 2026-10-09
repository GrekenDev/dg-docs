# Ownership & management

Ownership, deliveries, limits and upgrades are set in `config/management.lua`. Owners and staff open the management menu from the **Manage** button in the shop.

## Ownership

```lua
Config.Ownership = {
    enabled = true,            -- false: no player ownership, every shop runs from the config
    maxPerPlayer = 2,          -- shops one character may own
    sellBackRate = 0.6,        -- share of the buy-in price paid back when selling to the city
    purchaseAccount = 'bank',  -- account the buy-in price is taken from
    baseCapacity = 500,        -- stock units before upgrades
    baseProductSlots = 12,     -- products before upgrades
    baseEmployeeSlots = 3,     -- employees before upgrades
}
```

* **Buying:** a store with `ownable = true` and a `price` shows a **Buy shop** button.
* **Selling to the city:** pays back `price × sellBackRate` plus the shop balance, and resets the store.
* **Selling to a player:** the owner enters the buyer's server ID and a price. The buyer gets a prompt and pays from their bank. Employees and stock stay with the shop.

Owned shops sell only what is in stock. Owners fill the shelves by ordering from the supplier or moving items from their own inventory.

## Deliveries

```lua
Config.Deliveries = {
    baseMinutes = 20,  -- minutes before an order arrives (before Express Logistics)
    maxLines = 20,     -- different products in one order
    paymentAccounts = { shop = true, cash = true, bank = true },
}
```

Orders are paid at the wholesale price (minus the Reputation discount). Delivery timers are stored in the database, so they keep running through restarts. A pending order can be cancelled for a full refund.

## Limits

```lua
Config.Finance = { maxTransfer = 10000000 } -- max single deposit / withdrawal

Config.Limits = {
    nameLength = 32,
    codeLength = 16,
    maxPrice = 1000000,
    maxSalePercent = 90,
    maxCouponPercent = 90,
    maxSales = 15,
    maxCoupons = 40,
}
```

## Upgrades

Owners buy upgrades with the shop balance. Each level's `value` is what the shop gets at that level:

| Upgrade | `value` means |
| --- | --- |
| `capacity` | Total stock units |
| `reputation` | % discount on wholesale orders |
| `logistics` | % faster deliveries |
| `productSlots` | Number of products |
| `employeeSlots` | Number of employees |
| `loyalty` | Unlocks the loyalty program (one level) |

```lua
capacity = {
    label = 'Stock Capacity',
    description = 'Store more units across all products.',
    icon = 'box',
    levels = {
        { price = 25000, value = 1000 },
        { price = 60000, value = 2000 },
        { price = 120000, value = 4000 },
    },
},
```

Add or remove levels freely; the UI follows the config.

## Blip choices

The icons and colours owners can pick for their store's map blip:

```lua
Config.BlipChoices = {
    sprites = { 52, 59, 93, 110, 402, 431, 500, 605, 616 },
    colors = { 0, 1, 2, 3, 5, 25, 27, 38, 47, 83 },
}
```

## Employees and permissions

Owners hire players by server ID and choose exactly what each employee may do. There are 56 permissions in 12 groups:

| Group | Examples |
| --- | --- |
| Overview | View dashboard, see revenue metrics |
| Products | Add / remove products, change prices and categories, restrict products to jobs / gangs / players |
| Stock | Order stock, pay with shop funds, cancel deliveries, move items between inventory and stock |
| Sales | Create, end and restrict sales |
| Coupons | Create, delete and restrict coupons |
| Customers | View history, ban / unban, adjust loyalty points |
| Employees | Hire, fire, edit permissions, view the employee log |
| Finances | View balance, deposit, withdraw, view transactions and charts |
| Loyalty | Turn the program on/off, change the points rate, edit tiers and rewards |
| Upgrades | View and buy upgrades |
| Analytics | Product, sale, coupon and customer insights |
| Settings | Rename the shop, change blip and opening hours |

The owner always has every permission. Employees can only grant permissions they hold themselves, and parts of the menu they can't use are hidden. New hires start with view access to the dashboard, products and stock.

Every permission is checked again on the server for each action.

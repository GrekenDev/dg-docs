# Shop types & locations

Shops are set up in `config/shops.lua` in two parts:

* A **shop type** is a catalog: which items are sold, at what price, in which categories.
* A **location** is a physical store that uses one type.

Ten 24/7 stores can share the `general` type and only differ in position, name and price.

## Shop types

```lua
Config.ShopTypes = {
    general = {
        label = '24/7 Supermarket',
        logo = '247Logo.webp',
        blip = { sprite = 52, color = 2, scale = 0.7 },
        categories = {
            food = 'Food',
            drinks = 'Drinks',
        },
        items = {
            { item = 'water',  price = 5,  wholesale = 2, category = 'drinks' },
            { item = 'burger', price = 12, wholesale = 5, category = 'food' },
        },
    },
}
```

| Option | What it does |
| --- | --- |
| `label` | Name of the type, shown above the shop name. |
| `logo` | Image in `web/images/` that replaces the icon in the top-left of the UI. |
| `blip` | Map blip for every location of this type. |
| `categories` | Category key → label. |
| `items` | The catalog (see below). |
| `mode = 'pawn'` | Makes it a pawn shop: players **sell** to the shop instead of buying. |

Included types: `general` (24/7), `liquor` (LTD), `hardware`, `ammunation`, `police_armory`, `blackmarket` and `pawn`.

### Catalog entries

```lua
{
    item        = 'water',          -- inventory item name (required)
    price       = 5,                -- customer price, and the starting price when an owner adds it
    wholesale   = 2,                -- what an owner pays per unit when ordering (default: 50% of price)
    category    = 'drinks',         -- key in the type's categories
    stock       = nil,              -- unowned shops: nil = unlimited, a number = stock per restart

    -- optional
    label       = 'Spring Water',   -- overrides the inventory label
    description = '...',            -- overrides the inventory description
    image       = 'nui://...',      -- overrides the inventory image
    variant     = 'og_kush',        -- lets the same item appear several times
    metadata    = { strain = '..' },-- metadata on the bought item
    license     = 'weapon',         -- licence needed to buy (checked through dg-bridge)
    serial      = true,             -- weapons: add a serial number
    exchange    = {                 -- pay with items instead of (or on top of) money
        { item = 'metalscrap', count = 5 },
    },
    jobs        = { 'police' },     -- only these jobs may buy it
    gangs       = { 'ballas' },     -- only these gangs may buy it
    sell        = 40,               -- pawn shops: what the shop pays per unit
}
```

## Locations

```lua
Config.Shops = {
    { id = '247_innocence', type = 'general', label = '24/7 Innocence Blvd', coords = vec4(24.47, -1346.62, 29.5, 271.66), ownable = true, price = 150000 },
}
```

| Option | What it does |
| --- | --- |
| `id` | Unique id. **Never change it** once players own the shop: ownership, stock and history are stored by id. |
| `type` | Key in `Config.ShopTypes`. |
| `label` | Shop name. |
| `coords` | `vec4(x, y, z, heading)`. The ped stands here. |
| `logo` | Overrides the type's logo for this store only. |
| `ped` | `{ model = '...' }` for a custom ped, or `false` for no ped. Default: `Config.DefaultPed`. |
| `blip` | `false` hides the blip for this store. |
| `ownable` | `true` lets players buy the store. |
| `price` | Buy-in price. |
| `lockName` | `true` stops owners from renaming the store. |
| `illegal` | Dirty money only, and the illegal theme. |
| `jobs` | Job → minimum grade allowed to shop, e.g. `{ police = 0 }`. |
| `payments` | Overrides `Config.PaymentMethods`, e.g. `{ cash = false, bank = true, society = true }`. |
| `features` | Turns customer features off for this store, e.g. `{ loyalty = false, coupons = false }`. |

## Examples

**Job-locked armory with society payments:**

```lua
{
    id = 'police_mrpd',
    type = 'police_armory',
    label = 'MRPD Armory',
    coords = vec4(482.55, -995.55, 30.69, 90.0),
    ped = false,
    blip = false,
    jobs = { police = 0 },
    payments = { cash = false, bank = true, society = true },
    features = { loyalty = false, coupons = false },
},
```

**Pawn shop players can buy:**

```lua
{ id = 'pawn_downtown', type = 'pawn', label = 'Downtown Pawn', coords = vec4(412.34, 314.81, 103.13, 207.0), ownable = true, price = 220000 },
```

## Logos

1. Put the image (`.webp` or `.png`) in `web/images/`.
2. Set `logo = 'MyLogo.webp'` on a type (every store of that type) or on a location (that store only).

A full `https://` URL also works. If the image can't be loaded, the UI shows the default icon.

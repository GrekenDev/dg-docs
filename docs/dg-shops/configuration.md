# Main settings

All general settings are in `config/main.lua`.

## General

| Option | Default | What it does |
| --- | --- | --- |
| `Config.Debug` | `false` | Prints debug output in the client and server console. |
| `Config.VersionCheck` | `true` | Prints a console message when a new version is released. See [Updates](updates.md). |
| `Config.Locale` | `'en'` | Language of the UI and in-game messages: `'en'`, `'de'`, `'sv'` or your own. See [Translations](translations.md). |

## Look

| Option | Default | What it does |
| --- | --- | --- |
| `Config.Theme` | `'gray'` | Colour theme: `'blue'`, `'red'`, `'yellow'`, `'white'`, `'gray'`. |
| `Config.IllegalTheme` | `'red'` | Theme for illegal shops (black market etc.). |
| `Config.DefaultView` | `'grid'` | How products are listed the first time: `'grid'` or `'list'`. Players can switch, and their choice is remembered. |
| `Config.BackgroundPattern` | `'none'` | Pattern behind the window: `'none'`, `'dots'`, `'cross'`, `'diagonal'`. |
| `Config.BackgroundPatternOpacity` | `0.05` | Strength of the pattern. |

## Currency

```lua
Config.Currency = {
    symbol = '$',
    position = 'prefix', -- 'prefix' → $1,250 | 'suffix' → 1,250 $
    separator = ',',
}
```

## Interaction

| Option | Default | What it does |
| --- | --- | --- |
| `Config.Interaction` | `'target'` | `'target'`: a target zone / ped (the target resource is set in dg-bridge). `'textui'`: walk up and press **E**. |
| `Config.InteractDistance` | `2.0` | How close a player must be to open the shop. The text UI uses this distance; target zones and peds use it plus 0.5. |
| `Config.MaxServerDistance` | `10.0` | The server refuses any shop action from a player further away than this. |
| `Config.DefaultPed` | `mp_m_shopkeep_01` | Ped `model` and `scenario` used at every location that doesn't set its own `ped` (or `ped = false`). |

## Payments

```lua
Config.PaymentMethods = {
    cash = true,
    bank = true,
    society = true,
}
```

Which accounts customers may pay with. A location can turn methods off for that store with `payments` (see [Shop types & locations](shops.md)). Illegal shops always use dirty money (`Config.DirtyMoneyAccount`, default `'black'`).

### Society payments

Players in these jobs may charge purchases to their organisation's account, from `minGrade` upward:

```lua
Config.SocietyPayments = {
    police = { minGrade = 2 },
    ambulance = { minGrade = 2 },
    mechanic = { minGrade = 3 },
}
```

The society account is handled by dg-bridge, so it works with the banking resource you use there.

## Customer features

Global switches. Each location can also turn them off with `features`.

```lua
Config.Features = {
    history = true,   -- purchase history with reorder
    loyalty = true,   -- points, tiers and rewards
    presets = true,   -- saved carts with share codes
    coupons = true,   -- coupon codes at checkout
    favorites = true, -- heart products
}
```

## Loyalty defaults

Used by unowned shops and as the starting point for newly bought shops. Owners can change everything from the management menu once they buy the Loyalty Program upgrade.

```lua
Config.Loyalty = {
    pointsPerDollar = 1,  -- points earned per $1 spent (after discounts)
    tierMode = 'total',   -- 'total' → tiers use lifetime points | 'current' → spendable balance
    tiers = {
        { name = 'Bronze', points = 0, discount = 0 },
        { name = 'Silver', points = 1000, discount = 2 },
        { name = 'Gold', points = 5000, discount = 5 },
        { name = 'Platinum', points = 15000, discount = 8 },
    },
    rewards = {
        { id = 'v5', name = '5% voucher', description = '5% off one purchase', icon = 'ticket', cost = 500, percent = 5 },
        { id = 'v10', name = '10% voucher', description = '10% off one purchase', icon = 'ticket', cost = 900, percent = 10 },
        { id = 'v15', name = '15% voucher', description = '15% off one purchase', icon = 'ticket', cost = 1300, percent = 15 },
    },
}
```

Each reward becomes a single-use personal coupon for that shop when redeemed.

## Other

| Option | Default | What it does |
| --- | --- | --- |
| `Config.MaxPresets` | `10` | Saved carts per player. |
| `Config.HistoryLength` | `25` | Receipts shown in a customer's own history. |
| `Config.SerialFormat` | `AB123456` | Function that builds serial numbers for weapons sold with `serial = true`. |

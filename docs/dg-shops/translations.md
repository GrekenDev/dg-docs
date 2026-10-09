# Translations

Every text a player sees lives in one file per language in `locales/`: the whole UI, in-game notifications, error messages and permission names. English (`en`), German (`de`) and Swedish (`sv`) are included.

The files are plain JSON, so they can be edited in the escrow edition too.

## Choosing a language

In `config/main.lua`:

```lua
Config.Locale = 'sv'
```

## Adding a language

1. Copy `locales/en.json` to a new file named after the language code, e.g. `locales/fr.json`.
2. Translate the values. Keep the keys (the left side) as they are.
3. Set `Config.Locale = 'fr'` and restart `dg-shops`.

Anything you leave out falls back to English, so you can translate a little at a time.

## How the file is built

Texts are grouped by screen:

```json
{
    "cart": {
        "title": "Your cart",
        "items": {
            "one": "{count} item",
            "other": "{count} items"
        },
        "you_save": "You save {amount}"
    }
}
```

| Group | Used for |
| --- | --- |
| `game` | Notifications and prompts in the game world |
| `common`, `payment`, `time` | Shared words, payment methods, durations |
| `shop`, `browse`, `cart`, `product`, `sell`, `history`, `loyalty`, `presets` | The storefront |
| `manage`, `dashboard`, `products`, `stock`, `sales`, `coupons`, `customers`, `employees`, `finance`, `loyalty_admin`, `upgrades`, `analytics`, `settings` | The management menu |
| `promo`, `target`, `audience` | Who and what a sale or coupon applies to |
| `range`, `history_filter`, `tx`, `log`, `log_detail` | Date ranges, transaction types and the stock / employee logs |
| `error` | Error messages |
| `permission_group`, `permission` | Names of employee permissions |

### Placeholders

Words in braces are filled in by the script: `{amount}`, `{name}`, `{count}`. Keep them, but move them wherever they fit in your sentence:

```json
"you_save": "Du sparar {amount}"
```

Texts in the `game` group use `%s` and `%d` instead. Keep these in the same order.

### Counts

Texts with `one` and `other` pick the right form for the number: `1 item`, `3 items`. Languages with more forms (Polish, Russian, …) can add `few` and `many`.

## What isn't in the locale

Product, category, shop-type, upgrade, tier and reward names come from the config files and from your inventory. Change them there.

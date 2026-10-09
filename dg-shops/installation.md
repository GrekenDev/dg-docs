# Installation

## Requirements

* [dg-bridge](https://github.com/GrekenDev/dg-bridge) **1.2.0** or newer
* [ox_lib](https://github.com/overextended/ox_lib)
* [oxmysql](https://github.com/overextended/oxmysql)
* OneSync

## Steps

1. **Download** the resource from the [Cfx portal](https://portal.cfx.re/assets/granted-assets) (Escrow) or from your Tebex purchase (Open source).
2. **Put the `dg-shops` folder** in your resources. Keep the folder name: it is used for event names and image paths.
3. **Start order** in `server.cfg`. DG Shops must start after its dependencies:

   ```
   ensure ox_lib
   ensure oxmysql
   ensure dg-bridge
   ensure dg-shops
   ```

4. **Database:** the tables are created automatically on the first start. If you prefer to import them yourself, run `sql/dg-shops.sql`.
5. **Remove overlapping shops.** If your inventory ships its own shops (for example `ox_inventory/data/shops.lua`) at the same 24/7, LTD or Ammu-Nation coordinates, remove those entries, or remove the locations from `config/shops.lua`. Otherwise players see two shopkeepers.
6. **Restart the server** (or `ensure dg-bridge` and then `ensure dg-shops`).

{% hint style="info" %}
The UI is already built in both editions. You only need Node.js and `npm run build` if you change the UI source in the open-source edition.
{% endhint %}

## Open-source edition: building the UI

After changing anything in `web/src`:

```bash
npm install
npm run build
```

Then restart `dg-shops`. For live UI development in the browser, `npm run dev` opens the UI at `http://localhost:3000` with mocked data and a dev panel.

# Installation

## Requirements

* [dg-bridge](https://github.com/GrekenDev/dg-bridge) **1.2.0** or newer
* [ox_lib](https://github.com/overextended/ox_lib)
* [oxmysql](https://github.com/overextended/oxmysql)
* OneSync

## Steps

{% stepper %}
{% step %}
### Download the resource

{% tabs %}
{% tab title="Escrow" %}
Download `dg-shops` from your [Cfx portal](https://portal.cfx.re/assets/granted-assets) under **Granted assets**.
{% endtab %}

{% tab title="Open source" %}
Download `dg-shops` from your Tebex purchase. The UI is already built, so you can start it right away.
{% endtab %}
{% endtabs %}
{% endstep %}

{% step %}
### Add it to your resources

Put the `dg-shops` folder in your resources. Keep the folder name: other scripts call the exports as `exports['dg-shops']`.
{% endstep %}

{% step %}
### Set the start order

DG Shops must start after its dependencies in `server.cfg`:

```
ensure ox_lib
ensure oxmysql
ensure dg-bridge
ensure dg-shops
```
{% endstep %}

{% step %}
### Database

The tables are created automatically on the first start. If you prefer to import them yourself, run `sql/dg-shops.sql`.
{% endstep %}

{% step %}
### Remove overlapping shops

If your inventory ships its own shops (for example `ox_inventory/data/shops.lua`) at the same 24/7, LTD or Ammu-Nation coordinates, remove those entries, or remove the locations from `config/shops.lua`. Otherwise players see two shopkeepers.
{% endstep %}

{% step %}
### Restart

Restart the server (or `ensure dg-bridge` and then `ensure dg-shops`). The console prints `[dg-shops] loaded <n> shops` when everything is ready.
{% endstep %}
{% endstepper %}

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

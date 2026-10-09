# Updates

## Getting notified

When a new version is released, your server console shows:

```
[dg-shops] Update available: 1.0.0 -> 1.1.0
[dg-shops]   - What changed
[dg-shops] Download it from https://portal.cfx.re/assets/granted-assets
```

The check runs on start and every 6 hours. Turn it off with `Config.VersionCheck = false` in `config/main.lua`.

## Updating

1. Download the new version from the [Cfx portal](https://portal.cfx.re/assets/granted-assets) (Escrow) or Tebex (Open source).
2. Back up your `config/` folder and any edited `locales/*.json`.
3. Replace the `dg-shops` folder.
4. Put your config back. Compare it with the new config files: new options may have been added.
5. Restart the server.

Your database (owners, stock, employees, history) is kept. New tables are created automatically on start; if an update changes existing tables, the release notes say what to run.

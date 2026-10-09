# Development By Greken

Documentation for the FiveM resources by Development By Greken. GitBook publishes it from this repository with Git Sync.

| Resource | What it is |
| --- | --- |
| [DG Shops](docs/dg-shops/overview.md) | Ownable shops with a modern UI, staff, stock, coupons, loyalty and analytics |

## Repository layout

| Path | What it is |
| --- | --- |
| `gitbook-docs.yaml` | Site configuration for GitBook Git Sync |
| `docs/` | The documentation: `README.md` is the home page, `SUMMARY.md` the sidebar, one folder per resource |
| `docs/.gitbook/assets/` | Images used by the pages |
| `design/` | HTML sources of the banner, page covers and card images |

To change an image, edit its HTML in `design/` and run:

```powershell
powershell -ExecutionPolicy Bypass -File design\render.ps1
```

The script renders every image with headless Edge into `docs/.gitbook/assets/`. Add image names (for example `home-banner`) to render only those, or `-Preview` to write to `design/out/` instead.

## Links

* **Store:** [developmentbygreken.tebex.io](https://developmentbygreken.tebex.io)
* **dg-bridge** (free, required by our resources): [GitHub](https://github.com/GrekenDev/dg-bridge)
* **Support:** [Discord](https://discord.gg/TyxgU2Cwj)

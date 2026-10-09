---
description: >-
  FiveM scripts by Development By Greken: player-run businesses, jobs, crime and
  police systems for QBox, QBCore, ESX and ND_Core.
cover: .gitbook/assets/home-banner.png
coverY: 0
layout:
  width: wide
  cover:
    visible: true
    size: full
  title:
    visible: true
  description:
    visible: false
  tableOfContents:
    visible: true
  outline:
    visible: false
  pagination:
    visible: false
---

# Development By Greken

We make FiveM scripts for roleplay servers: player-run businesses, jobs, crime and police systems. This is the documentation for all of them, with installation, configuration and exports for each script.

Every DG script connects to your server through **dg-bridge**, our free bridge resource. You choose your framework, inventory, target, banking and UI resources once in dg-bridge, and every DG script uses them. QBox, QBCore, ESX and ND_Core are supported.

## Scripts

<table data-view="cards" data-card-size="large"><thead><tr><th></th><th></th><th data-hidden data-card-target data-type="content-ref"></th><th data-hidden data-card-cover data-type="files"></th></tr></thead><tbody><tr><td><strong>DG Shops</strong></td><td>Ownable shops with a modern UI, staff, stock, coupons, loyalty and analytics.</td><td><a href="dg-shops/overview.md">overview.md</a></td><td><a href=".gitbook/assets/card-dg-shops.png">card-dg-shops.png</a></td></tr><tr><td><strong>dg-bridge</strong></td><td>Free. Connects every DG script to your framework, inventory, target, banking and UI resources.</td><td><a href="dg-bridge/overview.md">overview.md</a></td><td><a href=".gitbook/assets/card-dg-bridge.png">card-dg-bridge.png</a></td></tr></tbody></table>

## Getting started

{% stepper %}
{% step %}
### Install dg-bridge

Download [dg-bridge](https://github.com/GrekenDev/dg-bridge), choose your framework and resources in its `config.lua`, and start it before any DG script. See [dg-bridge → Installation](dg-bridge/installation.md).
{% endstep %}

{% step %}
### Install the script

Follow the script's installation page, for example [DG Shops → Installation](dg-shops/installation.md).
{% endstep %}

{% step %}
### Configure it

Each script has its own config files. Its section in these docs explains every option.
{% endstep %}
{% endstepper %}

## Links

<table data-view="cards"><thead><tr><th></th><th></th><th></th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody><tr><td><h4><i class="fa-store">:store:</i></h4></td><td><h4>Store</h4></td><td>Buy our scripts on Tebex.</td><td><a href="https://developmentbygreken.tebex.io">https://developmentbygreken.tebex.io</a></td></tr><tr><td><h4><i class="fa-discord">:discord:</i></h4></td><td><h4>Discord</h4></td><td>Support and questions.</td><td><a href="https://discord.gg/TyxgU2Cwj">https://discord.gg/TyxgU2Cwj</a></td></tr><tr><td><h4><i class="fa-github">:github:</i></h4></td><td><h4>dg-bridge</h4></td><td>Free and public on GitHub.</td><td><a href="https://github.com/GrekenDev/dg-bridge">https://github.com/GrekenDev/dg-bridge</a></td></tr></tbody></table>

{% hint style="info" %}
**Need help?** Join our [Discord](https://discord.gg/TyxgU2Cwj).
{% endhint %}

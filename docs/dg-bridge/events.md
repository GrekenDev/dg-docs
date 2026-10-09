# Events

dg-bridge turns each framework's own player events into four client events, so your script listens to the same names everywhere.

| Event | Data | Fired on |
| --- | --- | --- |
| `dg-bridge:client:playerLoaded` | none | ESX, QBCore, QBox, ND_Core |
| `dg-bridge:client:playerUnloaded` | none | ESX, QBCore, QBox, ND_Core |
| `dg-bridge:client:jobUpdated` | `{ name, label, grade, gradeLabel, isBoss, onDuty, salary }` | ESX, QBCore, QBox, ND_Core |
| `dg-bridge:client:gangUpdated` | `{ name, label, grade, gradeLabel, isBoss }` | QBCore, QBox |

They are local client events, so listen with `AddEventHandler`:

```lua
AddEventHandler('dg-bridge:client:playerLoaded', function()
    local data = Bridge.getPlayerData()
    print(('Welcome, %s'):format(data.firstName))
end)

AddEventHandler('dg-bridge:client:jobUpdated', function(job)
    print(('New job: %s (%s)'):format(job.label, job.gradeLabel))
end)
```

{% hint style="info" %}
The events fire when the framework fires its own event, not when your resource restarts. To handle a restart while the player is already in game, also check `Bridge.playerLoaded()` when your resource starts.
{% endhint %}

In standalone mode none of these events fire.

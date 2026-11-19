# Nix config

My NixOS configuration, using flakes, den and nixos-unstable.

- `loki`: workstation with Niri and Noctalia.
- `noveria`: home server for media, photos, documents and RSS feeds.
- `virmire`: server running Pocket ID.

Host configs live in `modules/hosts/`, shared setups in `modules/profiles/`, and apps and services in the other `modules/` folders.

Run from this repo on NixOS with flakes enabled. Replace `loki` with the host you want:

```sh
# Build without applying
nix run .#loki -- switch --dry

# Apply to the local machine
nix run .#loki -- switch
```

`flake.nix` is generated. After changing input declarations in the modules, regenerate it with `nix run .#write-flake`.

Miniflux on noveria is served at `https://feeds.td-home.xyz` through Caddy,
with its database in the existing PostgreSQL instance on the SSD. It runs
independently of the manually unlocked media storage.

Before the first deployment:

1. Point `feeds.td-home.xyz` to noveria using the same DNS setup as the other services.
2. Create a Pocket ID client restricted to the intended users, with callback
   `https://feeds.td-home.xyz/oauth2/oidc/callback`.
3. Add `miniflux.admin-password`, `miniflux.oauth.client-id` and
   `miniflux.oauth.client-secret` to `secrets/noveria.yaml` using SOPS. These are
   nested YAML keys, matching the slash-separated secret names in the module.

After deployment, sign in as `dave` with the bootstrap password and link Pocket ID
from the account settings. Local login remains enabled; automatic OIDC account
creation is disabled. The bootstrap secret creates the account and is not a
password reset mechanism for an existing account.

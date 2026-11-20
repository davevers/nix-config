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

# AGENTS.md

Guidelines for agentic coding assistents working on nix-config.

## Project information

- This is a personal repository containing my nix configuration for several hosts and users.
- It uses a dendritic pattern with aspects using denful/den
- Homemanager is not used, hjem is used to manage home files
- In the future, I might want to migrate to wrapped packages instead
- File structure:
    - `modules/`: contains aspects that are used in the configuration
- Hosts:
    - `loki`: personal laptop configuration
    - `igloo`: vm used for testing
    - In the future I want to manage more hosts: desktops, servers, WSL
- Users:
    - `dave`: the primary user on systems
    - `tux`: used in the vm for testing

## Testing

- Use `nixfmt` for linting
- Use a dry-run: `nixos-rebuild dry-run --flake .#loki` for the loki host

## Theming

- Desktop theming is centralized in `modules/desktop/theme.nix`
- Per-user theme selection lives on the host user records, for example `den.hosts.x86_64-linux.loki.users.dave.theme.base16.scheme`
- Desktop app modules should consume the shared Base16 palette from `local.theme.base16` instead of hard-coding colors per app
- When adding new schemes, extend the catalog in `modules/desktop/theme.nix`

## Boundaries

- ✅ **Always do:** Write new aspects, make small changes to existing aspects, run `nixfmt` for linting
- ⚠️ **Ask first:** Before modifying existing aspects in a major way
- 🚫 **Never do:** Apply the configuration, commit secrets

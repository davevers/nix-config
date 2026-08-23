# Runtime theming

The active theme is runtime state. Nix declares the available families, their
native application mappings, and the packages needed to apply them; it does not
declare which family or mode is currently selected.

`theme-switch` is the source of truth. Its state is stored in
`$XDG_STATE_HOME/theme-switcher/current.json` and defaults to Rosé Pine Light on
the first run.

## Commands

```console
theme-switch status
theme-switch list
theme-switch apply
theme-switch family rose-pine
theme-switch mode dark
theme-switch mode light
theme-switch toggle
theme-switch pick
theme-switch pick-mode
```

`pick` selects a family and retains the current mode. `pick-mode` selects the
mode. Both use Fuzzel by default and fall back to Wofi or Rofi. Set
`THEME_PICKER` to use another dmenu-compatible command.

## Ownership

- `modules/theme/default.nix` declares families, mappings, runtime dependencies,
  and the switcher package. It contains no application theme content.
- `dots/theme-switcher/theme-switch` coordinates changes and owns its mutable
  output files.
- `dots/noctalia/theme.toml` gives Noctalia its own palette and connects its
  dark/light toggle to `theme-switch accept-mode`.
- Hjem owns stable application configuration but does not own files that the
  switcher replaces at runtime.

Noctalia templates are deliberately enabled with empty allowlists. Noctalia
uses its selected palette for its own surfaces but does not generate application
themes.

## Source layout

Curated application themes live under the application that consumes them:

```text
dots/<application>/themes/<family>/
```

The initial family therefore has directories such as:

```text
dots/bat/themes/rose-pine/
dots/fish/themes/rose-pine/
dots/fzf/themes/rose-pine/
dots/kitty/themes/rose-pine/
dots/lazygit/themes/rose-pine/
dots/niri/themes/rose-pine/
```

These are immutable source files. The switcher copies the selected files to the
application's conventional active path; it never edits the sources in `dots/`.
Applications such as Ghostty that ship the preferred themes themselves only
need native theme-name mappings in the catalog.

## Application strategies

- Kitty uses its native `dark-theme.auto.conf`, `light-theme.auto.conf`, and
  `no-preference-theme.auto.conf` mechanism.
- Ghostty uses its native paired light/dark theme setting from an optional
  runtime fragment.
- Fish uses the native dual-mode Rosé Pine Auto theme.
- Bat and LazyGit receive native theme files selected for the active mode.
- FZF reads mode-specific native options from `FZF_DEFAULT_OPTS_FILE`.
- Niri receives the native Rosé Pine cursor variant through an optional,
  reloadable config fragment.
- GTK and portal-aware applications follow
  `org.gnome.desktop.interface color-scheme`.

The mutable outputs are:

```text
~/.config/bat/config
~/.config/bat/themes/<native-theme-name>.tmTheme
~/.config/fish/themes/Theme Switcher.theme
~/.config/ghostty/theme.ghostty
~/.config/kitty/{dark,light,no-preference}-theme.auto.conf
~/.config/lazygit/config.yml
~/.config/niri/theme.kdl
~/.local/state/theme-switcher/
```

These paths must remain outside Hjem, Stow, or Chezmoi ownership unless the
external dotfile manager supports marking them as runtime-generated files.

## Adding a family

Add the native variants below each application's `themes/<family>/` directory,
then add an entry under `catalog.families` in `modules/theme/default.nix`. Every
family must provide all currently supported application mappings. This makes a
missing native theme a build/reconciliation error instead of silently falling
back to Noctalia-generated colors.

Noctalia's family mapping is downstream state: `theme-switch` sends the mapped
palette through Noctalia IPC. A palette selected manually in Noctalia is not
adopted as the global family and will be restored on the next apply.

Noctalia is the one supported secondary input for mode changes. Its
`theme_mode_changed` hook changes only the switcher's mode and preserves the
selected family. On Noctalia startup, `theme-switch apply` restores the complete
canonical state into Noctalia and all adapters. When a script-driven mode change
is echoed back through the hook, `accept-mode` recognizes that canonical state
already matches and exits without applying the adapters a second time.

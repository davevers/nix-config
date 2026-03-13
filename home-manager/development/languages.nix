{ pkgs, ...}: {
  home.packages = with pkgs; [
    # Python
    python
    uv
    ruff
    basedpywright

    # Lua
    lua-language-server
    stylua

    # Nix
    nixd
    nixfmt
  ];
}

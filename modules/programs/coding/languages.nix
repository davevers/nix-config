{
  flake.modules.homeManager.programming =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        # Python
        python3
        uv
        ruff
        basedpyright

        # Lua
        lua-language-server
        stylua

        # Nix
        nixd
        nixfmt
      ];
    };
}

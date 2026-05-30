{
  den.aspects.dev = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          python3
          uv
          ty
          ruff
        ];
      };
  };
}

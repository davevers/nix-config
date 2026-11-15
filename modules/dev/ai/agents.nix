{
  den.aspects.dev = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          codex
          pi-coding-agent
          bubblewrap
        ];
      };
  };
}

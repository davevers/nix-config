{
  den.aspects.zed = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [ zed-editor-fhs ];
      };
  };
}

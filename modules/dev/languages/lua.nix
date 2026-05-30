{
  den.aspects.dev = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          lua-language-server
          stylua
        ];
      };
  };
}

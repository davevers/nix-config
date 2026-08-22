{
  den.aspects.proton = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        proton-vpn
        proton-pass
        proton-pass-cli
        protonmail-desktop
      ];
    };
  };
}

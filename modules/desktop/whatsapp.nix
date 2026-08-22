{
  den.aspects.whatsapp = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        whatsie
      ];
    };
  };
}

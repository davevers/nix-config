{ den, ... }:
{
  den.aspects.dev = {
    includes = [
      (den.batteries.unfree [
        "chatgpt"
      ])
    ];
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          handy
          chatgpt
        ];
      };
  };
}

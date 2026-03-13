{ pkgs, ...}: {
  home.packages = with pkgs; [
    xwayland-satellite
    wl-clipboard
  ];
}

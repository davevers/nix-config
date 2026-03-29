{
  flake.modules.nixos.greetd =
    { pkgs, ... }:
    {
      services.greetd = {
        enable = true;
        settings = {
          initial_session = {
            command = "niri-session";
            user = "dave";
          };
          default_session = {
            command = "${pkgs.tuigreet}/bin/tuigreet --remember  --asterisks  --container-padding 2 --no-xsession-wrapper --cmd niri-session";
          };
        };
      };

      security.pam.services.login.enableGnomeKeyring = true;
      security.pam.services.greetd.text = ''
        auth      substack      login
        account   include       login
        password  substack      login
        session   optional      ${pkgs.unstable.pam_fde_boot_pw}/lib/security/pam_fde_boot_pw.so inject_for=gkr
        session   include       login
      '';
      boot.initrd.systemd.enable = true;
      services.gnome.gnome-keyring.enable = true;
    };
}

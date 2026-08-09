{
  den,
  inputs,
  self,
  ...
}:
{
  # Host-level sops setup
  den.aspects.sops =
    { host, ... }:
    {
      nixos =
        { ... }:
        {
          imports = [
            inputs.sops-nix.nixosModules.sops
          ];

          sops = {
            defaultSopsFile = self + /secrets/${host.hostName}.yaml;
            age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
          };
        };
    };
}

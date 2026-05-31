# just is a command runner, Justfile is very similar to Makefile, but simpler.

############################################################################
#
#  Nix commands related to the local machine
#
############################################################################

deploy:
  sudo nixos-rebuild switch --flake .

debug:
  sudo nixos-rebuild switch --flake . --use-remote-sudo --show-trace --verbose

update:
  nix flake update

fmt:
  nixfmt flake.nix modules/*.nix modules/*/*.nix modules/*/*/*.nix

fmt-check:
  nixfmt --check flake.nix modules/*.nix modules/*/*.nix modules/*/*/*.nix

dry-run-loki:
  nixos-rebuild dry-run --flake .#loki

check: fmt-check dry-run-loki

history:
  nix profile history --profile /nix/var/nix/profiles/system

repl:
  nix repl -f flake:nixpkgs

clean:
  # remove all generations older than 7 days
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

gc:
  # garbage collect all unused nix store entries
  sudo nix-collect-garbage --delete-old

{
  self,
  inputs,
  ...
}:
{
  perSystem =
    { pkgs, system, ... }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [
          (final: _prev: {
            unstable = import inputs.nixpkgs-unstable {
              system = final.system;
              config.allowUnfree = true;
            };
          })
        ];
        config = { };
      };
      packages.myNeovim = inputs.mnw.lib.wrap pkgs {
        neovim = pkgs.unstable.neovim-unwrapped;
        luaFiles = [
          ./nvim/init.lua
        ];
        extraBinPath = with pkgs; [
          lua-language-server
          stylua
        ];
        plugins = {
          start = with pkgs.unstable.vimPlugins; [
            mini-nvim
            pkgs.vimPlugins.nvim-treesitter.withAllGrammars
            nvim-lspconfig
            conform-nvim
            friendly-snippets
            everforest
          ];
          dev.myconfig = {
            pure = ./nvim;
            impure = "~/workspace/nix-config/modules/programs/cli-tools/neovim/nvim";
          };
        };
      };
    };
}

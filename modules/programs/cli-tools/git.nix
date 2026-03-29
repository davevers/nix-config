{
  flake.modules.homeManager.git = {
    programs.git = {
      enable = true;
      settings = {
        push.autoSetupRemote = true;
        pull.rebase = true;
      };
    };

    programs.gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };

    programs.lazygit = {
      enable = true;
    };
  };
}

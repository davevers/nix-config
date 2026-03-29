{
  inputs,
  ...
}:
{
  flake.modules.homeManager.firefox =
    {
      config,
      pkgs,
      ...
    }:
    {
      programs.firefox = {
        enable = true;
        profiles.${config.home.username} = {
          id = 0;
          isDefault = true;
          settings = {
          };
          search = {
            force = true;
            default = "Kagi";
            order = [
              "Kagi"
              "nix-packages"
              "nixos-wiki"
              "ddg"
            ];
            engines = {
              nix-packages = {
                name = "Nix Packages";
                urls = [
                  {
                    template = "https://search.nixos.org/packages";
                    params = [
                      {
                        name = "type";
                        value = "packages";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];

                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@np" ];
              };

              nixos-wiki = {
                name = "NixOS Wiki";
                urls = [ { template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; } ];
                iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
                definedAliases = [ "@nw" ];
              };

              Kagi = {
                urls = [
                  { template = "https://kagi.com/search?q={searchTerms}"; }
                ];
                # icon = "https://kagi.com/favicon.ico";
                icon = "https://assets.kagi.com/v2/favicon-32x32.png";
                definedAliases = [
                  "@kg"
                  "@kagi"
                ];
              };
            };
          };
          extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            privacy-badger
            proton-pass
            web-clipper-obsidian
            kagi-search
            kagi-translate
          ];
          extensions.force = true;
          settings = {
            # Show previous session on startup (3 = restore session)
            "browser.startup.page" = 3;

            # Remember zoom level per site
            "browser.zoom.siteSpecific" = true;

            # Disable all ai
            "browser.ai.control.default" = "blocked";
            "browser.ai.control.linkPreviewKeyPoints" = "blocked";
            "browser.ai.control.pdfjsAltText" = "blocked";
            "browser.ai.control.sidebarChatbot" = "blocked";
            "browser.ai.control.smartTabGroups" = "blocked";
            "browser.ai.control.translations" = "blocked";

            # Vertical tabs
            "sidebar.verticalTabs" = true;

            # Disable first-run stuff
            "browser.disableResetPrompt" = true;
            "browser.download.panel.shown" = true;
            "browser.feeds.showFirstRunUI" = false;
            "browser.messaging-system.whatsNewPanel.enabled" = false;
            "browser.rights.3.shown" = true;
            "browser.shell.checkDefaultBrowser" = false;
            "browser.shell.defaultBrowserCheckCount" = 1;
            "browser.startup.homepage_override.mstone" = "ignore";
            "browser.uitour.enabled" = false;
            "startup.homepage_override_url" = "";
            "trailhead.firstrun.didSeeAboutWelcome" = true;
            "browser.bookmarks.restore_default_bookmarks" = false;
            "browser.bookmarks.addedImportButton" = true;

            # Don't ask for download directory
            "browser.download.useDownloadDir" = false;

            # Security hardening
            "privacy.trackingprotection.enabled" = true;
            "dom.security.https_only_mode" = true;

            # Disable and hide Firefox account syncing
            "identity.fxaccounts.enabled" = false;

            # Cookie persistence behavior
            "network.cookie.lifetimePolicy" = 0; # Accept cookies normally
            "privacy.clearOnShutdown.cookies" = false; # Don't clear cookies on shutdown
            "privacy.clearOnShutdown.siteSettings" = false; # Keep site permissions/settings
            "privacy.sanitize.sanitizeOnShutdown" = false; # Disable general auto-cleanup

            # Needed for proper zoom and feature behavior — disables anti-fingerprinting zoom locking
            "privacy.resistFingerprinting" = false;

            # URL bar autocomplete behavior
            "browser.urlbar.autoFill" = true; # Autocomplete URLs as you type
            "browser.urlbar.dnsFirstForSingleWords" = true; # Resolve single words as domains if possible

            # Enable suggestions in the address bar
            "browser.urlbar.suggest.history" = true; # Suggest URLs from history
            "browser.urlbar.suggest.bookmark" = true; # Suggest bookmarks
            "browser.urlbar.suggest.openpage" = true; # Suggest open tabs
            "browser.urlbar.suggest.searches" = false; # Suggest search engine suggestions

            # Enable search suggestions in the search bar
            "browser.search.suggest.enabled" = true;

            # Disable password saving prompt
            "signon.rememberSignons" = false;
            "passwordmanager.enabled" = false;

            # Disable saving addresses prompt
            "extensions.formautofill.address.enabled" = false;

            # Disable saving payment methods prompt
            "extensions.formautofill.creditCards.enabled" = false;

            # Remove the "Firefox View" button/tab
            "browser.tabs.firefox-view" = false;

            # Disable Pocket integration (saves articles to Firefox Account)
            "extensions.pocket.enabled" = false;

            # Remove ads and sponsored content from new tab page
            "browser.newtabpage.activity-stream.showSponsored" = false;
            "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

            # Removes sponsored content elsewhere
            "browser.urlbar.suggest.quicksuggest.sponsored" = false;

            # Disable news/top stories from Mozilla on new tab page
            "browser.newtabpage.activity-stream.feeds.system.topstories" = false;

            # Disable recommendations
            "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
            "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;

            # Ctrl+Tab cycle through recent used
            "browser.ctrlTab.sortByRecentlyUsed" = true;

            # Disable image preview when hovering a tab
            "browser.tabs.hoverPreview.showThumbnails" = false;
          };
        };
      };
      stylix.targets.firefox = {
        profileNames = [ "${config.home.username}" ];
        colorTheme.enable = true;
      };
    };
}

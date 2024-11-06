{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mapAttrs mkIf;
  cfg = config.icedos;
  firefoxVersion = builtins.substring 0 5 pkgs.firefox.version;

  userJs = ''
    // Global settings
    user_pref("app.update.auto", false);
    user_pref("browser.download.useDownloadDir", true);
    user_pref("browser.ml.chat.enabled", true);
    user_pref("browser.ml.chat.provider", "https://huggingface.co/chat");
    user_pref("browser.newtabpage.enabled", false);
    user_pref("browser.search.separatePrivateDefault", false);
    user_pref("browser.startup.homepage", "chrome://browser/content/blanktab.html");
    user_pref("browser.theme.dark-private-windows", false);
    user_pref("browser.toolbars.bookmarks.visibility", "always");
    user_pref("browser.urlbar.suggest.clipboard", false);
    user_pref("browser.urlbar.suggest.engines", false);
    user_pref("browser.urlbar.suggest.history", false);
    user_pref("browser.urlbar.suggest.openpage", false);
    user_pref("browser.urlbar.suggest.recentsearches", false);
    user_pref("browser.urlbar.suggest.topsites", false);
    user_pref("devtools.debugger.features.windowless-service-workers", true);
    user_pref("dom.webgpu.enabled", true);
    user_pref("general.autoScroll", true);
    user_pref("general.useragent.override", "Mozilla/5.0 (X11; Linux x86_64; rv:${firefoxVersion}) Gecko/20100101 Firefox/${firefoxVersion}");
    user_pref("image.jxl.enabled", true); // Enable JPEG XL support
    user_pref("middlemouse.paste", false);
    user_pref("permissions.default.desktop-notification", 0);
    user_pref("privacy.sanitize.sanitizeOnShutdown", true);
    user_pref("svg.context-properties.content.enabled", true);
    user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
    user_pref("zen.tabs.show-newtab-under", false);
    user_pref("zen.theme.accent-color", "#d4bbff");
    user_pref("zen.theme.color-prefs.amoled", true);
    user_pref("zen.view.sidebar-expanded", false);
    user_pref("zen.view.sidebar-expanded.on-hover", true);

    ${
      if (!cfg.applications.zen-browser.privacy) then
        ''
          user_pref("privacy.clearOnShutdown.downloads", false);
          user_pref("privacy.clearOnShutdown.history", false);
        ''
      else
        ''
          user_pref("browser.startup.page", 1);
          user_pref("privacy.clearOnShutdown_v2.historyFormDataAndDownloads", true);
          user_pref("signon.rememberSignons", false);
        ''
    }

    // Overrides
    ${
      if (cfg.applications.zen-browser.overrides) then
        ''
          user_pref("browser.uiCustomization.state", "{\"placements\":{\"widget-overflow-fixed-list\":[],\"unified-extensions-area\":[\"_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"pipewire-screenaudio_icenjim-browser-action\",\"_8540a13e-ae0f-4a36-a8a0-381bfe083ef8_-browser-action\",\"7esoorv3_alefvanoon_anonaddy_me-browser-action\",\"canvasblocker_kkapsner_de-browser-action\",\"addon_darkreader_org-browser-action\",\"addon_simplelogin-browser-action\",\"jid1-kkzogwgsw3ao4q_jetpack-browser-action\",\"languagetool-webextension_languagetool_org-browser-action\",\"plasma-browser-integration_kde_org-browser-action\",\"smart-referer_meh_paranoid_pk-browser-action\",\"_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action\",\"_a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7_-browser-action\",\"_7efbd09d-90ad-47fa-b91a-08c472bdf566_-browser-action\"],\"nav-bar\":[\"back-button\",\"forward-button\",\"stop-reload-button\",\"urlbar-container\",\"unified-extensions-button\",\"downloads-button\",\"wrapper-sidebar-button\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"],\"PersonalToolbar\":[\"personal-bookmarks\"]},\"seen\":[\"pipewire-screenaudio_icenjim-browser-action\",\"_8540a13e-ae0f-4a36-a8a0-381bfe083ef8_-browser-action\",\"7esoorv3_alefvanoon_anonaddy_me-browser-action\",\"canvasblocker_kkapsner_de-browser-action\",\"addon_darkreader_org-browser-action\",\"addon_simplelogin-browser-action\",\"jid1-kkzogwgsw3ao4q_jetpack-browser-action\",\"languagetool-webextension_languagetool_org-browser-action\",\"plasma-browser-integration_kde_org-browser-action\",\"smart-referer_meh_paranoid_pk-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action\",\"_a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7_-browser-action\",\"_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action\",\"_7efbd09d-90ad-47fa-b91a-08c472bdf566_-browser-action\",\"developer-button\"],\"dirtyAreaCache\":[\"unified-extensions-area\",\"nav-bar\",\"toolbar-menubar\",\"TabsToolbar\",\"PersonalToolbar\"],\"currentVersion\":20,\"newElementCount\":4}");
        ''
      else
        ""
    }
  '';
in
mkIf (cfg.applications.zen-browser.enable) {
  home-manager.users = mapAttrs (user: _: {
    home.file.".zen/default/user.js".text = userJs;
    home.file.".zen/pwas/user.js".text =
      if (cfg.applications.zen-browser.pwas.enable) then
        userJs
        + ''
          user_pref("zen.view.sidebar-expanded.on-hover", false);
          user_pref("browser.toolbars.bookmarks.visibility", "never");
        ''
      else
        "";
  }) cfg.system.users;
}

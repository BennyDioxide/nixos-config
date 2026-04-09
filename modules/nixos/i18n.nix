{ flake, pkgs, ... }:
let
  inherit (flake) self;
in
{
  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocales = [
    "en_GB.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
    "zh_TW.UTF-8/UTF-8"
    "ja_JP.UTF-8/UTF-8"
  ];

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        (pkgs.fcitx5-rime.override {
          rimeDataPkgs = [
            pkgs.rime-data
            self.packages.${stdenv.hostPlatform.system}.rime-yuhao-ming
          ];
        })
        fcitx5-mozc-ut
        kdePackages.fcitx5-chinese-addons
        fcitx5-hangul
        fcitx5-lua
        lua53Packages.luasocket # For ~/.config/fcitx5/addon/kanata/lib.lua
      ];
      waylandFrontend = true;
    };
  };

}

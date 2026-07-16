{
  lib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    hyprland-qtutils
    hyprland-qt-support
    hyprcursor
    hyprpicker
    hyprutils
    hyprwayland-scanner
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    extraLuaFiles = {
      "00-fennel" = ''
        package.path = package.path .. ";${pkgs.lua55Packages.fennel}/share/lua/5.5/?.lua"
        require("fennel").install().dofile("${./config.fnl}")
      '';
      "01-startup" = ''
        hl.on("hyprland.start", function ()
          local commands = {
            "noctalia",
            "fcitx5",
            "${lib.getExe pkgs.dex} -as ~/.config/autostart",
            -- "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1",
            "${pkgs.kdePackages.kwallet-pam}/libexec/pam_kwallet_init",
          }
          for _, v in ipairs(commands) do
            hl.exec_cmd(v)
          end
        end)
      '';
    };
    settings = {
      # See https://wiki.hyprland.org/Configuring/Monitors/
      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      config = {
        input = {
          # See /usr/share/X11/xkb/rules/base.lst
          kb_layout = "us";
          # kb_variant = "colemak_dh";

          follow_mouse = 0;

          natural_scroll = false;

          numlock_by_default = true;
        };
        cursor = {
          no_hardware_cursors = 0;
        };
        general = {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          gaps_in = 5;
          gaps_out = 20;
          border_size = 2;

          layout = "scrolling";
        };
        scrolling = {
          column_width = 0.7;
          fullscreen_on_one_column = true;
        };
        decoration = {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          rounding = 10;
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
          };
          shadow = {
            enabled = true; # previously `drow_shadow`
            range = 4;
            render_power = 3;
            color = "0xee1a1a1a";
          };
        };
      };

      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
      window_rule = [
        {
          match.class = "^(osu!)$";
          match.title = "^(osu!)$";
          fullscreen = true;
        }
        {
          match.class = "^(fl64.exe)";
          match.initial_title = "^(FL Studio)$";
          fullscreen = true;
        }
        {
          match.title = "^(flameshot)$";
          no_anim = true;
          float = true;
          move = [
            0
            0
          ];
        }
      ];

      layer_rule = [
        {
          name = "noctalia";
          match.namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd)$";
          ignore_alpha = 0.5;
          blur = true;
          blur_popups = true;
        }
      ];
    };
  };
}

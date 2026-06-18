(hl.monitor {:output   ""
             :mode     "preferred"
             :position "auto"
             :scale    "auto"
             :bitdepth 10})

(hl.curve "myBezier" {:type "bezier" :points [[0.05 0.9] [0.1 1.05]]})

(hl.animation {:leaf "windows" :enabled true :speed 7 :bezier "myBezier"})
(hl.animation {:leaf "windowsOut" :enabled true :speed 7 :bezier "default" :style "popin 80%"})
(hl.animation {:leaf "border" :enabled true :speed 10 :bezier "default"})
(hl.animation {:leaf "borderangle" :enabled true :speed 8 :bezier "default"})
(hl.animation {:leaf "fade" :enabled true :speed 7 :bezier "default"})
(hl.animation {:leaf "workspaces" :enabled true :speed 6 :bezier "default"})

(let [envs {:XCURSOR_SIZE         "24"
            :LC_ALL               "zh_TW.UTF-8"
            :LANG                 "zh_TW.UTF-8"
            :QT_QPA_PLATFORMTHEME "qt6ct"
            :SDL_VIDEODRIVER      "wayland"
            :GTK_IM_MODULE        "wayland"
            :XIM_MODULE           "@im=fcitx"}]
  (each [key value (pairs envs)]
    (hl.env key value)))

(let [mainMod     "SUPER"
      terminal    "ghostty"
      fileManager "dolphin"
      noctaliactl "noctalia msg"
      menu        (.. noctaliactl " panel-toggle launcher")]
  (hl.bind (.. mainMod " + Q") (hl.dsp.exec_cmd "ghostty"))
  (hl.bind (.. mainMod " + C") (hl.dsp.window.close))
  (hl.bind (.. mainMod " + M") (hl.dsp.exit))
  (hl.bind (.. mainMod " + E") (hl.dsp.exec_cmd "dolphin"))
  (hl.bind (.. mainMod " + V") (hl.dsp.window.float))
  (each [_ keys (ipairs [(.. mainMod " + R") "ALT + space"])]
    (hl.bind keys (hl.dsp.exec_cmd menu)))
  (hl.bind (.. mainMod " + comma") (hl.dsp.exec_cmd (.. noctaliactl " panel-toggle control-center")))
  (hl.bind (.. mainMod " + F") (hl.dsp.window.fullscreen {:mode "fullscreen"}))
  (hl.bind (.. mainMod " + L") (hl.dsp.exec_cmd (.. noctaliactl " session lock")))
  (hl.bind "Print" (hl.dsp.exec_cmd "flameshot gui"))
  (each [_ direction (ipairs ["left" "right" "up" "down"])]
    (hl.bind (.. mainMod " + " direction) (hl.dsp.focus {: direction})))
  (for [workspace 1 10]
    (let [key (% workspace 10)]
      (hl.bind (.. mainMod " + " key) (hl.dsp.focus {: workspace}))
      (hl.bind (.. mainMod " + SHIFT + " key) (hl.dsp.window.move {: workspace}))))
  (hl.bind (.. mainMod " + mouse_up") (hl.dsp.layout "move +col"))
  (hl.bind (.. mainMod " + mouse_down") (hl.dsp.layout "move -col"))
  (hl.bind (.. mainMod " + CTRL + mouse_up") (hl.dsp.focus {:workspace "+1"}))
  (hl.bind (.. mainMod " + CTRL + mouse_down") (hl.dsp.focus {:workspace "-1"}))
  (hl.bind (.. mainMod " + SHIFT + mouse_up") (hl.dsp.window.move {:direction "r"}))
  (hl.bind (.. mainMod " + SHIFT + mouse_down") (hl.dsp.window.move {:direction "l"}))
  (hl.bind "XF86AudioPlay" (hl.dsp.exec_cmd "playerctl play-pause") {:locked true})
  (hl.bind "XF86AudioPause" (hl.dsp.exec_cmd "playerctl play-pause") {:locked true})
  (hl.bind "XF86AudioPrev" (hl.dsp.exec_cmd "playerctl pervious") {:locked true})
  (hl.bind "XF86AudioNext" (hl.dsp.exec_cmd "playerctl next") {:locked true})
  (hl.bind "XF86AudioMute" (hl.dsp.exec_cmd (.. noctaliactl " volume-mute")) {:locked true})
  (hl.bind "XF86AudioRaiseVolume" (hl.dsp.exec_cmd (.. noctaliactl " volume-up")) {:locked true :repeating true})
  (hl.bind "XF86AudioLowerVolume" (hl.dsp.exec_cmd (.. noctaliactl " volume-down")) {:locked true :repeating true})
  (hl.bind "XF86MonBrightnessUp" (hl.dsp.exec_cmd (.. noctaliactl " brightness-up")) {:locked true :repeating true})
  (hl.bind "XF86MonBrightnessDown" (hl.dsp.exec_cmd (.. noctaliactl " brightness-down")) {:locked true :repeating true})
  (hl.bind (.. mainMod " + mouse:272") (hl.dsp.window.drag) {:mouse true})
  (hl.bind (.. mainMod " + mouse:273") (hl.dsp.window.resize) {:mouse true}))

(require :noctalia)


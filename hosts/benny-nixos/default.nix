# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  options,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    # ./immich.nix
    ../../secrets/nixos.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
        theme = pkgs.sleek-grub-theme;
        configurationLimit = 10;
      };
    };
    plymouth.enable = true;
    supportedFilesystems = [
      "ntfs"
      "bcachefs"
    ];
  };

  networking.hostName = "benny-nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  networking.nameservers = [
    "1.1.1.1"
    "100.100.100.100"
  ]; # 100.100.100.100 for Tailscale
  services.tailscale.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Taipei";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.supportedLocales = [
    "en_GB.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
    "zh_TW.UTF-8/UTF-8"
    "ja_JP.UTF-8/UTF-8"
  ];
  console = {
    font = "Lat2-Terminus16";
    # disabled because of kanata
    # keyMap = "mod-dh-ansi-us";
    # useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "mod-dh-ansi-us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable sound.
  security.rtkit.enable = true;
  # Remove sound.enable or set it to false if you had it set previously, as sound.enable is only meant for ALSA-based configurations
  # -- https://nixos.wiki/wiki/PipeWire
  # sound.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Musnix
  musnix.enable = true;

  security.polkit.enable = true;

  programs.adb.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.benny = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "network"
      "kvm" # Hardware accelerated vm
      "adbusers" # Use adb without privileges
      "audio" # Musnix
      "samba"
      "syncthing"
    ];
    shell = pkgs.nushell;
    hashedPassword = "$y$j9T$GMklPzea3Rd5zj48qqJEj0$tZ4IoTGPALA8S5HCtVwkuYvVUkOUmKM7jPiim14kg38";
  };

  users.users.root.hashedPassword = "$y$j9T$jrT0uHVlo0mJwIL/2q4sV/$clddNgUJGUqn4md5Og6Oue1xcfuJqa2PO4oha46wxi3";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    neovim
    helix
    wget
    git
    nushell # no dataframe
    zellij
    btop
    bottom
    # procmon
    broot
    yazi
    nnn
    eza
    tealdeer
    bat
    ripgrep
    fd
    fzf
    git
    via
    just
    nh
    nvtopPackages.nvidia
    duperemove
    perf

    kdePackages.partitionmanager
  ];

  programs.zsh.enable = true;

  environment.shells = with pkgs; [
    zsh
    nushell
  ];

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-rime
        fcitx5-mozc-ut
        fcitx5-lua
        lua53Packages.luasocket # For ~/.config/fcitx5/addon/kanata/lib.lua
      ];
      waylandFrontend = true;
    };
  };

  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    preferences = {
      "widget.use-xdg-desktop-portal.file-picker" = 1;
      "dom.webgpu.enabled" = true;
      "gfx.webgpu.force-enabled" = true;
    };
  };

  programs.wireshark.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  services.syncthing.enable = true;
  services.syncthing.openDefaultPorts = true;
  services.syncthing.user = "benny";
  services.syncthing.dataDir = config.users.users.benny.home;
  programs.kdeconnect.enable = true;
  networking.firewall.allowPing = true;
  services.aria2.enable = true;
  services.aria2.openPorts = true;
  services.aria2.settings.rpc-allow-origin-all = true;
  services.aria2.settings.dir = "/mnt/segate4t/Downloads";
  services.aria2.rpcSecretFile = config.age.secrets.aria2.path;
  services.samba = {
    enable = true;
    settings.global.security = "user";
    openFirewall = true;
    usershares.enable = true;
  };
  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };

  programs.localsend.enable = true;
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  services.xserver = {
    enable = true;
    excludePackages = with pkgs; [ xterm ];
  };

  services.displayManager = {
    defaultSession = "hyprland";
    autoLogin = {
      enable = true;
      user = "benny";
    };
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    autoNumlock = true;
  };

  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    oxygen
    elisa
  ];

  # Enable Hyprland in sddm
  programs.hyprland.enable = true;

  # https://nixos.wiki/wiki/KDE#GTK_themes_are_not_applied_in_Wayland_applications_.2F_Window_Decorations_missing_.2F_Cursor_looks_different
  programs.dconf.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      # vaapiVdpau
      nvidia-vaapi-driver
      libvdpau-va-gl
    ];
  };

  # Load Nvidia driver for XOrg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement.enable = true;

    open = true;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  hardware.nvidia-container-toolkit.enable = true;

  services.ollama = {
    enable = false;
    acceleration = "cuda";
    models = "/mnt/segate4t/ollama/models";
  };

  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.ovmf.packages = [ pkgs.OVMFFull.fd ];
  programs.virt-manager.enable = true;

  # virtualisation.waydroid.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  services.sunshine.enable = true;
  services.sunshine.capSysAdmin = true;

  services.freshrss.enable = true;
  # services.freshrss.authType = "none";
  services.freshrss.defaultUser = "benny";
  services.freshrss.baseUrl = "http://benny-nixos/";
  services.freshrss.passwordFile = config.age.secrets.freshrss.path;

  hardware.keyboard.qmk.enable = true;
  services.udev.packages = [ pkgs.via ];

  services.guix.enable = true;
  services.guix.gc.enable = true;
  services.guix.substituters.urls = [
    "https://mirror.sjtu.edu.cn/guix"
    "https://substitutes.nonguix.org"
  ]
  ++ options.services.guix.substituters.urls.default;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}

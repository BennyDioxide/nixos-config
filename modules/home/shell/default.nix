{ ... }:

{
  imports = [
    ./nu
    ./zsh.nix
  ];
  programs.zellij = {
    enable = true;
    settings = {
      # default_shell = "nu";
    };
  };

  programs.btop.enable = true;
  programs.btop.settings = {
    swap_disk = false;

    disks_filter = "exclude=/root /swap/swapfile /gnu /nix/persistent /var /var/log /var/cache /srv /etc/ssh /etc/NetworkManager/system-connections /";
  };

  programs.starship.enable = true;
  programs.carapace.enable = true;
  programs.zoxide.enable = true;
  programs.atuin.enable = true;
  programs.atuin.flags = [ "--disable-up-arrow" ];
  # programs.broot.enable = true;
  programs.yazi.enable = true;
  programs.nix-index.enable = true;
}

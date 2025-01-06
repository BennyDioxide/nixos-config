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

  programs.starship.enable = true;
  programs.carapace.enable = true;
  programs.zoxide.enable = true;
  programs.atuin.enable = true;
  programs.atuin.flags = [ "--disable-up-arrow" ];
  # programs.broot.enable = true;
  programs.yazi.enable = true;
}

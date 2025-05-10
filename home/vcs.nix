{ ... }:

let
  name = "BennyDioxide";
  email = "bennystyang@proton.me";
  editor = "helix";
in
{
  programs.git = {
    enable = true;
    userName = name;
    userEmail = email;
    extraConfig = {
      core.editor = editor;
      core.autocrlf = "input";
      credential.helper = "store";
      color.ui = "auto";
      filter.lfs = {
        smudge = "git-lfs smudge -- %f";
        process = "git-lfs filter-process";
        required = true;
        clean = "git-lfs clean -- %f";
      };
    };
  };

  programs.jujutsu = {
    enable = true;
    settings = {
      user = { inherit name email; };
      ui = { inherit editor; };
    };
  };
}

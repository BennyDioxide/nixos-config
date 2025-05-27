{ lib, pkgs, ... }:

let
  name = "BennyDioxide";
  email = "bennystyang@proton.me";
  editor = lib.getExe pkgs.helix;
  pager = lib.getExe pkgs.delta;
in
{
  programs.git = {
    enable = true;
    userName = name;
    userEmail = email;
    extraConfig = {
      core.editor = editor;
      core.pager = pager;
      core.autocrlf = "input";
      credential.helper = "store";
      interactive.diffFilter = "${pager} --color-only";
      delta.navigate = true;
      merge.conflitstyle = "zdiff3";
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

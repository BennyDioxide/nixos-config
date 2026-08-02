{ lib, pkgs, ... }:

let
  name = "BennyDioxide";
  email = "bennystyang@proton.me";
  editor = lib.getExe pkgs.helix;
  pager = lib.getExe pkgs.delta;
in
{
  home.packages = [
    pkgs.lazyjj
  ];

  programs.git = {
    enable = true;
    signing.format = null; # 25.05+ behaviour, let git/gpg decide
    settings = {
      user = {
        inherit name email;
      };
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
      ui = {
        inherit editor;
        default-command = "log";
      };
      /*nixfmt:disable*/
      aliases = {
        n = [ "new" ];
        e = [ "edit" ];
        s = [ "show" ];
        d = [ "desc" ];
        f = [ "git" "fetch" ];
        p = [ "git" "push" ];
        r = [ "rebase" ];
        blame = [ "file" "annotate" ];
        # https://shaddy.dev/notes/jj-tug
        # https://www.jj-vcs.dev/latest/cli-reference/#jj-bookmark-advance
        tug = [ "bookmark" "advance" ];
        "-" = [ "edit" "@-" ];
        "+" = [ "edit" "@+" ];
      };
    };
  };
}

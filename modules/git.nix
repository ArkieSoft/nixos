{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    userEmail = "wyatt@arkannon.com";
    userName = "ArkieSoft@Github";
    extraConfig = {
      credential.helper = "${
        pkgs.git.override { withLibsecret = true; } 
        }/bin/git-credential-libsecret";
    };
    ignores = [
      "/mailserver/passwords/"
    ];
  };
}

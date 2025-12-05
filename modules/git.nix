{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        Email = "wyatt@arkannon.com";
        Name = "ArkieSoft@Github";
      };
      extraConfig = {
        credential.helper = "${
          pkgs.git.override { withLibsecret = true; } 
          }/bin/git-credential-libsecret";
      };
    };
    ignores = [
      "/mailserver/passwords/"
    ];
  };
}

{ config, pkgs, ... }:
{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud30;
    hostName = "cloud.arkannon.com";
    https = true;
    configureRedis = true;
    maxUploadSize = "20G";
    config = {
      adminpassFile = "/etc/nextcloud-admin-pass";
      adminuser = "admin";
    };
    settings = {
      log_type = "file";
    };
    extraAppsEnable = true;
    extraApps = {
      inherit (pkgs.nextcloud30Packages.apps) calendar contacts notes news;
      cookbook = pkgs.fetchNextcloudApp {
        sha256 = "sha256-upbTdzu17BH6tehgCUcTxBvTVOO31Kri/33vGd4Unyw=";
        url = "https://github.com/christianlupus-nextcloud/cookbook-releases/releases/download/v0.11.2/cookbook-0.11.2.tar.gz";
        license = "agpl3Only";
      };
      picker = pkgs.fetchNextcloudApp {
        sha256 = "sha256-v/CoSNPoiasaEyZRbSnJTwcXBDOjCHvaPVP3f6keoss=";
        url = "https://github.com/nextcloud-releases/picker/releases/download/v1.0.10/picker-v1.0.10.tar.gz";
        license = "agpl3Only";
      };
      pride_flags = pkgs.fetchNextcloudApp {
        sha256 = "sha256-AC1DsCHzKVhXtYStSRBDFGgRHlK4WUegAJ5m5mr02yo=";
        url = "https://git.finally.coffee/finallycoffee/nextcloud-pride-flags/releases/download/1.1.1/pride_flags-1.1.1.tar.gz";
        license = "gpl3";
      };
      secrets = pkgs.fetchNextcloudApp {
        sha256 = "sha256-tTe6mS1aaLZRACUhGgEINKzhz+vNigPcVTtEY87mQQQ=";
        url = "https://github.com/theCalcaholic/nextcloud-secrets/releases/download/v2.1.1/secrets.tar.gz";
        license = "agpl3Only";
      };
      permissions_overwrite = pkgs.fetchNextcloudApp {
        sha256 = "sha256-qDLmHzLO0PnUT0DSk+U8KvkQKKR/56rZQxuK9FTOtEc=";
        url = "https://github.com/icewind1991/permissions_overwrite/releases/download/v0.1.13/permissions_overwrite-v0.1.13.tar.gz";
        license = "agpl3Only";
      };
      spreed = pkgs.fetchNextcloudApp {
        sha256 = "sha256-mUJmbOMMIkm/83a+7xcW59TTar58D4l0Ek+kZoRdxG8=";
        url = "https://github.com/nextcloud-releases/spreed/releases/download/v20.0.1/spreed-v20.0.1.tar.gz";
        license = "agpl3Only";
      };
      externalportal = pkgs.fetchNextcloudApp {
        sha256 = "sha256-Bdhx6xHzoYi4na8w4g4Nwlg5/GqwqRiHPtfQ2P9sUR8=";
        url = "https://github.com/puavo-org/externalportal/releases/download/v1.3.1/externalportal.tar.gz";
        license = "agpl3Only";
      };
      bookmarks = pkgs.fetchNextcloudApp {
        sha256 = "sha256-F3r+FU5m9vj13bhJqGi7cCtZUxAIL453QUu1y65Ty/I=";
        url = "https://github.com/nextcloud/bookmarks/releases/download/v15.0.2/bookmarks-15.0.2.tar.gz";
        license = "agpl3Only";
      };
      #       passwords = pkgs.fetchNextcloudApp {
      #         sha256 = "sha256-L+jumcussL0c9xNMg/GMs1GSd1IY9wUvC8ZEg+3U+sc=";
      #          url = "https://git.mdns.eu/api/v4/projects/45/packages/generic/passwords/2024.9.0/passwords.tar.gz";
      #          license = "agpl3Only";
      #        };
    };
  };
}

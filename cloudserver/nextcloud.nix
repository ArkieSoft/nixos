{ config, pkgs, ... }:
{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud31;
    hostName = "cloud.arkannon.com";
    https = true;
    configureRedis = true;
    maxUploadSize = "20G";
    config = {
      adminpassFile = "/etc/nextcloud-admin-pass";
      adminuser = "admin";
      dbtype = "sqlite";
    };
    settings = {
      log_type = "file";
    };
    extraAppsEnable = true;
    extraApps = {
      inherit (pkgs.nextcloud31Packages.apps) calendar contacts notes news;
      cookbook = pkgs.fetchNextcloudApp {
        sha256 = "sha256-EWLBypv588IkO1wx0vFv26NSk5GKx1pqSWTlAcW2mwE=";
        url = "https://github.com/christianlupus-nextcloud/cookbook-releases/releases/download/v0.11.3/cookbook-0.11.3.tar.gz";
        license = "agpl3Only";
      };
      picker = pkgs.fetchNextcloudApp {
        sha256 = "sha256-w8SYE2UVb5kJNESoTcQd4W3qiW8Ouk6VefKG9NWtWbs=";
        url = "https://github.com/nextcloud-releases/picker/releases/download/v1.0.12/picker-v1.0.12.tar.gz";
        license = "agpl3Only";
      };
      pride_flags = pkgs.fetchNextcloudApp {
        sha256 = "sha256-7k4OcZe49h2C2tS4EbeBkl4nGHkgkwyEXhEJzwRcfH8=";
        url = "https://git.finally.coffee/finallycoffee/nextcloud-pride-flags/releases/download/1.1.2/pride_flags-1.1.2.tar.gz";
        license = "gpl3";
      };
      secrets = pkgs.fetchNextcloudApp {
        sha256 = "sha256-tTe6mS1aaLZRACUhGgEINKzhz+vNigPcVTtEY87mQQQ=";
        url = "https://github.com/theCalcaholic/nextcloud-secrets/releases/download/v2.1.1/secrets.tar.gz";
        license = "agpl3Only";
      };
#      permissions_overwrite = pkgs.fetchNextcloudApp {
#        sha256 = "sha256-qDLmHzLO0PnUT0DSk+U8KvkQKKR/56rZQxuK9FTOtEc=";
#        url = "https://github.com/icewind1991/permissions_overwrite/releases/download/v0.1.13/permissions_overwrite-v0.1.13.tar.gz";
#        license = "agpl3Only";
#      };
      spreed = pkgs.fetchNextcloudApp {
        sha256 = "sha256-ztc0u9lYd5rZmzFPt1J4fmSBP3ZINswTaqVr4QZtidQ=";
        url = "https://github.com/nextcloud-releases/spreed/releases/download/v21.0.1/spreed-v21.0.1.tar.gz";
        license = "agpl3Only";
      };
##Not compatible with Nextcloud31. Check later
#      externalportal = pkgs.fetchNextcloudApp {
#        sha256 = "sha256-Bdhx6xHzoYi4na8w4g4Nwlg5/GqwqRiHPtfQ2P9sUR8=";
#        url = "https://github.com/puavo-org/externalportal/releases/download/v1.3.1/externalportal.tar.gz";
#        license = "agpl3Only";
#      };
      bookmarks = pkgs.fetchNextcloudApp {
        sha256 = "sha256-oXpTsmjD1zGjNoPoNVIVSVO4nHAoWy0YW3IT797XrRM=";
        url = "https://github.com/nextcloud/bookmarks/releases/download/v15.1.0/bookmarks-15.1.0.tar.gz";
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

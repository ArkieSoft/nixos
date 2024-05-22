{
  enable = true;

  enableBashIntegration = true;

  settings = builtins.fromJSON (builtins.unsafeDiscardStringContext (builtins.readFile "/etc/nixos/M365Princess.omp.json"));
}

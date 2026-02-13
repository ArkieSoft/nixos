{ pkgs, config, self, inputs, lib }:
{
  services = {
    postgresql = {
      enable = true;
      ensureDatabases = [ "matrix-synapse" ];
      ensureUsers = [ "matrix-synapse" ];
    };

  };
}

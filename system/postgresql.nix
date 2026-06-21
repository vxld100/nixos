{ config, lib, pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "jobportal" ];
  };
  environment.systemPackages = [ pkgs.pgmodeler ];
}

{ config, pkgs, lib, ... }:

{
  options.programs.alire = {
    enable = lib.mkEnableOption "Ada development environment with Alire and GNAT";
  };

  config = lib.mkIf config.programs.alire.enable {
    nixpkgs.overlays = [
      (final: prev: {
        # A helper package to ensure Alire is built with gnat15 for consistency.
        alire-with-gnat15 = prev.alire.override {
          gnat = prev.gnat15;
          gprbuild = prev.gnat15Packages.gprbuild;
        };

        # A custom derivation for the pre-built aarch64 binary of Alire.
        alire-bin-aarch64 = prev.stdenv.mkDerivation {
          pname = "alire-bin";
          version = "2.1.0";

          src = prev.fetchurl {
            url = "https://github.com/alire-project/alire/releases/download/v2.1.0/alr-2.1.0-bin-aarch64-linux.zip";
            hash = "sha256-XU1xHirjR1MskxISua7Knrodmrh9bYGcJiuyxdQj02M=";
          };

          nativeBuildInputs = [ prev.unzip prev.autoPatchelfHook prev.stdenv.cc.cc.lib ];

          installPhase = ''
            runHook preInstall
            install -Dm755 alr $out/bin/alr
            runHook postInstall
          '';

          meta = {
            description = "Pre-built binary of the Alire source package manager";
            homepage = "https://alire.ada.dev";
            license = prev.lib.licenses.gpl3Only;
            platforms = [ "aarch64-linux" ];
            mainProgram = "alr";
          };
        };

        # Redefine the 'alire' package to use our conditional logic.
        alire =
          if prev.stdenv.isAarch64 && prev.stdenv.isLinux then
            final.alire-bin-aarch64
          else if prev.stdenv.isx86_64 && prev.stdenv.isLinux then
            prev.alire
          else
	    final.alire-with-gnat15;
      })
    ];

    home.packages = with pkgs; [
      # This 'alire' will now correctly resolve to the version from our overlay.
      alire
    ];
  };
}

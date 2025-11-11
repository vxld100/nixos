{ config, pkgs, lib, ... }:
{
  options.programs.alire = {
    enable = lib.mkEnableOption "Ada development environment with Alire and GNAT";
  };
  config = lib.mkIf config.programs.alire.enable {
    nixpkgs.overlays = [
      (final: prev: {
        # Import the working nixpkgs revision
        workingPkgs = import (builtins.fetchTarball {
          url = "https://github.com/NixOS/nixpkgs/archive/3016b4b15d13f3089db8a41ef937b13a9e33a8df.tar.gz";
          sha256 = "sha256:11p1dpmm7nk15mb60m1ii4jywydy3g7x5qpyr9yarlzfl2c91x1z";  # Nix will tell you the right hash
        }) { system = prev.system; };
        
        # Just use gnat14 from the working revision
        gnat14 = final.workingPkgs.gnat14;
        gnat14Packages = final.workingPkgs.gnat14Packages;
        
        alire-aarch64-from-source = prev.stdenv.mkDerivation (finalAttrs: {
          pname = "alire";
          version = "2.1.0";
          src = prev.fetchFromGitHub {
            owner = "alire-project";
            repo = "alire";
            rev = "v${finalAttrs.version}";
            hash = "sha256-DfzCQu9xOe9JgX6RTrYOGTIS6EcPimLnd5pfXMtfRss=";
            fetchSubmodules = true;
          };
          nativeBuildInputs = [
            final.gnat14
            final.gnat14Packages.gprbuild
          ];
          postPatch = ''
            patchShebangs ./dev/build.sh ./scripts/version-patcher.sh
          '';
          buildPhase = ''
            runHook preBuild
            export ALIRE_BUILD_JOBS="$NIX_BUILD_CORES"
            ./dev/build.sh
            runHook postBuild
          '';
          installPhase = ''
            runHook preInstall
            mkdir -p $out
            cp -r ./bin $out
            runHook postInstall
          '';
          meta = with lib; {
            description = "Source-based package manager for the Ada and SPARK programming languages";
            homepage = "https://alire.ada.dev";
            changelog = "https://github.com/alire-project/alire/releases/tag/v${finalAttrs.version}";
            license = licenses.gpl3Only;
            maintainers = with maintainers; [ atalii ];
            platforms = platforms.unix;
            mainProgram = "alr";
          };
        });
        
        alire =
          if prev.stdenv.isAarch64 && prev.stdenv.isLinux then
            final.alire-aarch64-from-source
          else
            prev.alire.override {
              gnat = final.gnat14;
              gprbuild = final.gnat14Packages.gprbuild;
            };
      })
    ];
    home.packages = with pkgs; [ alire ];
  };
}

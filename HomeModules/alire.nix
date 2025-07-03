{ config, pkgs, lib, ... }:

{
  options.programs.alire = {
    enable = lib.mkEnableOption "Ada development environment with Alire and GNAT";
  };

  config = lib.mkIf config.programs.alire.enable {
    nixpkgs.overlays = [
      (final: prev: {

        # A custom derivation to build Alire from source for aarch64-linux using gnat15.
        alire-aarch64-from-source = prev.stdenv.mkDerivation (finalAttrs: {
          pname = "alire";
          version = "2.1.0";

          # Use `prev.fetchFromGitHub` to get the source from the nixpkgs set
          src = prev.fetchFromGitHub {
            owner = "alire-project";
            repo = "alire";
            # Use `rev` and refer to this derivation's version attribute
            rev = "v${finalAttrs.version}";
            hash = "sha256-DfzCQu9xOe9JgX6RTrYOGTIS6EcPimLnd5pfXMtfRss=";
            fetchSubmodules = true;
          };

          # Use the gnat15 toolchain from the nixpkgs overlay input (`prev`)
          nativeBuildInputs = [
            prev.gnat15
            prev.gnat15Packages.gprbuild
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

          # `lib` is available from the module arguments
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

        # Redefine the 'alire' package
        alire =
          # For aarch64-linux, use our custom source build.
          if prev.stdenv.isAarch64 && prev.stdenv.isLinux then
            final.alire-aarch64-from-source
          # For all other systems, use the standard alire package but override
          # its compiler to be gnat15 for consistency.
          else
            prev.alire.override {
              gnat = prev.gnat15;
              gprbuild = prev.gnat15Packages.gprbuild;
            };
      })
    ];

    home.packages = with pkgs; [
      # This 'alire' will now correctly resolve to the conditional
      # version defined in our overlay.
      alire
    ];
  };
}

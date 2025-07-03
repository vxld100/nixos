# alire.nix
#
# This file defines a Nix overlay to provide a robust, cross-platform Alire package.
# It selects the correct Alire version based on the system architecture.

# The function expects the final package set (final) and the previous one (prev).
# This is the standard signature for a Nix overlay.
final: prev: {

  # A helper package to ensure Alire is built with gnat15 for consistency on x86_64.
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

  # --- This is the key part of the overlay ---
  # We are redefining the 'alire' package attribute. From now on, whenever
  # Nix asks for 'pkgs.alire', it will get the result of this logic.
  alire =
    if prev.stdenv.isAarch64 && prev.stdenv.isLinux then
      # On aarch64-linux, use our pre-built binary package.
      final.alire-bin-aarch64
    else if prev.stdenv.isx86_64 && prev.stdenv.isLinux then
      # On x86_64-linux, use the standard Alire but ensure it's built with gnat15.
      final.alire
    else
      # For any other platform, fall back to the default package from nixpkgs.
      prev.alire-with-gnat15;
}

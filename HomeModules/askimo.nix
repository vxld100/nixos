{ lib
, stdenvNoCC
, fetchurl
, makeWrapper
, openjdk25
, libGL
, fontconfig
, freetype
, xorg
, wayland
, libxkbcommon
, glib
, gtk3
}:

let
  version = "1.5.5";
  # Use aarch64-linux for Apple Silicon, or x86_64-linux for standard x64
  arch = if stdenvNoCC.hostPlatform.isAarch64 then "arm64" else "x64";
in
stdenvNoCC.mkDerivation {
  pname = "askimo-desktop";
  inherit version;

  src = fetchurl {
    url = "https://github.com/askimo-ai/askimo/releases/download/v${version}/askimo-desktop-linux-${arch}.jar";
    # Replace with the actual base32/SRI hash from `nix-prefetch-url`
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  dontUnpack = true;
  nativeBuildInputs = [ makeWrapper ];

  # Skiko (Compose Multiplatform's Skia renderer) extracts native shared objects
  # into ~/.skiko/ at runtime and dlopens these system libraries:
  runtimeLibs = lib.makeLibraryPath [
    libGL
    fontconfig
    freetype
    wayland
    libxkbcommon
    glib
    gtk3
    xorg.libX11
    xorg.libXext
    xorg.libXrender
    xorg.libXtst
    xorg.libXi
    xorg.libXcursor
    xorg.libXrandr
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/java $out/bin
    cp $src $out/share/java/askimo-desktop.jar

    makeWrapper ${openjdk25}/bin/java $out/bin/askimo \
      --prefix LD_LIBRARY_PATH : "$runtimeLibs" \
      --add-flags "-jar $out/share/java/askimo-desktop.jar"

    runHook postInstall
  '';

  meta = with lib; {
    description = "Native Compose Multiplatform desktop AI client";
    homepage = "https://github.com/askimo-ai/askimo";
    mainProgram = "askimo";
    platforms = [ "aarch64-linux" "x86_64-linux" ];
  };
}

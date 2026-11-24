{ config, pkgs, lib, ... }:

let
  pname = "deepchat";
  version = "1.1.4";

  src = pkgs.fetchurl {
    url = "https://github.com/ThinkInAIXYZ/deepchat/releases/download/v${version}/DeepChat-${version}-linux-arm64.tar.gz";
    sha256 = "19dddc89b2ed2efa03699f844df2b233a074594bf0e7a8e64114393ece8fa38c";
  };

  desktopItem = pkgs.makeDesktopItem {
    name = "deepchat";
    desktopName = "DeepChat";
    comment = "Multi-provider AI desktop client with MCP and KaTeX support";
    exec = "deepchat %U";
    icon = "deepchat";
    terminal = false;
    categories = [ "Utility" "Network" ];
    startupWMClass = "deepchat";
  };

  deepchat = pkgs.stdenvNoCC.mkDerivation {
    inherit pname version src;

    nativeBuildInputs = [ pkgs.makeWrapper ];

    installPhase = ''
      runHook preInstall

      mkdir -p $out/share/deepchat $out/bin $out/share/applications

      # Copy only the packaged Electron app resources and run via nixpkgs' system Electron
      cp -r resources $out/share/deepchat/
      cp ${desktopItem}/share/applications/deepchat.desktop $out/share/applications/

      makeWrapper ${pkgs.electron}/bin/electron $out/bin/deepchat \
        --add-flags "$out/share/deepchat/resources/app.asar" \
        --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations}}"

      runHook postInstall
    '';

    meta = {
      description = "Multi-model AI desktop client with MCP, OpenRouter, and KaTeX support";
      homepage = "https://github.com/ThinkInAIXYZ/deepchat";
      mainProgram = "deepchat";
      platforms = [ "aarch64-linux" ];
    };
  };
in
{
  home.packages = [ deepchat ];
}

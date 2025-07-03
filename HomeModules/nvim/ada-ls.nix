{ pkgs, ... }:
let
  ada-lsp-pkg =
    if pkgs.stdenv.isAarch64 && pkgs.stdenv.isLinux then
      # --- On aarch64-linux, use the pre-built binary ---
      pkgs.stdenv.mkDerivation rec {
        pname = "ada-language-server-bin";
        version = "26.0.202504171";
        src = pkgs.fetchurl {
          url = "https://github.com/AdaCore/ada_language_server/releases/download/${version}/als-${version}-linux-arm64.tar.gz";
          hash = "sha256-LeG2XCuIeGmMGnGGl0TFcLQMl4KfTbKUpDg9ISVsXIU=";
        };
        nativeBuildInputs = [
          pkgs.autoPatchelfHook
          pkgs.stdenv.cc.cc.lib
	  pkgs.gmp
        ];
        installPhase = ''
          runHook preInstall
          mkdir -p $out/bin
          # Since we're already in the 'integration' directory after unpacking,
          # the path should be relative to that
          install -Dm755 vscode/ada/arm64/linux/ada_language_server $out/bin/
          runHook postInstall
        '';
      }
    else
      # --- On all other platforms, build from source as a fallback ---
      pkgs.stdenv.mkDerivation rec {
        pname = "ada-language-server-custom";
        version = "24.0.0";
        nativeBuildInputs = [
          pkgs.alire
          pkgs.gnat15
          pkgs.gprbuild
        ];
        src = pkgs.fetchurl {
          url = "https://github.com/AdaCore/ada_language_server/archive/refs/tags/v${version}.tar.gz";
          hash = "sha256-429uWj651c2/L+X0T8sBqgW7x22b27Fm295/Vj+G0+s=";
        };
        buildPhase = ''
          runHook preBuild
          export HOME=$(mktemp -d)
          alr toolchain --select gnat_native
          alr get als --version ~${version}
          alr build --release -- -p als
          runHook postBuild
        '';
        installPhase = ''
          runHook preInstall
          mkdir -p $out/bin
          install -Dm755 $(find . -type f -name "ada_language_server") $out/bin/
          runHook postInstall
        '';
      };
in
{
  # This module configures the Ada LSP within nixvim.
  programs.nixvim.plugins.lsp.servers.ada_ls = {
    enable = true;
    # Assign our locally defined package to the `package` option.
    package = ada-lsp-pkg;
  };
}

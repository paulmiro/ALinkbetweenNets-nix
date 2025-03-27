{ lib, pkgs, ... }:
pkgs.stdenv.mkDerivation {
  pname = "aerial-sddm-theme";
  version = "484b52e-2025-03-27";
  src = pkgs.fetchFromGitHub {
    owner = "3ximus";
    repo = "aerial-sddm-theme";
    rev = "484b52e1f26c29cb9825e23b3f3c9b8bef0bcf5f";
    hash = "sha256-YeJTdlnGV58MNB8VpjDrFuC3VNsh5SgTdZH63aLD6Xw=";
  };
  buildInputs = with pkgs;  [
    gst_all_1.gst-libav
    gst_all_1.gst-plugins-good
    libsForQt5.phonon-backend-gstreamer
    libsForQt5.qt5.qtquickcontrols
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtmultimedia
  ];
  installPhase = ''
    mkdir -p $out/share/ssdm/themes
    sed -i 's/import QtMultimedia 5.7/"${pkgs.libsForQt5.qt5.qtmultimedia}"/g' $src/Main.qml
    cp -aR $src $out/share/ssdm/themes/aerial
  '';
  meta = with lib; {
    description = "Aerial theme for SDDM";
    homepage = "https://github.com/3ximus/aerial-sddm-theme";
    platforms = platforms.linux;
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ link ];
  };
}

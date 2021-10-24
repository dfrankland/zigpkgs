{ lib
, stdenv
, fetchFromGitHub
, buildZigProject
, wayland
, pkg-config
, scdoc
, xwayland
, wayland-protocols
, wlroots
, libxkbcommon
, pixman
, udev
, libevdev
, libinput
, libX11
, libGL
}:

buildZigProject rec {
  pname = "river";
  version = "unstable-2021-10-20";

  src = fetchFromGitHub {
    owner = "ifreund";
    repo = pname;
    rev = "e447e1b41fbb4fa210e0a2cf8ecb1e3ac932ab32";
    sha256 = "TWUWlXKKB4W04CM7BWWYsgxYVh7mOyfNXCfHpr+jQD0=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ wayland xwayland scdoc pkg-config ];

  buildInputs = [
    wayland-protocols
    wlroots
    pixman
    libxkbcommon
    pixman
    udev
    libevdev
    libinput
    libX11
    libGL
  ];

  options = [
    "-Drelease-safe"
    "-Dcpu=baseline"
    "-Dxwayland"
    "-Dman-pages"
  ];

  /*
    Builder patch install dir into river to get default config
    When installFlags is removed, river becomes half broken.
    See https://github.com/ifreund/river/blob/7ffa2f4b9e7abf7d152134f555373c2b63ccfc1d/river/main.zig#L56
  */
  installFlags = [ "DESTDIR=$(out)" ];

  meta = with lib; {
    homepage = "https://github.com/ifreund/river";
    description = "A dynamic tiling wayland compositor";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ fortuneteller2k ];
  };
}

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
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "ifreund";
    repo = pname;
    rev = "v${version}";
    sha256 = "03pdgrcpj8db9s14249815z76dyjwwma8xv6p9hpw79flk6rk7v7";
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

with import <nixpkgs> { };

mkShell {
  nativeBuildInputs = [
    pkg-config
    gtk4
    simdutf
    gmp
    boehmgc
    icu76
    libadwaita.dev
  ];

  LD_LIBRARY_PATH = lib.makeLibraryPath [
    gtk4
    libadwaita
    libadwaita.dev
    simdutf
    gmp.dev
    icu76.dev
    pcre.dev
    boehmgc.dev
  ];
}

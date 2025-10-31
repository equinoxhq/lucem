with import <nixpkgs> { };

mkShell {
  nativeBuildInputs = [
    pkg-config
    gtk4
    libadwaita.dev
    curl
    openssl
  ];

  LD_LIBRARY_PATH = lib.makeLibraryPath [
    gtk4
    libadwaita
    libadwaita.dev
    openssl
    openssl.dev
    curl.dev
  ];
}

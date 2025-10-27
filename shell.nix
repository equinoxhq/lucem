with import <nixpkgs> { };

mkShell {
  nativeBuildInputs = [
    pkg-config
    gtk4
    libadwaita.dev
  ];

  LD_LIBRARY_PATH = lib.makeLibraryPath [
    gtk4
    libadwaita
    libadwaita.dev
  ];
}

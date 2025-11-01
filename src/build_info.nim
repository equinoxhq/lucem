## Compile-time build info code from Equinox

const
  CommitHash* = gorge("git describe --tags --long --dirty")
  Version* {.strdefine: "NimblePkgVersion".} = "<not defined at compile time>"
  #License* = staticRead("../LICENSE")
  Splashes* = [
    "Have you ever had a dream?"
  ]

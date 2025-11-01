## Compile-time branding related constants
##
## Copyright (C) 2025 Trayambak Rai (xtrayambak at disroot dot org)

const
  Version* {.strdefine: "NimblePkgVersion".} = "0.0.0"
  AppId* {.strdefine: "LucemAppId".} = "xyz.xtrayambak.lucem"

  CommitHash* = gorge("git describe --tags --long --dirty")
  License* = staticRead("../LICENSE")
  Splashes* = ["Have you ever had a dream?"]

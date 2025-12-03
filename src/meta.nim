## Compile-time branding related constants
##
## Copyright (C) 2025 Trayambak Rai (xtrayambak at disroot dot org)

const
  Version* {.strdefine: "NimblePkgVersion".} = "0.0.0"
  AppId* {.strdefine: "LucemAppId".} = "xyz.xtrayambak.lucem"

  CommitHash* = gorge("git describe --tags --long --dirty")
  License* = staticRead("../LICENSE")
  Splashes* = [
    "Have you ever had a dream?", "\"i hate owlkettle\" - ashtaka, the art of ui",
    "atomics there and channels here",
    "do you think because you are, or are you because you think?",
    "https://media.discordapp.net/attachments/1285901307433058348/1445727403220406393/speechmeme-2025-12-03T10-43-45.png?ex=69316611&is=69301491&hm=616e33b1082836030172091edf4c43bbee82b573853969bb4e0abef21b99ddd4&=&format=webp&quality=lossless&width=665&height=841",
  ]

## Sober directory utils
##
## Copyright (C) 2025 Trayambak Rai (xtrayambak at disroot dot org)
import std/[os]

proc getSoberDir*(): string {.inline.} =
  getHomeDir() / ".var" / "app" / "org.vinegarhq.Sober"

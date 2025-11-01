## Config routines
##
## Copyright (C) 2025 Trayambak Rai (xtrayambak at disroot dot org)
import std/options

type Config* = object
  discordRpc*: bool
  maxFps*: Option[uint16]

## Config routines
##
## Copyright (C) 2025 Trayambak Rai (xtrayambak at disroot dot org)
import std/options
import pkg/jsony

type Config* = object
  discordRpc*: bool
  maxFps*: Option[uint16]

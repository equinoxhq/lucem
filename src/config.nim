## Config routines
##
## Copyright (C) 2025 Trayambak Rai (xtrayambak@disroot.org)
import std/[os, options]
import pkg/[chronicles, jsony]

logScope:
  topics = "configuration"

type
  ConfigObj* = object
    discordRpc*: bool
    maxFps*: Option[uint16]
    patches*: seq[string]

  Config* = ref ConfigObj

proc getLucemConfig(): tuple[dir: string, file: string] {.inline.} =
  let
    configDir = getConfigDir() / "lucem"
    configFile = configDir / "config.json"

  (dir: configDir, file: configFile)

proc loadConfig*(): Config {.sideEffect.} =
  # note: this isn't a very cheap function, call it judiciously.
  let (configDir, configFile) = getLucemConfig()

  discard existsOrCreateDir(configDir)

  info "Loading configuration file", path = configFile

  if not fileExists(configFile):
    info "Configuration file does not exist, using default one."
    return Config(discordRpc: true, maxFps: some(60'u16), patches: @[])

  fromJson(readFile(configFile), Config)

proc save*(config: Config) {.sideEffect.} =
  let (configDir, configFile) = getLucemConfig()

  discard existsOrCreateDir(configDir)

  info "Saving configuration to file", dir = configDir, file = configFile

  writeFile(configFile, toJson(config))

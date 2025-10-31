## Caching routines implementation
##
## Copyright (C) 2025 Trayambak Rai (xtrayambak at disroot dot org)
import std/[os, options, base64]
import pkg/chronicles
import meta

logScope:
  topics = "resource caching"

func asCacheEntry*(url: string): string {.inline.} =
  encode(url, safe = true)

proc isCached*(cacheDir: string, url: string): bool {.inline.} =
  fileExists(cacheDir / asCacheEntry(url))

proc cache*(cacheDir: string, url: string, content: string) {.inline.} =
  writeFile(cacheDir / asCacheEntry(url), content)

proc readCache*(cacheDir: string, url: string): Option[string] =
  let path = cacheDir / asCacheEntry(url)
  if not fileExists(path):
    return none(string)

  some(readFile(path))

proc clearCache*(cacheDir: string): uint =
  assert(cacheDir.len > 0)

  var eliminated = 0'u
  for kind, path in walkDir(cacheDir):
    if kind != pcFile:
      continue

    inc eliminated
    removeFile(path)

  ensureMove(eliminated)

proc ensureCacheDirExists*(dir: string) =
  if not dirExists(dir):
    info "Initializing cache directory", dir = dir
    createDir(dir)

proc getLucemCacheDir*(): string =
  getCacheDir() / meta.AppId

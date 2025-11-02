## Patch loader implementation
##
## Copyright (C) 2025 Trayambak Rai (xtrayambak at disroot dot org)
import std/[os, options, hashes, strutils, sets, tables]
import pkg/[chronicles, curly, results, shakar, url, jsony]
import meta, resource_caching, sober_dir

logScope:
  topics = "patch loader"

type
  PatchMetadata = object
    name*: string
    author*: string
    official*: bool

  PatchFetched = Table[string, string]
  PatchMutations = Table[string, string]

  Patch* = object
    metadata*: PatchMetadata
    inputs*: PatchFetched
    outputs*: PatchMutations

  PatchLoader* = object
    patches*: HashSet[Patch]

  ExecutorPayload* = object
    patch*: Patch
    patchId*: string
    workDir*: string
    outDir*: string
    cacheDir*: string
    http*: Curly

proc loadPatch*(
    loader: var PatchLoader, name: string, source: string, official: bool = false
): Option[Patch] {.discardable.} =
  info "Loading patch", name = name, official = official

  try:
    var patch = fromJson(source, Patch)
    patch.metadata.official = official
    loader.patches.incl(patch)

    return some(ensureMove(patch))
  except jsony.JsonError as exc:
    error "Cannot load patch - cannot parse file! It will not be available.",
      name = name, err = exc.msg

proc revertPatch*(patch: Patch, outDir: string) =
  debug "Reverting patch", name = patch.metadata.name, author = patch.metadata.author

  for path, resource in patch.outputs:
    debug "Removing patch's outputs", path = path, resource = resource

    let fullPath = outDir / path

    if not fileExists(fullPath):
      warn "Output doesn't exist, maybe the user tried to remove it themselves? Ignoring it.",
        path = outDir / path
      continue

    removeFile(fullPath)

proc executePatch(payload: ExecutorPayload) =
  let patch = payload.patch

  debug "Performing first-run of patch",
    name = patch.metadata.name, author = patch.metadata.author

  let workingDir = payload.workDir / payload.patchId

  discard existsOrCreateDir(workingDir)

  # Download everything that this patch requires
  for url, path in patch.inputs:
    if !tryParseURL(url):
      error "Cannot fetch resource, URL is invalid/unparseable!", url = url, path = path
      continue

    debug "Fetching online resource", url = url, path = path

    # TODO: Do we need to implement other HTTP methods?
    # afaik HTTP/GET should be more than enough.
    var data: string

    if not isCached(payload.cacheDir, url):
      let response = payload.http.get(url)
      if response.code != 200:
        error "Cannot fetch resource, server returned non-successful response code!",
          code = response.code, url = url, path = path
        continue

      cache(payload.cacheDir, url, response.body)
      data = response.body
    else:
      debug "Found it in the cache instead.", url = url, path = path
      data = &readCache(payload.cacheDir, url)

    writeFile(workingDir / path, data)

  # Now, we'll start writing the outputs
  for path, resource in patch.outputs:
    let
      resourcePath = workingDir / resource
      outputPath = payload.outDir / path

    debug "Moving outputs to asset overlay.",
      path = path, resource = resource, currentPath = resourcePath

    var cascadingPath = newStringOfCap(outputPath.len)
    cascadingPath &= payload.outDir
    let splitOutput = path.split('/')

    for component in splitOutput[0 ..< splitOutput.len - 1]:
      cascadingPath &= '/' & component
      discard existsOrCreateDir(cascadingPath)

    moveFile(resourcePath, outputPath)

proc execute*(loader: var PatchLoader) =
  info "Executing all patches", numPatches = loader.patches.len

  let
    workingDir = getLucemCacheDir()
    patchesDir = getLucemCacheDir() / "patch-builder"
    soberDir = getSoberDir() / "data" / "sober" / "asset_overlay"

  ensureCacheDirExists(workingDir)
  ensureCacheDirExists(patchesDir)

  for patch in loader.patches:
    # TODO: Create a bunch of threads that do the work.
    executePatch(
      ExecutorPayload(
        patch: patch,
        workDir: patchesDir,
        patchId: $hash(patch),
        http: newCurly(),
        outDir: soberDir,
        cacheDir: workingDir,
      )
    )

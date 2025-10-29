## Patch loader implementation
##
## Copyright (C) 2025 Trayambak Rai (xtrayambak at disroot dot org)
import
  pkg/bali/runtime/prelude,
  pkg/bali/grammar/prelude,
  pkg/bali/runtime/vm/interpreter/interpreter
import pkg/[chronicles, shakar]
import meta

logScope:
  topics = "patch loader"

type
  JSHTTP* = object

  Patch* = object
    name*: string
    vm*: Runtime

  PatchLoader* = object
    patches*: seq[Patch]

proc loadPatch*(loader: var PatchLoader, name: string, source: string) =
  info "Loading patch", name = name

  var patch: Patch
  patch.vm = newRuntime(name, newParser(source).parse())

  loader.patches &= ensureMove(patch)

proc executePatch(patch: Patch) =
  debug "Performing first-run of patch", name = patch.name
  patch.vm.run()

  let entryPoint = patch.vm.get("apply")
    # Get the apply() routine from the global scope, if it exists.

  if !entryPoint:
    warn "Patch has no entry point function apply(), ignoring it. Please read the documentation on how to write patches if this is your own patch.",
      name = patch.name
    return

  patch.vm.deathCallback = proc(vm: PulsarInterpreter) {.gcsafe.} =
    error "Failed to apply patch, VM raised an unhandled error instead."

  debug "Calling apply() JSValue, passing control to engine", name = patch.name
  patch.vm.callNoRetval(&entryPoint, patch.vm.wrap(meta.Version))

  debug "Called apply() successfully, collecting mutations", name = patch.name

proc execute*(loader: var PatchLoader) =
  info "Executing all patches", numPatches = loader.patches.len

  for patch in loader.patches:
    executePatch(patch)

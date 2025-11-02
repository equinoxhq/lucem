import std/os
import pkg/owlkettle, pkg/owlkettle/adw
import pkg/[chronicles, shakar]
import application, meta, patch_loader, sober_dir

logScope:
  topics = "main"

const content = staticRead "patches/old-get-up.lpat.json"

proc main() {.inline.} =
  info "Lucem is now starting up", version = meta.Version
  var loader: PatchLoader
  let patch = loader.loadPatch("thing.lpat.js", content)
  loader.execute()

  revertPatch(&patch, getSoberDir() / "data" / "sober" / "asset_overlay")

  runLucemApp()

  quit(QuitSuccess)

when isMainModule:
  main()

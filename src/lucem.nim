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
  loader.loadPatch("old-get-up.lpat.js", content, official = true)
  loader.execute()

  runLucemApp()

  quit(QuitSuccess)

when isMainModule:
  main()

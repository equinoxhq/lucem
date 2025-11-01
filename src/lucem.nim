import pkg/owlkettle, pkg/owlkettle/adw
import pkg/chronicles
import application, meta, patch_loader

logScope:
  topics = "main"

const content = staticRead "patches/old-get-up.lpat.json"

proc main() {.inline.} =
  info "Lucem is now starting up", version = meta.Version
  var loader: PatchLoader
  loader.loadPatch("thing.lpat.js", content)
  loader.execute()

  runLucemApp()

  quit(QuitSuccess)

when isMainModule:
  main()

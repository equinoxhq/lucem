import pkg/owlkettle, pkg/owlkettle/adw
import pkg/chronicles
import application, meta, resource_loader

logScope:
  topics = "main"

proc main() {.inline.} =
  info "Lucem is now starting up", version = meta.Version
  loadAppAssets()
  runLucemApp()

  quit(QuitSuccess)

when isMainModule:
  main()


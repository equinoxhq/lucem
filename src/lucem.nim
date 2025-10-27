import pkg/owlkettle, pkg/owlkettle/adw
import pkg/chronicles
import meta, application

logScope:
  topics = "main"

proc main() {.inline.} =
  info "Lucem is now starting up", version = meta.Version
  runLucemApp()

  quit(QuitSuccess)

when isMainModule:
  main()


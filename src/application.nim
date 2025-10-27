## Application code
##
## Copyright (C) 2025 Trayambak Rai (xtrayambak at disroot dot org)
import pkg/owlkettle, pkg/owlkettle/adw
import pkg/[chronicles]

logScope:
  topics = "application"

viewable App:
  x:
    pointer

method view(app: AppState): Widget =
  result = gui:
    Window:
      title = "Lucem"
      defaultSize = (600, 400)

proc runLucemApp*() =
  info "Starting application"
  adw.brew(App())

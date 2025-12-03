import pkg/owlkettle, pkg/owlkettle/adw
import meta, ./bindings/libadwaita

proc openPatchStore*(app: Viewable) =
  discard app.open:
    gui:
      Window:
        title = "Patch Store"
        defaultSize = (500, 700)
        AdwSpinner()

        HeaderBar {.addTitlebar.}:
          style = [HeaderBarFlat]

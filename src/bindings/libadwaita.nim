import pkg/owlkettle
import pkg/owlkettle/bindings/gtk

{.push importc, cdecl.}
proc adw_spinner_new*(): GtkWidget
{.pop.}

renderable AdwSpinner:
  hooks:
    beforeBuild:
      state.internalWidget = adw_spinner_new()

export AdwSpinner

{.compile("resources.c", gorge("pkg-config --cflags gio-2.0")).}
import pkg/chronicles
import pkg/owlkettle/bindings/gtk

logScope:
  topics = "resource loader"

proc resources_get_resource(): gtk.GResource {.importc, cdecl.}

proc loadAppAssets*() =
  info "Registering app assets from linked GResource file"
  g_resources_register(resources_get_resource())

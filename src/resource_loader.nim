{.compile("resources.c", gorge("pkg-config --cflags gio-2.0")).}
import pkg/chronicles
import pkg/owlkettle/bindings/gtk

logScope:
  topics = "resource loader"

proc resources_get_resource(): gtk.GResource {.importc, cdecl.}

proc gtk_icon_theme_add_resource_path(
  theme: GtkIconTheme, path: cstring
) {.importc, cdecl.}

proc loadAppAssets*() =
  info "Registering app assets from linked GResource file"
  g_resources_register(resources_get_resource())
  gtk_icon_theme_add_resource_path(
    gtk_icon_theme_get_for_display(gdk_display_get_default()),
    "/xyz/xtrayambak/lucem/assets/icons",
  )

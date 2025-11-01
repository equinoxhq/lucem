import pkg/owlkettle,
       pkg/owlkettle/adw,
       ../build_info

template openAboutMenu*(app) =
  discard app.open: gui:
    AboutWindow:
      applicationName = "Lucem"
      developerName = "The EquinoxHQ Team"
      version = meta.Version
      supportUrl = "https://discord.gg/Z5m3n9fjcU"
      issueUrl = "https://github.com/equinoxhq/lucem/issues"
      website = "https://equinoxhq.github.io"
      copyright =
        """
Copyright (C) 2025 xTrayambak and the EquinoxHQ Team
      """
      license = meta.License
      licenseType = LicenseMIT_X11
      applicationIcon = "lucem"
      developers = @["Trayambak (xTrayambak)"]
      designers = @["Adrien (AshtakaOOf)"]
      artists = @[]
      documenters = @[]
      credits =
        @{
          "Emotional support (probably)": @["Kirby (k1yrix)"],
        }

vim.g.mkdp_preview_options = {
  uml = {
    openMarker = "@startuml",
    closeMarker = "@enduml",
    generateSource = function(umlCode)
      return ("http://localhost:4000/plantuml/" .. umlCode)
    end,
    diagramName = "uml",
    imageFormat = "svg",
    -- render = "markdown-it"
    server = "http://localhost:4000/plantuml"
  }
}

require("mappings").mkpv_keys()

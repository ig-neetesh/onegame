class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?" {
            constraints {
                // apply constraints here
            }
        }

        "/"(controller: 'view', action: 'index')
        "/play/$token"(controller: 'view', action: 'mobileView')
        "500"(view: '/error')
    }
}

package onegame

import groovy.util.logging.Log4j

@Log4j
class ViewController {

    def dataProviderService
    def credentialProviderService

    def index() {
        String apiKey = credentialProviderService.applicationKey
        [apiKey: apiKey, token: dataProviderService.getNewToken(session)]
    }

    def display(String token) {
        String apiKey = credentialProviderService.applicationKey
        int interval = credentialProviderService.dataPostInterval
        String viewName = mobileView(token)
        Map settings = [
                token   : token,
                interval: interval,
                apiKey  : apiKey
        ]
        render(view: viewName, model: settings)
    }

    private String mobileView(String token) {
        boolean isMobile = dataProviderService.isMobileBrowser(request)
        if (token.endsWith("v")) {
            if (isMobile) {
                return "tvremote"
            }
            log.info "Loading video page"
            return "videos"
        } else {
            if (isMobile) {
                return "steeringControls"
            }
            return "frontWindow"
        }
        return "steeringControls"
    }
}

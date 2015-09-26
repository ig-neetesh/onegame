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
        String viewName = dataProviderService.isMobileBrowser(request) ? 'steeringControls' : 'frontWindow'
        Map settings = [
                token   : token,
                interval: interval,
                apiKey  : apiKey
        ]
        render(view: viewName, model: settings)
    }
}

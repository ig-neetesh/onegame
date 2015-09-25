package onegame

import groovy.util.logging.Log4j

@Log4j
class ViewController {

    def index() {
        [token: "hello"]
    }

    def display() {
        String apiKey = grailsApplication.config.pusherapp.applicationKeys[0]
        String channelId = "xyz";
        [apiKey: apiKey, channelId: channelId]
    }

    def mobileView(String token) {
        log.info("hit to connect through mobile ${token}")
        String viewName = Util.isMobileBrowser(request) ? 'mobileIndex' : 'mobileError'
        render(view: viewName, params: [token: token, interval: grailsApplication.config.pusherapp.dataPostIntervals])
    }


}

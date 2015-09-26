package onegame

class CredentialProviderService {

    def grailsApplication

    int index = 0;

    String getApplicationKey() {
        return grailsApplication.config.peerjs.apiKey
    }

    int getDataPostInterval() {
        return grailsApplication.config.peerjs.dataPostInterval
    }
}

package onegame

class CredentialProviderService {

    def grailsApplication

    int index = 0;

    String getPusherHost() {
        return grailsApplication.config.pusherapp.host
    }

    String getApplicationId() {
        return grailsApplication.config.pusherapp.applicationIds[index]
    }

    String getApplicationKey() {
        return grailsApplication.config.pusherapp.applicationKeys[index]
    }

    String getApplicationSecret() {
        return grailsApplication.config.pusherapp.applicationSecrets[index]
    }

    int getDataPostInterval() {
        return grailsApplication.config.pusherapp.dataPostInterval
    }
}

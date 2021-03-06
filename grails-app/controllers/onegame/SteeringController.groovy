package onegame

import grails.converters.JSON
import groovy.util.logging.Log4j

@Log4j
class SteeringController {
    def pushService
    def dataProviderService

    def control(SteeringCO co) {
        Direction dir = dataProviderService.getDirection(co)
        String event = "driving"
        if (co.isInitCall) {
            event = "init"
        }
        log.info("event Data : ${co.y} and DIR : ${dir}")
        render("OK")
    }
}
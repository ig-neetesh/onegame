package onegame

import grails.converters.JSON
import groovy.util.logging.Log4j

@Log4j
class SteeringController {
    def pushService

    def control(SteeringCO co) {
        Direction dir = co.direction
        log.info("event Data : ${co.properties}")

        pushService.triggerPush("xyz", "driving", new JSON([dir: dir.toString()]).toString())
        render("OK")
    }
}
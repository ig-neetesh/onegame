package onegame

class SteeringCO {
    double x
    double y
    double z

    String token

    Direction getDirection() {
        SteeringCO initials = Util.getInitials(token)
        if (!initials) {
            initials = this;
            Util.putInitials(initials)
        }

        if (y < -4) {
            return Direction.LEFT
        }

        if (y > 4) {
            return Direction.RIGHT
        }
        /*       if (x < -6) {
                   return Direction.FORWARD
               }

               if (z < -5) {
                   return Direction.BACKWORD
               }*/
        return Direction.FORWARD
    }
}
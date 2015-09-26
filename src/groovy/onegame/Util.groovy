package onegame

/**
 * Created by neetesh on 26/9/15.
 */
class Util {
    static String ipAddress() {
        List l = []
        Enumeration e = NetworkInterface.getNetworkInterfaces()
        while (e.hasMoreElements()) {
            NetworkInterface n = (NetworkInterface) e.nextElement();
            Enumeration ee = n.getInetAddresses();
            while (ee.hasMoreElements()) {
                InetAddress i = (InetAddress) ee.nextElement();
                l.add(i.getHostAddress());
            }
        }
        return l[1]
    }
}

package onegame

/**
 * Created by neetesh on 26/9/15.
 */
class HttpUtil {
    public static def processRequest(String url, String jsonText) {
        HttpURLConnection con = new URL(url).openConnection()
        con.setDoOutput(true)
        con.setDoInput(true)
        con.setRequestMethod("POST")
        con.setRequestProperty("Content-Type", "application/json")
        con.setRequestProperty("Accept", "application/json");
        con.connect();

        OutputStream out = con.outputStream


        out.write(jsonText.getBytes("UTF-8"))
        //out.close()

        if (con.responseCode == HttpURLConnection.HTTP_ACCEPTED) {
            return true
        }
    }
}
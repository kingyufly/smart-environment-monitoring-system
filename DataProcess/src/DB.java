import java.math.RoundingMode;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.util.ArrayList;

public class DB {
    private static final String url = "jdbc:mysql://123.56.8.117/environment?useSSL=false";
    private static final String driver = "com.mysql.jdbc.Driver";
    private static final String user = "outeruser";
    private static final String password = "Abcd1234!";

    private Connection conn = null;

    private int clientId = -1;


    public DB() {
        try {
            Class.forName(driver);
            conn = DriverManager.getConnection(url, user, password);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void close() {
        try {
            this.conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insert(String sql) throws SQLException {
        Statement stmt = conn.createStatement();
        boolean rs = stmt.execute(sql);
    }

    public void insertHourData(Weather weather) throws SQLException {
        DecimalFormat df2 = new DecimalFormat("0.00");
        df2.setRoundingMode(RoundingMode.HALF_UP);
        String sql = "insert into hour_data(timestamp,client_id,temperature,humidity,pm2_5,co) values(\"" + weather.getTimestamp() + "\"," + weather.getClient_id() + "," + df2.format(weather.getTemperature()) + "," + df2.format(weather.getHumidity()) + "," + weather.getPm2_5() + "," + weather.getCo() + ");";
        Statement stmt = conn.createStatement();
        boolean rs = stmt.execute(sql);
    }

    public void insertDayData(Weather weather) throws SQLException {
        DecimalFormat df2 = new DecimalFormat("0.00");
        df2.setRoundingMode(RoundingMode.HALF_UP);
        String sql = "insert into day_data(timestamp,client_id,temperature_max,temperature_min,humidity_max,humidity_min,pm2_5_max,co_max) values(\"" + weather.getTimestamp() + "\"," + weather.getClient_id() + "," + df2.format(weather.getTemperature_max()) + "," + df2.format(weather.getTemperature_min()) + "," + df2.format(weather.getHumidity_max()) + "," + df2.format(weather.getHumidity_min()) + "," +weather.getPm2_5_max() + "," + weather.getCo_max() + ");";
        Statement stmt = conn.createStatement();
        boolean rs = stmt.execute(sql);
    }

    public ResultSet query(String sql) throws SQLException {
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
        return rs;
    }

    public ArrayList<Weather> queryWeatherRawData(String time1, String time2, int client_id) throws SQLException {
        String sql = "select * from raw_data where timestamp >= \'" + time1 + "\' and timestamp < \'" + time2 + "\' and client_id=" + client_id + ";";
        System.out.println(sql);
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);

        ArrayList<Weather> weatherList = new ArrayList<Weather>();
        while (rs.next()) {
            Weather weather = new Weather();
            weather.setId(rs.getInt("id"));
            weather.setTimestamp(rs.getString("timestamp"));
            weather.setMilliseconds(rs.getInt("milliseconds"));
            weather.setClient_id(rs.getInt("client_id"));
            weather.setTemperature(rs.getFloat("temperature"));
            weather.setHumidity(rs.getFloat("humidity"));
            weather.setPm2_5(rs.getInt("pm2_5"));
            weather.setCo(rs.getInt("co"));
            weatherList.add(weather);
        }
        return weatherList;
    }

    public ArrayList<Weather> queryWeatherHourData(String time1, String time2, int client_id) throws SQLException {
        String sql = "select * from hour_data where timestamp >= \'" + time1 + "\' and timestamp < \'" + time2 + "\' and client_id=" + client_id + ";";
        System.out.println(sql);
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);

        ArrayList<Weather> weatherList = new ArrayList<Weather>();
        while (rs.next()) {
            Weather weather = new Weather();
            weather.setId(rs.getInt("id"));
            weather.setTimestamp(rs.getString("timestamp"));
            weather.setClient_id(rs.getInt("client_id"));
            weather.setTemperature(rs.getFloat("temperature"));
            weather.setHumidity(rs.getFloat("humidity"));
            weather.setPm2_5(rs.getInt("pm2_5"));
            weather.setCo(rs.getInt("co"));
            weatherList.add(weather);
        }
        return weatherList;
    }

    public ArrayList<Weather> queryWeatherDayData(String time1, String time2, int client_id) throws SQLException {
        String sql = "select * from day_data where timestamp >= \'" + time1 + "\' and timestamp < \'" + time2 + "\'and client_id=" + client_id + ";";
        System.out.println(sql);
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);

        ArrayList<Weather> weatherList = new ArrayList<Weather>();
        while (rs.next()) {
            Weather weather = new Weather();
            weather.setId(rs.getInt("id"));
            weather.setTimestamp(rs.getString("timestamp"));
            weather.setClient_id(rs.getInt("client_id"));
            weather.setTemperature_max(rs.getFloat("temperature_max"));
            weather.setTemperature_min(rs.getFloat("temperature_min"));
            weather.setHumidity_max(rs.getFloat("humidity_max"));
            weather.setHumidity_min(rs.getFloat("humidity_min"));
            weather.setPm2_5_max(rs.getInt("pm2_5_max"));
            weather.setCo_max(rs.getInt("co_max"));
            weatherList.add(weather);
        }
        return weatherList;
    }

    public ArrayList<Client> queryClientInfo() throws SQLException {
        String sql = "select * from client_info where 1";
        System.out.println(sql);
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);

        ArrayList<Client> clientList = new ArrayList<Client>();
        while (rs.next()) {
            Client client = new Client();
            client.setClient_id(rs.getInt("client_id"));
            client.setDevice_type(rs.getString("device_type"));
            client.setDescription(rs.getString("description"));
            client.setLongitude(rs.getFloat("longitude"));
            client.setLatitude(rs.getFloat("latitude"));
            client.setLocation(rs.getString("location"));
            clientList.add(client);
        }
        return clientList;
    }

    public int getClientId() {
        return clientId;
    }

    public void setClientId(int clientId) {
        this.clientId = clientId;
    }
}

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

public class DayData {
    private DB db;

    public DayData() {
        this.db = new DB();
    }

    public void close() {
        this.db.close();
    }

    public void genDayData() {
        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyy-MM-dd 00:00:00");
        String time2 = sdf.format(date);

        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.HOUR, -24);
        date = calendar.getTime();
        String time1 = sdf.format(date);

        ArrayList<Client> clientList = null;
        try {
            clientList = db.queryClientInfo();
        } catch (SQLException e) {
            e.printStackTrace();
        }

//        for (Client client : clientList) {
//            ArrayList<Weather> weatherList = null;
//            try {
//                weatherList = db.queryWeatherHourData(time1, time2, client.getClient_id());
//            } catch (SQLException e) {
//                e.printStackTrace();
//            }
//            Weather weatherStatus = new Weather();
//            weatherStatus.setTimestamp(time1);
//            weatherStatus.setClient_id(client.getClient_id());
//            for (Weather weather : weatherList) {
//                if (weatherStatus.getTemperature_max() < weather.getTemperature())
//                    weatherStatus.setTemperature_max(weather.getTemperature());
//                if (weatherStatus.getTemperature_min() > weather.getTemperature())
//                    weatherStatus.setTemperature_min(weather.getTemperature());
//                if (weatherStatus.getHumidity_max() < weather.getHumidity())
//                    weatherStatus.setHumidity_max(weather.getHumidity());
//                if (weatherStatus.getHumidity_min() > weather.getHumidity())
//                    weatherStatus.setHumidity_min(weather.getHumidity());
//                if (weatherStatus.getPm2_5_max() < weather.getPm2_5())
//                    weatherStatus.setPm2_5_max(weather.getPm2_5());
//                if (weatherStatus.getCo_max() < weather.getCo())
//                    weatherStatus.setCo_max(weather.getCo());
//            }
//            try {
//                db.insertDayData(weatherStatus);
//            } catch (SQLException e) {
//                e.printStackTrace();
//            }
//        }

        for (Client client : clientList) {
            Weather weatherStatus = new Weather();
            weatherStatus.setTimestamp(time2);
            weatherStatus.setClient_id(client.getClient_id());

            String sql = "select temperature from hour_data where timestamp >=\'" + time1 + "\' and timestamp < \'" + time2 + "\' and client_id=" + client.getClient_id() + " order by temperature desc;";
            ResultSet rs = null;
            try {
                rs = db.query(sql);
                if(!rs.next())
                    continue;
                weatherStatus.setTemperature_max(rs.getFloat("temperature"));

                sql = "select temperature from hour_data where timestamp >=\'" + time1 + "\' and timestamp < \'" + time2 + "\' and client_id=" + client.getClient_id() + " order by temperature asc;";
                rs = db.query(sql);
                rs.next();
                weatherStatus.setTemperature_min(rs.getFloat("temperature"));

                sql = "select humidity from hour_data where timestamp >=\'" + time1 + "\' and timestamp < \'" + time2 + "\' and client_id=" + client.getClient_id() + " order by humidity desc;";
                rs = db.query(sql);
                rs.next();
                weatherStatus.setHumidity_max(rs.getFloat("humidity"));

                sql = "select humidity from hour_data where timestamp >=\'" + time1 + "\' and timestamp < \'" + time2 + "\' and client_id=" + client.getClient_id() + " order by humidity asc;";
                rs = db.query(sql);
                rs.next();
                weatherStatus.setHumidity_min(rs.getFloat("humidity"));

                sql = "select pm2_5 from hour_data where timestamp >=\'" + time1 + "\' and timestamp < \'" + time2 + "\' and client_id=" + client.getClient_id() + " order by pm2_5 desc;";
                rs = db.query(sql);
                rs.next();
                weatherStatus.setPm2_5_max(rs.getInt("pm2_5"));

                sql = "select co from hour_data where timestamp >=\'" + time1 + "\' and timestamp < \'" + time2 + "\' and client_id=" + client.getClient_id() + " order by co desc;";
                rs = db.query(sql);
                rs.next();
                weatherStatus.setCo_max(rs.getInt("co"));

                db.insertDayData(weatherStatus);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}

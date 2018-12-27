import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

public class HourData {
    private DB db;

    public HourData() {
        this.db = new DB();
    }

    public void close() {
        this.db.close();
    }

    public void genHourData() {
        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyy-MM-dd HH:00:00");
        String time2 = sdf.format(date);

        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.HOUR, -1);
        date = calendar.getTime();
        String time1 = sdf.format(date);

        ArrayList<Client> clientList = null;
        try {
            clientList = db.queryClientInfo();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        for (Client client : clientList) {
            ArrayList<Weather> weatherList = null;
            try {
                weatherList = db.queryWeatherRawData(time1, time2, client.getClient_id());
            } catch (SQLException e) {
                e.printStackTrace();
            }
            if (weatherList.size() == 0)
                continue;

            Weather averageWeather = new Weather();
            averageWeather.setTimestamp(time1);
            averageWeather.setClient_id(client.getClient_id());
            for (Weather weather : weatherList) {
                averageWeather.setTemperature(averageWeather.getTemperature() + weather.getTemperature());
                averageWeather.setHumidity(averageWeather.getHumidity() + weather.getHumidity());
                averageWeather.setPm2_5(averageWeather.getPm2_5() + weather.getPm2_5());
                averageWeather.setCo(averageWeather.getCo() + weather.getCo());
            }
            averageWeather.setTemperature(averageWeather.getTemperature() / weatherList.size());
            averageWeather.setHumidity(averageWeather.getHumidity() / weatherList.size());
            averageWeather.setPm2_5(averageWeather.getPm2_5() / weatherList.size());
            averageWeather.setCo(averageWeather.getCo() / weatherList.size());
            try {
                db.insertHourData(averageWeather);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}

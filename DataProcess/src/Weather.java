public class Weather {
    private int id;
    private String timestamp;
    private int milliseconds;
    private int client_id;
    private float temperature = 0;
    private float temperature_max = 0;
    private float temperature_min = 0;
    private float humidity = 0;
    private float humidity_max = 0;
    private float humidity_min = 0;
    private int pm2_5 = 0;
    private int pm2_5_max = 0;
    private int co = 0;
    private int co_max = 0;

    public Weather() {
    }

    public Weather(int id, int client_id) {
        this.id = id;
        this.client_id = client_id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

    public int getMilliseconds() {
        return milliseconds;
    }

    public void setMilliseconds(int milliseconds) {
        this.milliseconds = milliseconds;
    }

    public int getClient_id() {
        return client_id;
    }

    public void setClient_id(int client_id) {
        this.client_id = client_id;
    }

    public float getTemperature() {
        return temperature;
    }

    public void setTemperature(float temperature) {
        this.temperature = temperature;
    }

    public float getTemperature_max() {
        return temperature_max;
    }

    public void setTemperature_max(float temperature_max) {
        this.temperature_max = temperature_max;
    }

    public float getTemperature_min() {
        return temperature_min;
    }

    public void setTemperature_min(float temperature_min) {
        this.temperature_min = temperature_min;
    }

    public float getHumidity() {
        return humidity;
    }

    public void setHumidity(float humidity) {
        this.humidity = humidity;
    }

    public float getHumidity_max() {
        return humidity_max;
    }

    public void setHumidity_max(float humidity_max) {
        this.humidity_max = humidity_max;
    }

    public float getHumidity_min() {
        return humidity_min;
    }

    public void setHumidity_min(float humidity_min) {
        this.humidity_min = humidity_min;
    }

    public int getPm2_5() {
        return pm2_5;
    }

    public void setPm2_5(int pm2_5) {
        this.pm2_5 = pm2_5;
    }

    public int getPm2_5_max() {
        return pm2_5_max;
    }

    public void setPm2_5_max(int pm2_5_max) {
        this.pm2_5_max = pm2_5_max;
    }

    public int getCo() {
        return co;
    }

    public void setCo(int co) {
        this.co = co;
    }

    public int getCo_max() {
        return co_max;
    }

    public void setCo_max(int co_max) {
        this.co_max = co_max;
    }

    public String toString() {
        return "id: " + this.id + ", timestamp: " + this.timestamp + ", milliseconds: " + this.milliseconds + ", client_id: " + this.client_id + ", temperature: " + this.temperature
                + ", temperature_max: " + this.temperature_max + ", temperature_min: " + this.temperature_min + ", humidity: " + this.humidity + ", humidity_max: " + this.humidity_max
                + ", humidity_min: " + this.humidity_min + ", pm2_5: " + this.pm2_5 + ", pm2_5_max: " + this.pm2_5_max + ", co: " + this.co + ", co_max: " + this.co_max;
    }
}

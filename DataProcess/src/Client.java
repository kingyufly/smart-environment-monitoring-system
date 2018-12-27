public class Client {
    private int client_id;
    private String device_type;
    private String description;
    private float longitude;
    private float latitude;
    private String location;

    public Client() {
    }

    public int getClient_id() {
        return client_id;
    }

    public void setClient_id(int client_id) {
        this.client_id = client_id;
    }

    public String getDevice_type() {
        return device_type;
    }

    public void setDevice_type(String device_type) {
        this.device_type = device_type;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public float getLongitude() {
        return longitude;
    }

    public void setLongitude(float longitude) {
        this.longitude = longitude;
    }

    public float getLatitude() {
        return latitude;
    }

    public void setLatitude(float latitude) {
        this.latitude = latitude;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }
    
    public String toString() {
        return "client_id: " + this.client_id + ", device_type: " + this.device_type + ", description: " + this.description
                + ", longitude: " + this.longitude + ", latitude: " + this.latitude + ", location: " + this.location;
    }
}

package models;

import java.io.Serializable;

public class Weather implements Serializable {
    private final String city;
    private final String weather;

    public Weather(String city, String weather) {
        this.city = city;
        this.weather = weather;
    }

    public String getCity() {
        return city;
    }

    public String getWeather() {
        return weather;
    }

    @Override
    public String toString() {
        return "Weather{" + "city=" + city + ", weather=" + weather + '}';
    }
}

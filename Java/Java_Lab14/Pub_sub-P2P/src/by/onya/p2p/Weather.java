package by.onya.p2p;

import java.io.Serializable;
import java.util.Date;

public class Weather implements Serializable {
    private final int temp;
    private final String state;

    public int getTemp() {
        return temp;
    }

    public String getState() {
        return state;
    }

    public Weather(int temp, String state) {
        this.temp = temp;
        this.state = state;
    }

    @Override
    public String toString() {
        return "Weather{" +
                "temp=" + temp +
                ", state='" + state + '\'' +
                '}';
    }
}
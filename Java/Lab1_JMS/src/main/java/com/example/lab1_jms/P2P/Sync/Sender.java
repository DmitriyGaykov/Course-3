package com.example.lab1_jms.P2P.Sync;

import models.Weather;

import javax.jms.ConnectionFactory;

public class Sender {
    private static final ConnectionFactory factory = new com.sun.messaging.ConnectionFactory(); // Use the ActiveMQ ConnectionFactory

    public static void main(String[] args) {
        try {
            // Create a connection. See https://docs.oracle.com/javaee/7/api/javax/jms/package-summary.html
            var connection = factory.createConnection();

            // Open a session
            var session = connection.createSession(false, javax.jms.Session.AUTO_ACKNOWLEDGE);

            // Create a queue named "MyQueue"
            var queue = session.createQueue("WeatherDestination");

            // Create a producer
            var producer = session.createProducer(queue);

            var weather = new Weather("Khoniki", "Rain");
            // Create a message
            var msg = session.createObjectMessage(weather);

            producer.send(msg);
            // Clean up
            connection.close();
        } catch (Exception e) {
            System.out.println("Exception occurred: " + e.toString());
        }
    }
}



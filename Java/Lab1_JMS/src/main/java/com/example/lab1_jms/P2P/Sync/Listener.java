package com.example.lab1_jms.P2P.Sync;

import models.Weather;

import javax.jms.ConnectionFactory;

class Listener {
    private static final ConnectionFactory factory = new com.sun.messaging.ConnectionFactory(); // Use the ActiveMQ ConnectionFactory

    public static void main(String[] args) {
        try {
            // Create a connection. See https://docs.oracle.com/javaee/7/api/javax/jms/package-summary.html
            var connection = factory.createConnection();

            // Open a session
            var session = connection.createSession(false, javax.jms.Session.AUTO_ACKNOWLEDGE);

            // Create a queue named "MyQueue"
            var queue = session.createQueue("WeatherDestination");

            // Create a consumer
            var consumer = session.createConsumer(queue);

            // Start the Connection
            connection.start();

            int i = 0;
            while(i++ < 100) {
                try {
                // Receive the message
                var message = consumer.receive();

                // Print the message
                System.out.println("Message received: " + ((javax.jms.ObjectMessage) message).getObject());
                } catch(Exception e) {
                    System.out.println("Mistake: "+ e.getMessage());
                    continue;
                }
            }
            // Clean up
            session.close();
            connection.close();
        } catch (Exception e) {
            System.out.println("Exception occurred: " + e.toString());
        }
    }
}

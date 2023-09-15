//package com.example.lab1_jms.P2P.Async;
//
//import models.Weather;
//
//import javax.jms.MessageListener;
//
//// async MOM
//public class Sender {
//    private static final javax.jms.ConnectionFactory factory = new com.sun.messaging.ConnectionFactory(); // Use the ActiveMQ ConnectionFactory
//
//    public static void main(String[] args) {
//        try {
//            // Create a connection. See https://docs.oracle.com/javaee/7/api/javax/jms/package-summary.html
//            var connection = factory.createConnection();
//
//            // Open a session
//            var session = connection.createSession(false, javax.jms.Session.AUTO_ACKNOWLEDGE);
//
//            // Create a queue named "MyQueue"
//            var queue = session.createQueue("WeatherDestination");
//
//            // Create a producer
//            var producer = session.createProducer(queue);
//
//            var weather = new Weather("Khoniki", "Thunderstorm");
//            // Create a message
//            var message = session.createObjectMessage(weather);
//
//            // Send the message
//            producer.send(message);
//
//            // Clean up
//            session.close();
//            connection.close();
//        } catch (Exception e) {
//            System.out.println("Exception occurred: " + e.toString());
//        }
//    }
//}
//

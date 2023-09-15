//package com.example.lab1_jms.P2P.Async;
//
//import javax.jms.MessageListener;
//
//// async MOM
//class Listener implements MessageListener {
//    private static final javax.jms.ConnectionFactory factory = new com.sun.messaging.ConnectionFactory(); // Use the ActiveMQ ConnectionFactory
//
//    public static void main(String[] args) {
//        try {
//            // Create a connection. See https://docs.oracle.com/javaee/7/api/javax/jms/package-summary.html
//            System.out.println("Async MOM");
//            var connection = factory.createConnection();
//
//            // Open a session
//            var session = connection.createSession(false, javax.jms.Session.AUTO_ACKNOWLEDGE);
//
//            // Create a queue named "MyQueue"
//            var queue = session.createQueue("WeatherDestination");
//
//            // Create a consumer
//            var consumer = session.createConsumer(queue);
//
//            // Start the Connection
//            connection.start();
//
//            // Register a listener for the consumer
//            consumer.setMessageListener(new Listener());
//
//            Thread.sleep(1_000_000);
//
//            // Clean up
//            session.close();
//            connection.close();
//
//        } catch (Exception e) {
//            System.out.println("Exception occurred: " + e.toString());
//        }
//    }
//
//    @Override
//    public void onMessage(javax.jms.Message message) {
//        try {
//            // Print the message
//            System.out.println("Message received: " + ((javax.jms.ObjectMessage) message).getObject());
//        } catch (Exception e) {
//            System.out.println("Exception occurred: " + e.toString());
//        }
//    }
//}

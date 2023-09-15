//package com.example.lab1_jms.pub_sub.confirmations;
//
//import com.sun.messaging.ConnectionConfiguration;
//import com.sun.messaging.ConnectionFactory;
//
//import javax.jms.*;
//
//public class Receiver1 {
//    public static void main(String[] args) {
//        ConnectionFactory factory = new ConnectionFactory();
//        try {
//            var connection = factory.createConnection();
//            var context = connection.createSession(true, Session.AUTO_ACKNOWLEDGE);
//            factory.setProperty(ConnectionConfiguration.imqAddressList,
//                    "mq://127.0.0.1:7676,mq://127.0.0.1:7676");
//            Destination priceInfo = context.createTopic("PubSub");
//
//            // Создаем подписчика (Subscriber) для темы (Topic)
//            MessageConsumer subscriber = context.createConsumer(priceInfo);
//
//            connection.start(); // Запускаем соединение
//
//            System.out.println("Waiting for messages...");
//
//            while (true) {
//                // Принимаем сообщение от темы
//                Message message = subscriber.receive();
//                System.out.println("message!");
//                if (message instanceof TextMessage) {
//                    TextMessage textMessage = (TextMessage) message;
//                    String messageText = textMessage.getText();
//                    System.out.println("Received message: " + messageText);
//                }
//            }
//        } catch (JMSException e) {
//            System.out.println("JMS Error: " + e.getMessage());
//        }
//    }
//}

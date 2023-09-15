//package com.example.lab1_jms.pub_sub.priorities;
//
//import com.sun.messaging.ConnectionConfiguration;
//import com.sun.messaging.ConnectionFactory;
//
//import javax.jms.Destination;
//import javax.jms.JMSContext;
//import javax.jms.JMSException;
//
//public class Sender1 {
//    public static void main(String[] args){
//        ConnectionFactory factory= new ConnectionFactory();
//        try {
//            var connection = factory.createConnection();
//            var context = connection.createSession(false, javax.jms.Session.AUTO_ACKNOWLEDGE);
//
//            factory.setProperty(ConnectionConfiguration.imqAddressList,
//                    "mq://127.0.0.1:7676,mq://127.0.0.1:7676");
//            Destination priceInfo  = context.createTopic("PubSub");
//            var producer = context.createProducer(priceInfo);
//
//            producer.setPriority(0);
//            producer.send(context.createTextMessage("message with priority 0"));
//
//            while (true) {
//                System.out.println("message has been sent...");
////                context.createProducer().setPriority(0).send(priceInfo, "message with priority 0");
//                producer.setPriority(0);
//                producer.send(context.createTextMessage("message with priority 0"));
//                Thread.sleep(1000);
//            }
//        } catch (JMSException | InterruptedException e) {
//            System.out.println("ConnectionConfigurationError: " + e.getMessage());
//        }
//    }
//}
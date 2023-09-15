//package com.example.lab1_jms.pub_sub.priorities;
//
//import com.sun.messaging.ConnectionConfiguration;
//import com.sun.messaging.ConnectionFactory;
//
//import javax.jms.Destination;
//import javax.jms.JMSContext;
//import javax.jms.JMSException;
//
//public class Sender {
//    public static void main(String[] args){
//        ConnectionFactory factory= new ConnectionFactory();
//        try{
//            var connection = factory.createConnection();
//            var context = connection.createSession(false, javax.jms.Session.AUTO_ACKNOWLEDGE);
//
//            factory.setProperty(ConnectionConfiguration.imqAddressList,
//                    "mq://127.0.0.1:7676,mq://127.0.0.1:7676");
//            Destination priceInfo  = context.createTopic("PubSub");
//            while (true) {
//                System.out.println("message has been sent");
////                context.createProducer().setPriority(8).send(priceInfo, "message with priority 8");
//                var producer = context.createProducer(priceInfo);
//                producer.setPriority(8);
//                producer.send(context.createTextMessage("message with priority 8"));
//                Thread.sleep(1000);
//            }
//        } catch (JMSException | InterruptedException e) {
//            System.out.println("ConnectionConfigurationError: " + e.getMessage());
//        }
//    }
//}
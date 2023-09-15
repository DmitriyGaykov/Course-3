package com.example.lab1_jms.pub_sub.confirmations;

import com.sun.messaging.ConnectionConfiguration;
import com.sun.messaging.ConnectionFactory;
import org.apache.activemq.ActiveMQConnectionFactory;

import javax.jms.*;

public class Sender {
    public static void main(String[] args){
        ConnectionFactory factory= new ConnectionFactory();
        try {
            var connection = factory.createConnection();
            var context = connection.createSession(true, Session.AUTO_ACKNOWLEDGE);
            factory.setProperty(ConnectionConfiguration.imqAddressList,
                    "mq://127.0.0.1:7676,mq://127.0.0.1:7676");
            Destination priceInfo  = context.createTopic("PubSub");
            TextMessage outMsg = context.createTextMessage("Hello world");
            context.createProducer(priceInfo).send(outMsg);
            System.out.println("message has been sent");
        } catch (JMSException e) {
            System.out.println("ConnectionConfigurationError: " + e.getMessage());
        }
    }
}
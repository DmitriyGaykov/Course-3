package by.onya.p2p.async;

import javax.jms.*;

import by.onya.p2p.Weather;
import com.sun.messaging.ConnectionFactory;
import com.sun.messaging.ConnectionConfiguration;

public class Sender {
    public static void main(String[] args){
        ConnectionFactory factory= new com.sun.messaging.ConnectionFactory();
        try(JMSContext context = factory.createContext("admin", "admin")){
            factory.setProperty(ConnectionConfiguration.imqAddressList,
                    "mq://127.0.0.1:7676,mq://127.0.0.1:7676");
            Destination messagesQueue = context.createQueue("P2PAsyncQueue");
            Weather weather = new Weather( 12, "Rain");
            ObjectMessage objMsg = context.createObjectMessage(weather);
            JMSProducer producer = context.createProducer();
            producer.send(messagesQueue, objMsg);
            System.out.println("message has been sent");
        } catch (JMSException e) {
            System.out.println("ConnectionConfigurationError: " + e.getMessage());
        }
    }
}
package by.onya.p2p.sync;

import by.onya.p2p.Weather;
import com.sun.messaging.ConnectionConfiguration;
import com.sun.messaging.ConnectionFactory;

import javax.jms.*;
import java.util.Date;

public class Sender {
    public static void main(String[] args){
        ConnectionFactory factory= new ConnectionFactory();

        try(JMSContext context = factory.createContext("admin", "admin")){
            factory.setProperty(ConnectionConfiguration.imqAddressList,
                    "mq://127.0.0.1:7676,mq://127.0.0.1:7676");

            Destination messagesQueue = context.createQueue("P2PSyncQueue");
            Weather weather = new Weather(-2, "Snow");
            ObjectMessage objMsg = context.createObjectMessage(weather);

            JMSProducer producer = context.createProducer();
            producer.send(messagesQueue, objMsg);
            System.out.println("message has been sent");

        } catch (JMSException e) {
            System.out.println("ConnectionConfigurationError: " + e.getMessage());
        }
    }
}
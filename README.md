# simple-kafka-consumer
this is a simple kafka consumer written in Java using spring kafka and dockerized.
The consumer can be started using;

 docker run --env CONSUMER_GROUP=some_group  --env KAFKA_BROKERS=localhost:9092 --env TOPICS=Pippo simple-kafka-consumer

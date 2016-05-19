# dogkeap
[![CircleCI](https://circleci.com/gh/Vungle/dogkeap/tree/master.svg?style=svg)](https://circleci.com/gh/Vungle/dogkeap/tree/master) [![Docker Hub](https://img.shields.io/badge/docker-ready-blue.svg)](https://registry.hub.docker.com/u/vungle/dogkeap/) [![Docker Pulls](https://img.shields.io/docker/pulls/vungle/dogkeap.svg)](https://registry.hub.docker.com/u/vungle/dogkeap/)

Kubernetes Metrics for Heapster -> Kafka -> Datadog using Telegraf

## Dependencies: 

**Kafka/Zookeeper Setup:** 

We have a kubernetes svc that points to our external kafka and zookeeper nodes so any kubernetes service can reference the svc's using the dns names `kafka.prod.svc.cluster.local:9092` and `zookeeper.prod.svc.cluster.local:2182`.

**Create Topic:**

Exec into container and run:

```
JMX_PORT=9989 ./kafka-topics.sh --zookeeper 172.16.32.92:2181 --create --topic inf-heapster-metrics --partitions 6 --replication-factor 2
Created topic "inf-heapster-metrics”.

JMX_PORT=9989 ./kafka-topics.sh --zookeeper 172.16.32.92:2181 --create --topic inf-heapster-events --partitions 2 --replication-factor 2
```

Test that its working:

```
docker exec kafka /bin/bash -c "JMX_PORT=9997 /opt/kafka_2.10-0.8.2.2/bin/kafka-console-consumer.sh --zookeeper 172.16.31.247 --topic inf-heapster-metrics"
```



## Deploying

**Edit _ops/deploy.yaml:**

Values to change in Heapster block:

`--sink`

https://github.com/kubernetes/heapster/blob/master/docs/sink-configuration.md#kafka

Values to change in Telegraf block:

https://github.com/influxdata/telegraf/tree/master/plugins/inputs/kafka_consumer

```
DD_API_KEY
ZK_HOST
CONSUMER_GROUP
CONSUMER_OFFSET
```

The env variables get added to the telegraf.toml on run by executing the run.sh script.

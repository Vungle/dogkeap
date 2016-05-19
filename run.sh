#!/bin/bash

set -m
CONFIG_FILE="/config/telegraf.toml"

echo "=> Starting Telegraf ..."

sed -i 's@DD_API_KEY@'$DD_API_KEY'@' $CONFIG_FILE
sed -i 's@KAFKA_TOPIC@'$KAFKA_TOPIC'@' $CONFIG_FILE
sed -i 's@ZK_HOST@'$ZK_HOST'@' $CONFIG_FILE
sed -i 's@CONSUMER_GROUP@'$CONSUMER_GROUP'@' $CONFIG_FILE
sed -i 's@CONSUMER_OFFSET@'$CONSUMER_OFFSET'@' $CONFIG_FILE
sed -i 's@DATA_FORMAT@'$DATA_FORMAT'@' $CONFIG_FILE

exec telegraf -config ${CONFIG_FILE}

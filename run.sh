#!/bin/bash

set -m
CONFIG_FILE="/config/telegraf.toml"

echo "=> Starting Telegraf ..."

if [ -z "$DD_API_KEY" ]; then sed -i 's@DD_API_KEY@'$DD_API_KEY'@' $CONFIG_FILE ; fi
if [ -z "$KAFKA_TOPIC" ]; then sed -i 's@KAFKA_TOPIC@'$KAFKA_TOPIC'@' $CONFIG_FILE ; fi
if [ -z "$ZK_HOST" ]; then sed -i 's@ZK_HOST@'$ZK_HOST'@' $CONFIG_FILE ; fi
if [ -z "$CONSUMER_GROUP" ]; then sed -i 's@CONSUMER_GROUP@'$CONSUMER_GROUP'@' $CONFIG_FILE ; fi
if [ -z "$CONSUMER_OFFSET" ]; then sed -i 's@CONSUMER_OFFSET@'$CONSUMER_OFFSET'@' $CONFIG_FILE ; fi

exec telegraf -config ${CONFIG_FILE}

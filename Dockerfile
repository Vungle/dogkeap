FROM debian:jessie
MAINTAINER Ben Bailey <bennettbailey@gmail.com>

WORKDIR /tmp/
RUN apt-get update && apt-get install -y wget
RUN wget http://get.influxdb.org/telegraf/telegraf-0.10.3-1_linux_amd64.tar.gz \
  && tar -zxvf telegraf-0.10.3-1_linux_amd64.tar.gz --strip-components=3 ./usr/bin/telegraf \
  && chmod +x telegraf \
  && mv telegraf /usr/bin/telegraf \
  && rm -rf /var/lib/apt/lists/*

COPY telegraf.toml /config/telegraf.toml
COPY run.sh /run.sh
RUN chmod +x /run.sh

ENV INFLUXDB_HOST **None**

CMD ["/run.sh"]

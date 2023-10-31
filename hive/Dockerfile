FROM bde2020/hadoop-base:2.0.0-hadoop2.7.4-java8

MAINTAINER Yiannis Mouchakis <gmouchakis@iit.demokritos.gr>
MAINTAINER Ivan Ermilov <ivan.s.ermilov@gmail.com>

ENV HIVE_VERSION 2.3.2

ENV HIVE_HOME /opt/hive
ENV PATH $HIVE_HOME/bin:$PATH


WORKDIR /opt

#Install Hive and PostgreSQL JDBC
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    wget procps && \
	wget http://apache.mirror.digionline.de/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz && \
	tar -xzvf apache-hive-$HIVE_VERSION-bin.tar.gz && \
	mv apache-hive-$HIVE_VERSION-bin hive && \
	rm apache-hive-$HIVE_VERSION-bin.tar.gz && \
	wget https://jdbc.postgresql.org/download/postgresql-9.4.1209.jre7.jar -O $HIVE_HOME/lib/postgresql-jdbc.jar && \
	apt-get --purge remove -y wget && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*


#Spark should be compiled with Hive to be able to use it
#hive-site.xml should be copied to $SPARK_HOME/conf folder

#Custom configuration goes here
ADD conf $HIVE_HOME/conf
COPY startup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/startup.sh

EXPOSE 10000
EXPOSE 10002

CMD ["startup.sh"]

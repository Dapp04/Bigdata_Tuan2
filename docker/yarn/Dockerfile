FROM ubuntu:20.04

RUN apt-get update && apt-get install -y \
    openjdk-8-jdk \
    wget \
    && apt-get clean

ENV HADOOP_VERSION=3.3.6
ENV HADOOP_HOME=/usr/local/hadoop
# === THIẾT LẬP JAVA_HOME CỨNG CHO YARN ===
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV PATH=$PATH:$HADOOP_HOME/bin

# Download and extract Hadoop (Updated link for 3.3.6)
RUN wget https://dlcdn.apache.org/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz -P /tmp \
    && tar -xzf /tmp/hadoop-$HADOOP_VERSION.tar.gz -C /usr/local/ \
    && mv /usr/local/hadoop-$HADOOP_VERSION $HADOOP_HOME \
    && rm /tmp/hadoop-$HADOOP_VERSION.tar.gz

COPY setup-yarn.sh /usr/local/bin/setup-yarn.sh
RUN chmod +x /usr/local/bin/setup-yarn.sh

CMD ["tail", "-f", "/dev/null"]
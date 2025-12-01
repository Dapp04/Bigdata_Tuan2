FROM ubuntu:20.04

RUN apt-get update && apt-get install -y \
    openjdk-8-jdk \
    wget \
    && apt-get clean

ENV HADOOP_VERSION=3.3.1
ENV HADOOP_HOME=/usr/local/hadoop
ENV PATH=$PATH:$HADOOP_HOME/bin

RUN wget https://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz \
    && tar -xzf hadoop-$HADOOP_VERSION.tar.gz -C /usr/local/ \
    && mv /usr/local/hadoop-$HADOOP_VERSION $HADOOP_HOME \
    && rm hadoop-$HADOOP_VERSION.tar.gz

COPY setup-yarn.sh /usr/local/bin/setup-yarn.sh
RUN chmod +x /usr/local/bin/setup-yarn.sh

CMD ["tail", "-f", "/dev/null"]
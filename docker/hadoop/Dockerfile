FROM ubuntu:20.04

# Set environment variables
ENV HADOOP_VERSION=3.3.6
ENV HADOOP_HOME=/opt/hadoop
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$PATH:$HADOOP_HOME/bin:$JAVA_HOME/bin

# Install dependencies & dos2unix để sửa lỗi dòng lệnh Windows
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    openjdk-11-jdk \
    openssh-server \
    wget \
    curl \
    sshpass \
    dos2unix \
    && rm -rf /var/lib/apt/lists/*

# Download Hadoop
RUN wget https://dlcdn.apache.org/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz -P /tmp \
    && tar -xzf /tmp/hadoop-$HADOOP_VERSION.tar.gz -C /opt/ \
    && mv /opt/hadoop-$HADOOP_VERSION $HADOOP_HOME \
    && rm /tmp/hadoop-$HADOOP_VERSION.tar.gz

# Copy config và script, sau đó chạy dos2unix để sửa lỗi format
COPY docker/hadoop/config/* $HADOOP_HOME/etc/hadoop/
COPY docker/hadoop/setup-hadoop.sh /opt/hadoop/setup-hadoop.sh
RUN dos2unix /opt/hadoop/setup-hadoop.sh $HADOOP_HOME/etc/hadoop/* \
    && chmod +x /opt/hadoop/setup-hadoop.sh

# Permissions & SSH
RUN chown -R root:root $HADOOP_HOME
EXPOSE 50070 8088 9000
RUN mkdir -p /root/.ssh \
    && ssh-keygen -t rsa -N '' -f /root/.ssh/id_rsa \
    && cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys \
    && chmod 700 /root/.ssh && chmod 600 /root/.ssh/authorized_keys

CMD ["bash", "/opt/hadoop/setup-hadoop.sh"]
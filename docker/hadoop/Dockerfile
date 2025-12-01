FROM ubuntu:20.04

# Set environment variables
ENV HADOOP_VERSION=3.3.6
ENV HADOOP_HOME=/opt/hadoop
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$PATH:$HADOOP_HOME/bin:$JAVA_HOME/bin

# Install dependencies
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    openjdk-11-jdk \
    openssh-server \
    wget \
    curl \
    sshpass \
    && rm -rf /var/lib/apt/lists/*

# Download and extract Hadoop (Đã cập nhật link và phiên bản 3.3.6)
RUN wget https://dlcdn.apache.org/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz -P /tmp \
    && tar -xzf /tmp/hadoop-$HADOOP_VERSION.tar.gz -C /opt/ \
    && mv /opt/hadoop-$HADOOP_VERSION $HADOOP_HOME \
    && rm /tmp/hadoop-$HADOOP_VERSION.tar.gz

# Configure Hadoop (nếu có file config)
COPY config/* $HADOOP_HOME/etc/hadoop/

# Copy startup script and make executable
COPY setup-hadoop.sh /opt/hadoop/setup-hadoop.sh
RUN chmod +x /opt/hadoop/setup-hadoop.sh

# Set permissions
RUN chown -R root:root $HADOOP_HOME

# Expose Hadoop ports
EXPOSE 50070 8088 9000

# Generate SSH keys for root (used for localhost SSH by Hadoop scripts)
RUN mkdir -p /root/.ssh \
    && ssh-keygen -t rsa -N '' -f /root/.ssh/id_rsa || true \
    && cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys || true \
    && chmod 700 /root/.ssh && chmod 600 /root/.ssh/authorized_keys

# Start the startup script when container runs
CMD ["bash", "/opt/hadoop/setup-hadoop.sh"]
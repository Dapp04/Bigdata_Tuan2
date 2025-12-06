FROM ubuntu:20.04

# Install dependencies (THÊM: openssh để sửa lỗi 'ssh command not found')
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    openjdk-8-jdk \
    wget \
    dos2unix \
    openssh-server \
    openssh-client \
    && apt-get clean

ENV HADOOP_VERSION=3.3.6
ENV HADOOP_HOME=/usr/local/hadoop
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

# Download Hadoop
RUN wget https://dlcdn.apache.org/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz -P /tmp \
    && tar -xzf /tmp/hadoop-$HADOOP_VERSION.tar.gz -C /usr/local/ \
    && mv /usr/local/hadoop-$HADOOP_VERSION $HADOOP_HOME \
    && rm /tmp/hadoop-$HADOOP_VERSION.tar.gz

# Copy configuration files
COPY docker/hadoop/config/* $HADOOP_HOME/etc/hadoop/

# Setup SSH (Tạo key để login không cần mật khẩu - Yêu cầu bắt buộc của YARN)
RUN mkdir -p /root/.ssh \
    && ssh-keygen -t rsa -N '' -f /root/.ssh/id_rsa \
    && cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys \
    && chmod 700 /root/.ssh && chmod 600 /root/.ssh/authorized_keys

# Copy setup script
COPY docker/yarn/setup-yarn.sh /usr/local/bin/setup-yarn.sh
RUN dos2unix /usr/local/bin/setup-yarn.sh $HADOOP_HOME/etc/hadoop/* \
    && chmod +x /usr/local/bin/setup-yarn.sh

CMD ["tail", "-f", "/dev/null"]
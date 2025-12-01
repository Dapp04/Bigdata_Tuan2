FROM eclipse-temurin:8-jdk

ENV SPARK_VERSION=3.3.1
ENV HADOOP_VERSION=3.3.1
ENV SPARK_HOME=/opt/spark
ENV PATH=$SPARK_HOME/bin:$PATH

RUN apt-get update && apt-get install -y \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Tải Spark với Hadoop 3.3.1
RUN wget https://archive.apache.org/dist/spark/spark-3.3.1/spark-3.3.1-bin-hadoop3.tgz \
    && tar -xzf spark-3.3.1-bin-hadoop3.tgz -C /opt/ \
    && mv /opt/spark-3.3.1-bin-hadoop3 /opt/spark \
    && rm spark-3.3.1-bin-hadoop3.tgz
# Copy script khởi động Spark vào image
COPY setup-spark.sh /opt/spark/setup-spark.sh
RUN chmod +x /opt/spark/setup-spark.sh

CMD ["/opt/spark/setup-spark.sh"]
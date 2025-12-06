FROM eclipse-temurin:8-jdk

ENV SPARK_VERSION=3.2.1
ENV HADOOP_VERSION=3.3.1
ENV SPARK_HOME=/opt/spark
ENV PATH=$SPARK_HOME/bin:$PATH

# Install minimal dependencies & dos2unix (BỎ cài openjdk để tránh trùng lặp)
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    dos2unix \
    && rm -rf /var/lib/apt/lists/*

# Create spark home dir
RUN mkdir -p /opt/spark

# Copy scripts and config
COPY docker/spark/setup-spark.sh /opt/spark/setup-spark.sh
COPY docker/hadoop/config/* /opt/hadoop/etc/hadoop/

# Fix line endings
RUN dos2unix /opt/spark/setup-spark.sh /opt/hadoop/etc/hadoop/* \
    && chmod +x /opt/spark/setup-spark.sh

CMD ["/opt/spark/setup-spark.sh"]
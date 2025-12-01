#!/bin/bash

# Update package list and install necessary packages
apt-get update && apt-get install -y \
    openjdk-11-jdk \
    scala \
    wget \
    curl

# Set environment variables for Spark
export SPARK_VERSION=3.2.1
export HADOOP_VERSION=3.3.1
export SPARK_HOME=/opt/spark
export PATH=$PATH:$SPARK_HOME/bin

# Download and extract Spark
wget https://downloads.apache.org/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz -P /tmp
tar -xzf /tmp/spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz -C /opt
mv /opt/spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION $SPARK_HOME

# Clean up
rm /tmp/spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz

# Configure Spark to use Hadoop
echo "export HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop" >> $SPARK_HOME/conf/spark-env.sh

# Start Spark services (if needed)
# Uncomment the following line if you want to start the Spark master and worker
# $SPARK_HOME/sbin/start-master.sh && $SPARK_HOME/sbin/start-slave.sh spark://localhost:7077

# Print Spark version to verify installation
$SPARK_HOME/bin/spark-submit --version

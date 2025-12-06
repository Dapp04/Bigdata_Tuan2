#!/bin/bash

# (Đã bỏ lệnh apt-get install java ở đây để chạy nhanh hơn)

# Set environment variables
export SPARK_VERSION=3.2.1
# SỬA LỖI: Dùng bản build cho Hadoop 3.2 (tương thích Hadoop 3.3) vì bản 3.3.1 không có sẵn
export HADOOP_BUILD_VERSION=3.2 
export SPARK_HOME=/opt/spark
export PATH=$PATH:$SPARK_HOME/bin

# Download Spark from Archive
echo "Downloading Spark $SPARK_VERSION for Hadoop $HADOOP_BUILD_VERSION..."
wget -q https://archive.apache.org/dist/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop$HADOOP_BUILD_VERSION.tgz -P /tmp

# Extract
echo "Extracting Spark..."
tar -xzf /tmp/spark-$SPARK_VERSION-bin-hadoop$HADOOP_BUILD_VERSION.tgz -C /opt
# Xử lý tên thư mục linh hoạt
if [ -d "/opt/spark-$SPARK_VERSION-bin-hadoop$HADOOP_BUILD_VERSION" ]; then
    mv /opt/spark-$SPARK_VERSION-bin-hadoop$HADOOP_BUILD_VERSION/* $SPARK_HOME/ 2>/dev/null || mv /opt/spark-$SPARK_VERSION-bin-hadoop$HADOOP_BUILD_VERSION $SPARK_HOME
fi

# Clean up
rm /tmp/spark-$SPARK_VERSION-bin-hadoop$HADOOP_BUILD_VERSION.tgz

# Configure Spark
echo "export HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop" >> $SPARK_HOME/conf/spark-env.sh

echo "Spark setup completed."
$SPARK_HOME/bin/spark-submit --version
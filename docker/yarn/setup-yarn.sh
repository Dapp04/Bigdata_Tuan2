#!/bin/bash

# Script này thiết lập biến môi trường PATH để tìm thấy các lệnh Hadoop/YARN.

# Thiết lập đường dẫn cứng cho Hadoop và YARN (Sẽ được Dockerfile ưu tiên)
export HADOOP_HOME=/usr/local/hadoop
export YARN_HOME=$HADOOP_HOME

# Cài đặt biến môi trường vào bash profile
echo "export HADOOP_HOME=$HADOOP_HOME" >> /etc/profile
echo "export PATH=\$PATH:\$HADOOP_HOME/bin" >> /etc/profile
echo "export PATH=\$PATH:\$HADOOP_HOME/sbin" >> /etc/profile

echo "YARN environment setup completed."
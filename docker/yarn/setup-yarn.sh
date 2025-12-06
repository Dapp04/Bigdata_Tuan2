#!/bin/bash

# Start SSH service (Bắt buộc để start-yarn.sh hoạt động)
service ssh start

# Set env vars
export HADOOP_HOME=/usr/local/hadoop
export YARN_HOME=$HADOOP_HOME

echo "YARN environment setup completed."
#!/bin/bash

# Update package list and install necessary packages
apt-get update && apt-get install -y openjdk-8-jdk wget

# Set environment variables for Hadoop and YARN
export HADOOP_HOME=/usr/local/hadoop
export YARN_HOME=$HADOOP_HOME

# Download and extract Hadoop
wget https://downloads.apache.org/hadoop/common/hadoop-3.3.1/hadoop-3.3.1.tar.gz -P /tmp
tar -xzf /tmp/hadoop-3.3.1.tar.gz -C /usr/local
mv /usr/local/hadoop-3.3.1 $HADOOP_HOME

# Configure Hadoop environment variables
echo "export HADOOP_HOME=$HADOOP_HOME" >> /etc/profile.d/hadoop.sh
echo "export PATH=\$PATH:\$HADOOP_HOME/bin" >> /etc/profile.d/hadoop.sh
echo "export PATH=\$PATH:\$HADOOP_HOME/sbin" >> /etc/profile.d/hadoop.sh

# Configure YARN settings
cat <<EOL > $HADOOP_HOME/etc/hadoop/yarn-site.xml
<configuration>
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>
    <property>
        <name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name>
        <value>org.apache.hadoop.yarn.server.nodemanager.auxservices.ShuffleHandler</value>
    </property>
</configuration>
EOL

# Start YARN services
$HADOOP_HOME/sbin/start-yarn.sh

# Clean up
rm /tmp/hadoop-3.3.1.tar.gz

echo "YARN setup completed."
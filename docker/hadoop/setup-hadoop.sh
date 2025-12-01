#!/bin/bash

# Startup script for Hadoop container
# - ensure SSH is running
# - ensure JAVA_HOME and user exports exist in hadoop-env.sh
# - format namenode if not already formatted
# - start HDFS and YARN

set -e

HADOOP_HOME=${HADOOP_HOME:-/opt/hadoop}
HADOOP_ENV="$HADOOP_HOME/etc/hadoop/hadoop-env.sh"

echo "[startup] script running"

# Start ssh service (install expected in image)
if command -v service >/dev/null 2>&1; then
    service ssh start || /etc/init.d/ssh start || true
fi

# Ensure ssh keys allow localhost login
mkdir -p /root/.ssh
if [ -f /root/.ssh/id_rsa.pub ] && ! grep -q "$(cat /root/.ssh/id_rsa.pub)" /root/.ssh/authorized_keys 2>/dev/null; then
    cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys || true
fi
chmod 700 /root/.ssh || true
chmod 600 /root/.ssh/authorized_keys || true

# Make sure hadoop-env.sh contains JAVA_HOME and service-user exports
if [ -f "$HADOOP_ENV" ]; then
    grep -q "^export JAVA_HOME=" "$HADOOP_ENV" || echo "export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64" >> "$HADOOP_ENV"
    grep -q "^export HDFS_NAMENODE_USER=" "$HADOOP_ENV" || echo "export HDFS_NAMENODE_USER=root" >> "$HADOOP_ENV"
    grep -q "^export HDFS_DATANODE_USER=" "$HADOOP_ENV" || echo "export HDFS_DATANODE_USER=root" >> "$HADOOP_ENV"
    grep -q "^export HDFS_SECONDARYNAMENODE_USER=" "$HADOOP_ENV" || echo "export HDFS_SECONDARYNAMENODE_USER=root" >> "$HADOOP_ENV"
    grep -q "^export YARN_RESOURCEMANAGER_USER=" "$HADOOP_ENV" || echo "export YARN_RESOURCEMANAGER_USER=root" >> "$HADOOP_ENV"
    grep -q "^export YARN_NODEMANAGER_USER=" "$HADOOP_ENV" || echo "export YARN_NODEMANAGER_USER=root" >> "$HADOOP_ENV"
else
    cat > "$HADOOP_ENV" <<'EOF'
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export HDFS_NAMENODE_USER=root
export HDFS_DATANODE_USER=root
export HDFS_SECONDARYNAMENODE_USER=root
export YARN_RESOURCEMANAGER_USER=root
export YARN_NODEMANAGER_USER=root
EOF
fi

# Ensure permissions
chown -R root:root "$HADOOP_HOME" || true

# Create logs dir if missing
mkdir -p $HADOOP_HOME/logs
chown -R root:root $HADOOP_HOME/logs || true

# Format NameNode if not formatted
NN_CURRENT="/tmp/hadoop-root/dfs/name/current"
if [ ! -d "$NN_CURRENT" ]; then
    echo "[startup] NameNode not formatted — formatting now"
    # run format as root; noninteractive
    $HADOOP_HOME/bin/hdfs namenode -format -force -nonInteractive || true
else
    echo "[startup] NameNode already formatted"
fi

# Start HDFS and YARN
echo "[startup] starting HDFS"
$HADOOP_HOME/sbin/start-dfs.sh || true
echo "[startup] starting YARN"
$HADOOP_HOME/sbin/start-yarn.sh || true

echo "[startup] waiting a bit for services to come up"
sleep 3

echo "[startup] tailing logs (container will keep running)"
tail -F $HADOOP_HOME/logs/* || tail -f /dev/null
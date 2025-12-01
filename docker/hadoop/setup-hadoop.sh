#!/bin/bash

# Startup script for Hadoop container
# - ensure SSH is running
# - format namenode if not already formatted
# - start HDFS services (dfs)

set -e

HADOOP_HOME=${HADOOP_HOME:-/opt/hadoop}
HADOOP_ENV="$HADOOP_HOME/etc/hadoop/hadoop-env.sh"

echo "[startup] script running"

# 1. Start ssh service
service ssh start || /etc/init.d/ssh start || true

# 2. Ensure ssh keys allow localhost login
mkdir -p /root/.ssh
if [ -f /root/.ssh/id_rsa.pub ] && ! grep -q "$(cat /root/.ssh/id_rsa.pub)" /root/.ssh/authorized_keys 2>/dev/null; then
    cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys || true
fi
chmod 700 /root/.ssh || true
chmod 600 /root/.ssh/authorized_keys || true

# 3. Format NameNode if not formatted
NN_CURRENT="/tmp/hadoop-root/dfs/name/current"
if [ ! -d "$NN_CURRENT" ]; then
    echo "[startup] NameNode not formatted - formatting now"
    # Định dạng NameNode
    $HADOOP_HOME/bin/hdfs namenode -format -force -nonInteractive || true
else
    echo "[startup] NameNode already formatted"
fi

# 4. Start HDFS services (NameNode and DataNode)
echo "[startup] starting HDFS"
# Chỉ start dfs.sh, vì yarn.sh được start trong container yarn riêng
$HADOOP_HOME/sbin/start-dfs.sh || true 

# 5. Keep container running by monitoring specific logs (SỬA LỖI TAIL)
echo "[startup] monitoring NameNode and DataNode logs (container will keep running)"
# Lệnh tail -f /dev/null an toàn hơn nếu việc tail file cụ thể bị lỗi
tail -f /dev/null
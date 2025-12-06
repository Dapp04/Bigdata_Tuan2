# --- TỰ ĐỘNG PHÁT HIỆN JAVA_HOME ---
# Kiểm tra nếu thư mục Java 11 tồn tại (dành cho container Hadoop)
if [ -d "/usr/lib/jvm/java-11-openjdk-amd64" ]; then
    export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
# Kiểm tra nếu thư mục Java 8 tồn tại (dành cho container YARN/Spark)
elif [ -d "/usr/lib/jvm/java-8-openjdk-amd64" ]; then
    export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
fi
# -----------------------------------

export HDFS_NAMENODE_USER=root
export HDFS_DATANODE_USER=root
export HDFS_SECONDARYNAMENODE_USER=root
export YARN_RESOURCEMANAGER_USER=root
export YARN_NODEMANAGER_USER=root
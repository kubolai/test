#!/bin/sh
# 在服务器上运行：生成所有密钥到 /etc/proxy/secrets（权限 600），不打印到终端。
set -e
D=/etc/proxy; mkdir -p "$D"; umask 077
[ -f "$D/secrets" ] && { echo "secrets 已存在，未覆盖"; exit 0; }
K=$(xray x25519)
{
  echo "UUID=$(xray uuid)"
  echo "PRIV=$(echo "$K" | awk -F': ' 'NR==1{print $2}')"
  echo "PUB=$(echo "$K" | awk -F': ' 'NR==2{print $2}')"
  echo "SID=$(openssl rand -hex 8)"
  echo "PATH_A=$(openssl rand -hex 8)"
  echo "PATH_B=$(openssl rand -hex 8)"
  echo "SUB_PATH=$(openssl rand -hex 16)"
  echo "HY2_PASS=$(openssl rand -hex 16)"
  echo "HY2_OBFS=$(openssl rand -hex 16)"
} > "$D/secrets"
echo "已写入 $D/secrets"

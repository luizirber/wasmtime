#!/bin/bash
set -e

# Clean up Python 3.7 from previous step
cd Python-3.7.3
make uninstall
cd ..
rm -rf Python-3.7.3

yum install -y gcc bzip2-devel libffi-devel zlib-devel

cd /usr/src/

# python3.8 needs new openssl
curl -O -L https://github.com/openssl/openssl/archive/OpenSSL_1_1_1c.tar.gz
tar -zxvf OpenSSL_1_1_1c.tar.gz
cd openssl-OpenSSL_1_1_1c
./Configure shared zlib linux-x86_64
make -sj4
make install
cd ..
rm -rf openssl-OpenSSL_1_1_1c

# Fixing libssl.so.1.1: cannot open shared object file
echo "/usr/local/lib64" >> /etc/ld.so.conf && ldconfig

curl -O -L https://www.python.org/ftp/python/3.8.0/Python-3.8.0.tgz
tar xzf Python-3.8.0.tgz
cd Python-3.8.0
./configure
make -sj4
make install
cd ..
rm -rf Python-3.8.0

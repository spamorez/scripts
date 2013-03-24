#!/bin/sh
pwd=`pwd`
hostname=`hostname`
SRC_DIR=/home/SRC/distfiles
WORK_DIR=/usr/src
CONF_DIR=/home/SRC/databases/CONF
PATCH_DIR=/home/SRC/databases/PATCH
####################################################
echo ""

PORT_PATH=/usr/ports/databases/mysql55-server
cd $PORT_PATH

#make extract
#cp $PATCH_DIR/* $PORT_PATH/files

make BATCH=yes FORCE_PKG_INSTALL=yes \
    WITH_CHARSET=utf8 WITH_COLLATION=utf8_bin \
install clean

mkdir /data/mysql
mkdir /var/run/mysql


# add mysql user
pw user add mysql -d /data/mysql -s /nonexisting
chown mysql /var/run/mysql
chown mysql /var/log/mysql

# ini DB
/usr/local/bin/mysql_install_db --datadir=/data/mysql --basedir=/usr/local
chown -R mysql /data/mysql


cat /usr/local/share/mysql/mysql.server \
| sed "s/^basedir=$/basedir=\/usr\/local/g"  \
| sed "s/^datadir=$/datadir=\/data\/mysql/g" \
>  /usr/local/etc/rc.d/mysql-server.sh
chmod +x /usr/local/etc/rc.d/mysql-server.sh


# <FA><C1><D0><D5><D3><CB> mysql
/usr/local/etc/rc.d/mysql-server.sh start

mv ~/.my.cnf ~/.my.cnf.`date  +'%d%m%Y%H%M'`

pass='elkgbvjwel'
/usr/local/bin/mysqladmin -u root password "$pass"
#/usr/local/bin/mysqladmin -u root -h localhost password "$pass"


echo "[client]
user=root
password=$pass
" > ~/.my.cnf

cd $pwd


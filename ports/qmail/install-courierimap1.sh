#!/bin/sh


pwd=`pwd`


#wget http://heanet.dl.sourceforge.net/sourceforge/courier/courier-authlib-0.59.3.tar.bz2
#bunzip2 -k courier-authlib-0.59.3.tar.bz2
#tar xf courier-authlib-0.59.3.tar
#rm  courier-authlib-0.59.3.tar
#ln -s courier-authlib-0.59.3 courier-authlib

cd courier-authlib

./configure --prefix=/var/qmail/courier \
--without-authpam \
--without-authldap \
--without-authpwd \
--without-authmysql \
--without-authpgsql \
--without-authshadow \
--without-authuserdb \
--without-authcustom \
--without-authcram \
--without-authpipe \
--without-authdaemon \
--with-authvchkpw 

make all
make install
make install-configure

#vi /usr/local/courier-authlib/etc/authlib/authdaemonrcauthmodulelist="authvchkpw"	<-- Authenticate via vpopmail

#cp courier-authlib.sysvinit /usr/local/etc/rc.d/240-courier-authlib.sh
#chmod 744 /usr/local/etc/rc.d/240-courier-authlib.sh


#echo "AuthLib OK, waiting"
#sleep 10

#cd $pwd
#exit 0

# wget http://prdownloads.sourceforge.net/courier/courier-imap-4.4.1.tar.bz2

#bunzip2 -k courier-imap-4.4.1.tar.bz2
#tar xf courier-imap-4.4.1.tar
#rm  courier-imap-4.4.1.tar
#ln -s courier-imap-4.4.1 courier-imap
#cd courier-imap
#
#COURIERAUTHCONFIG=/var/qmail/courier/bin/courierauthconfig \
#CPPFLAGS=-I/var/qmail/courier/include \
#./configure \
#  --prefix=/var/qmail/courier \
#  --disable-root-check \
#  --without-ssl
#
#make
#make install
#make install-configure
#
#cp courier-imap.sysvinit /usr/local/etc/rc.d/360-courier-imap

#cd $pwd

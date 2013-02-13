#!/bin/sh
#
# $FreeBSD: ports/mail/p5-Mail-SpamAssassin/files/sa-spamd.sh.in,v 1.1 2006/03/20 13:03:33 garga Exp $
#

# PROVIDE: spamd
# REQUIRE: LOGIN
# BEFORE: mail
# KEYWORD: shutdown

#
# Add the following lines to /etc/rc.conf to enable spamd:
#
#spamd_enable="YES"
#
# See spamd(8) for flags
#

. /etc/rc.subr

name=spamd
rcvar=`set_rcvar`

load_rc_config $name

# Set defaults
: ${spamd_enable:="NO"}
: ${spamd_flags="-c  "}

pidfile=${spamd_pidfile:-"/var/run/spamd/spamd.pid"}
command=/usr/local/bin/spamd
command_args="-d --round-robin -m 10 -r ${pidfile} --socketpath=/var/spool/spamd/spamd"
required_dirs=/usr/local/share/spamassassin

stop_postcmd=stop_postcmd

stop_postcmd()
{
  rm -f $pidfile
}

run_rc_command "$1"

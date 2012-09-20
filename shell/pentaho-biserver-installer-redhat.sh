#!/bin/bash

# check port 80
netstat -apn | grep -E ":80[[:blank:]]+" > /dev/null 2>&1
if [ $? -eq 0 ]; then
	echo "Error: Port 80 for biserver is unavailable."
	exit 1
fi
netstat -apn | grep -E ":8099[[:blank:]]+" > /dev/null 2>&1
if [ $? -eq 0 ]; then
	echo "Error: Port 8099 for biserver admin console is unavailable."
	exit 1
fi

# delete old temp files
rm -rf /tmp/pentaho-biserver-installer-*

# create temp dir
TMPDIR="/tmp/pentaho-biserver-installer-`date +%Y%m%d%H%M%S`"
mkdir $TMPDIR

# check wget
eval "rpm -q wget > /dev/null 2>&1"
if [ $? -ne 0 ]; then
	echo "Install wget ..."
	yum install wget
	echo "The wget is installed."
fi

# check tar
eval "rpm -q tar > /dev/null 2>&1"
if [ $? -ne 0 ]; then
	echo "Install tar ..."
	yum install tar
	echo "The tar is installed."
fi

# check jre
eval "rpm -q jre > /dev/null 2>&1"
if [ $? -ne 0 ]; then
	echo "Start download jre ..."
	if [ "`getconf LONG_BIT`" -eq "32" ]; then
		wget -O $TMPDIR/jre.rpm 'http://javadl.sun.com/webapps/download/AutoDL?BundleId=68233'
	else
		wget -O $TMPDIR/jre.rpm 'http://javadl.sun.com/webapps/download/AutoDL?BundleId=68235'
	fi
	echo "The jre is downloaded."
	echo "Install jre ..."
	rpm -ivh $TMPDIR/jre.rpm
	echo "The jre is installed."
fi

# install pentaho biserver
echo "Start download biserver ..."
mkdir /opt/biserver > /dev/null 2>&1
wget -O $TMPDIR/biserver.tar.gz 'http://downloads.sourceforge.net/project/pentaho/Business%20Intelligence%20Server/4.5.0-stable/biserver-ce-4.5.0-stable.tar.gz'
echo "The biserver is downloaded."
echo "Install biserver ..."
tar -zxf $TMPDIR/biserver.tar.gz -C /opt/biserver
echo "The biserver is installed."
wget -O /opt/biserver/biserver-ce/tomcat/conf/server.xml --no-check-certificate 'https://raw.github.com/belerweb/pentaho-biserver-installer/biserver-4.5.0-stable/patch/biserver-ce/tomcat/conf/server.xml'

# delete tmp files
rm -rf /tmp/pentaho-biserver-installer-*

# tip
echo "Use '/opt/biserver/biserver-ce/start-pentaho.sh' to start biserver."
echo "Use '/opt/biserver/biserver-ce/stop-pentaho.sh' to stop biserver."
echo "Use '/opt/biserver/administration-console/start-pac.sh to start biserver admin console.'"
echo "Use '/opt/biserver/administration-console/stop-pac.sh' to stop biserver admin console."

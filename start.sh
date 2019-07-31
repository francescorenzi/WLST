#! /bin/sh

####   "java weblogic.WLST manageServers.py -u username -p password -a adminUrl [:] -n ServerName -c [stop:start:restart:status:stopall:startall:statusall]\n"

export JAVA_HOME=/u01/oracle/products/jdk
#. /home/oracle/scripts/start_admin.sh
#. /home/oracle/scripts/start_nm.sh
. /u01/oracle/products/wls12/oracle_home/wlserver/server/bin/setWLSEnv.sh

servers=$(ps -fu oracle | grep Dweblogic.Name | sed 's/Dweblogic.Name=/--/' | awk 'BEGIN {FS="---"} {print $2}' | awk 'BEGIN {FS=" "} {print $1}')
echo $servers

for i in $servers
do
	echo $i
	java weblogic.WLST manageServers.py  -n $i -c startall
done


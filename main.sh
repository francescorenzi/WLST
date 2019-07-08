#! /bin/sh

# visualizzo i servizi in corso
ps -eaf > /home/oracle/scripts/1_processi.txt
yum history > /home/oracle/scripts/2_yum_history.txt
yum update summary > /home/oracle/scripts/3_yum_update_summary.txt
yum updateinfo list security all | grep Critical > /home/oracle/scripts/4_lista_patch_critical.txt

# starto NodeManager e admin
if (( $(ps -eaf | grep -v grep | grep NodeManager | wc -l) > 0 )); then
  echo "NodeManager è già in esecuzione"
else
  /home/oracle/scripts/start_nm.sh || /home/oracle/scripts/start_nm.sh | grep error > /home/oracle/scripts/error/error_start_nm_sh.txt;
fi

if (( $(ps -eaf | grep -v grep | grep admin | wc -l) > 0 )); then
  echo "Admin è già in esecuzione"
else
  /home/oracle/scripts/start_admin.sh || /home/oracle/scripts/start_admin.sh | grep error > /home/oracle/scripts/error/error_start_admin_sh.txt;
fi

sleep 3

# Ambientarsi java e setWlsEnv
export JAVA_HOME=/u01/oracle/products/jdk
/u01/oracle/products/wls12/oracle_home/wlserver/server/bin/setWLSEnv.sh

java weblogic.WLST /home/oracle/scripts/wlst_start_stop.py #trovare un modo per avviare l'esecuzione dello script .py dentro wls

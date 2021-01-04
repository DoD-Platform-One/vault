#! /bin/bash

FILE=/opt/cloudhsm/etc/customerCA.crt
if [ -f "$FILE" ]; then
    echo "$FILE exists."
else 
    echo "$FILE does not exist."
    # touch /opt/cloudhsm/etc/customerCA.crt
    exit 0
fi

# start cloudhsm client
echo -n "* Starting CloudHSM client ... "
/opt/cloudhsm/bin/cloudhsm_client /opt/cloudhsm/etc/cloudhsm_client.cfg &> /tmp/cloudhsm_client_start.log &

# wait for startup
while true
do
    if grep 'libevmulti_init: Ready !' /tmp/cloudhsm_client_start.log &> /dev/null
    then
        echo "[OK]"
        break
    fi
    sleep 0.5
done
echo -e "\n* CloudHSM client started successfully ... \n"
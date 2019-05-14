#!/bin/bash

# check if less than 2 arguments passed
if [ $# -ne 2 ]
then
        echo "Usage: $0 [instanceID] [start||stop]"
        exit 1;
fi

#arguments
instanceID=$1
actions=$2

#get instance status
checkStatus=`aws ec2 describe-instance-status --instance-ids ${instanceID} | grep -E "running/passed" | wc -l`

if [ "${checkStatus}" -eq "3" ]; then
        instanceStatus=started
elif [ "${checkStatus}" -lt "3" ] && [ "${checkStatus}" -gt "0" ]; then
        instanceStatus=troubled
elif [ "${checkStatus}" -eq "0" ]; then
        instanceStatus=stopped
fi

#start instance (private)
if [ "${actions}"  == "start" ] && [ "${instanceStatus}"  == "started" ]; then
        echo "INSTANCE ${instanceID} ALREADY STARTED"
elif [ "${actions}"  == "start" ] && [ "${instanceStatus}"  == "troubled" ]; then
        echo "INSTANCE ${instanceID} NEED TROUBLESHOOTING"
elif [ "${actions}"  == "start" ] && [ "${instanceStatus}"  == "stopped" ]; then
        aws ec2 start-instances --instance-ids ${instanceID}
fi

#stop instance  
if [ "${actions}"  == "stop" ] && [ "${instanceStatus}"  == "stopped" ]; then
        echo "INSTANCE ${instanceID} ALREADY STOPPED"
elif [ "${actions}"  == "stop" ] && [ "${instanceStatus}"  == "troubled" ]; then
        aws ec2 stop-instances --instance-ids ${instanceID}
elif [ "${actions}"  == "stop" ] && [ "${instanceStatus}"  == "started" ]; then
        aws ec2 stop-instances --instance-ids ${instanceID}
fi

#!/bin/bash

# check if less than 2 arguments passed
if [ $# -ne 2 ]
then
        echo "Usage: $0 [volumeID] [instanceID]"
        exit 1;
fi

#arguments
volumeID=$1
instanceID=$2


aws ec2 attach-volume --volume-id ${volumeID} --instance-id ${instanceID} --device /dev/sdf

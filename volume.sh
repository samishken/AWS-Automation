#!/bin/bash

# check if less than 2 arguments passed
if [ $# -ne 3 ]
then
  echo "Usage: $0 [availabilityZone] [volumeType] [volumeSize]"
  exit 1;
fi

availabilityZone=$1
volumeType=$2
volumeSize=$3
# volumeName=$4   need to look into adding the fourth argument         

#add ebs volume
createVolume=`aws ec2 create-volume --availability-zone ${availabilityZone} --volume-type ${volumeType} --size ${volumeSize} --tag-specifications 'ResourceType=volume,Tags=[{Key=Name,Value=LFC}]'`

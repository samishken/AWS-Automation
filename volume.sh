#!/bin/bash

# check if less than 2 arguments passed
if [ $# -ne 5 ]
then
  echo "Usage: $0 [availabilityZone] [volumeType] [volumeSize] [volumeKey] [volumeName]"
  exit 1;
fi

availabilityZone=$1
volumeType=$2
volumeSize=$3
volumeKey=$4
volumeName=$5          

#add ebs volume
createVolume=`aws ec2 create-volume --availability-zone ${availabilityZone} --volume-type ${volumeType} --size ${volumeSize} --tag-specifications 'ResourceType=volume,Tags=[{Key='${volumeKey}',Value='${volumeName}'}]'`

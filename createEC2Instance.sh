#!/bin/bash

DATE=$(date '+%Y-%m-%d:%H:%M:%S')
DIR_NAME="jenkins-dir-$(date '+%Y-%m-%d')"

#Assumes you have installed, configured the aws cli and installed jq - The JSON parser
#https://stedolan.github.io/jq/download/
#http://docs.aws.amazon.com/cli/latest/userguide/installing.html#install-bundle-other-os

#Create key pair to use with this jenkins server
KEY_PAIR_NAME=$(./createKeyPair.sh)
echo "Created key pair: $KEY_PAIR_NAME"

#Create a security group for the EC2 instance
SG_NAME=$(./createSGGroup.sh)
echo "Created security group: $SG_NAME"

#Create an AWS EC2 instance using Ubuntu 14.04 LTS image
EC2_INSTANCE_ID=$(aws ec2 run-instances --image-id ami-d732f0b7 --user-data file://configure-server.sh --count 1 --instance-type t2.small --key-name $KEY_PAIR_NAME --security-groups $SG_NAME | jq .Instances[0].InstanceId | tr -d '"')

echo "Starting an EC2 instance for the jenkins server and installing jenkins on it: $EC2_INSTANCE_ID"
aws ec2 describe-instances --instance-ids $EC2_INSTANCE_ID > $DIR_NAME/$EC2_INSTANCE_ID.json

IP_JENKINS_INSTANCE=$(cat $DIR_NAME/$EC2_INSTANCE_ID.json | jq .Reservations[0].Instances[0].PublicIpAddress | tr -d '"')

cp update-jenkins-ip.json $DIR_NAME/update-jenkins-ip.json
sed -i.bak "s|@IP_JENKINS|$IP_JENKINS_INSTANCE|g" $DIR_NAME/update-jenkins-ip.json

echo "Changing the routing, making alias point to the new EC2 instance."
aws route53 change-resource-record-sets --hosted-zone-id ZQ4GCH1PM0Y7X --change-batch file://$DIR_NAME/update-jenkins-ip.json > $DIR_NAME/hosted-zone-change.json

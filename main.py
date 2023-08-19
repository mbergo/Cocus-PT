#!/usr/bin/env python3

import boto3
import sys
from prettytable import PrettyTable

# Function to fetch EC2 instances based on a search criteria


def get_ec2_instances(search):
    # Initializing boto3 resource for EC2 in 'eu-central-1' region
    ec2 = boto3.resource('ec2', region_name='eu-central-1')

    # If search is '*', fetch all instances, else filter by the given tag name
    if search == '*':
        instances = ec2.instances.all()
    else:
        instances = ec2.instances.filter(Filters=[{
            'Name': 'tag:Name',
            'Values': [search]
        }])

    instances_data = []
    total_ebs_size = 0

    # Loop through each instance and gather required data
    for instance in instances:
        total_size_ebs = sum(
            [int(volume.size) for volume in instance.volumes.all()]
        )
        total_ebs_size += total_size_ebs

        instances_data.append({
            'instance-id': instance.id,
            'instance-type': instance.instance_type,
            'status': instance.state['Name'],
            'private-ip': instance.private_ip_address,
            'public-ip': instance.public_ip_address,
            'total-size-ebs-volumes': total_size_ebs
        })

    # Sort instances data by total EBS volume size
    instances_data.sort(
        key=lambda x: x['total-size-ebs-volumes'], reverse=True)

    # Prepare the output table
    table = PrettyTable(['Instance ID', 'Instance Type', 'Status',
                        'Private IP', 'Public IP', 'Total EBS Size (GB)'])

    for data in instances_data:
        table.add_row([
            data['instance-id'],
            data['instance-type'],
            data['status'],
            data['private-ip'],
            data['public-ip'],
            data['total-size-ebs-volumes']
        ])

    print(table)
    print(f"\nTotal EBS size across all servers: {total_ebs_size} GB")


if __name__ == '__main__':
    # Get the search argument or use '*' by default
    search = sys.argv[1] if len(sys.argv) > 1 else '*'
    get_ec2_instances(search)

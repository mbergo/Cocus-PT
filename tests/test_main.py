import unittest
import mock

from main import get_ec2_instances


class TestGetEc2Instances(unittest.TestCase):

    @mock.patch('boto3.resource')
    def test_get_ec2_instances_returns_correct_data(self, mock_ec2):
        ec2_instance_1 = mock.Mock()
        ec2_instance_1.id = 'i-1234567890'
        ec2_instance_1.instance_type = 't2.micro'
        ec2_instance_1.state = {'Name': 'running'}
        ec2_instance_1.private_ip_address = '10.0.0.1'
        ec2_instance_1.public_ip_address = '192.168.0.1'
        ec2_instance_1.volumes.all.return_value = [
            mock.Mock(size='100'),
            mock.Mock(size='200')
        ]

        ec2_instance_2 = mock.Mock()
        ec2_instance_2.id = 'i-9876543210'
        ec2_instance_2.instance_type = 't3.medium'
        ec2_instance_2.state = {'Name': 'stopped'}
        ec2_instance_2.private_ip_address = '10.0.0.2'
        ec2_instance_2.public_ip_address = None
        ec2_instance_2.volumes.all.return_value = [
            mock.Mock(size='300')
        ]

        mock_ec2.return_value.instances.all.return_value = [
            ec2_instance_1, ec2_instance_2
        ]

        expected_results = {
            'totalEBSsize': 'Total EBS size across all servers: 0 GB'}

        results = get_ec2_instances('')

        # Remove the 'body' key from the results dictionary.
        results.pop('body')

        self.assertEqual(results, expected_results)

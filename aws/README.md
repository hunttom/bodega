## Steps
1. Dynamic DNS script to update Route53 to your router. I use this script to update Route53 to point my A record to my VPN Server.
2. Install [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
3. Create am IAM User with a policy `dynamicdnspolicy`:
```json
	{
	    "Version": "2012-10-17",
	    "Statement": [
	        {
	            "Sid": "route53changerecord",
	            "Effect": "Allow",
	            "Action": "route53:ChangeResourceRecordSets",
	            "Resource": "arn:aws:route53:::hostedzone/HOSTEDZONE"
	        }
	    ]
	}
```
4. Create an Access Key/Secret key pair and add to AWS CLI profile.
5. Set up a cron job to update Route53, recommend running every 24 hours: run the command - `crontab -e` 

	Example: 12am every day - `0 0 * * * /bin/bash /home/USER/dynamic_dns_route53.sh`
6. Add hosted zone and record set to the `dynamic_dns_route53.sh` script lines 8 and 11 from Route53.
7. Run the command to verify that it works using AWS Logs.
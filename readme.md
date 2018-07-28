# AWS SNS to CloudWatch Logs Lambda Function - Terraform Module

Terraform Module to provision a Lambda Function that routes SNS messages to CloudWatch Logs.

## Features

Lambda Function forwards subject & body text of SNS messages to CloudWatch Log Group/Stream.

- Create Lambda function, IAM Permissions, Triggers, and Subscriptions
- Create or use existing SNS Topic, CloudWatch Log Group and Log Group Stream
- Options:
  - Create CloudWatch Event to prevent Function hibernation
  - Set Log Group retention period

## Usage

``` ruby
module "sns_gw" {
  source            = "git::https://github.com/robertpeteuil/terraform-aws-sns-to-cloudwatch-logs-lambda?ref=tags/0.1.0"
  aws_region        = "us-west-2"
  sns_topic_name    = "logging"
  log_group_name    = "project"
  log_stream_name   = "snslogs"
}
```

> NOTE: Make sure you are using [version pinning](https://www.terraform.io/docs/modules/usage.html#module-versions) to avoid unexpected changes when the module is updated.

## Required Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws_region | Region where AWS resources are located | string | - | yes |
| sns_topic_name | Name of SNS Topic to be logged by Gateway | string | - | yes |
| log_group_name | Name of CloudWatch Log Group | string | - | yes |
| log_stream_name | Name of CloudWatch Log Stream | string | - | yes |

## Optional Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| create_sns_topic | Determines if new SNS topic is created | string | `true` | no |
| create_log_group | Determines if new log group is created | string | `true` | no |
| create_log_stream | Determines if new log stream is created | string | `true` | no |
| log_group_retention_days | Number of days to retain log group data | string | 0 (forever) | no |
| lambda_func_name | Name to assign to Lambda Function | string | `SNStoCloudWatchLogs` | no |
| lambda_description | Description to assign to the Lambda Function | string | `Route SNS messages to CloudWatch Logs` | no |
| lambda_publish_func | Determines if Lambda Function is published | string | `false` | no |
| create_warmer_event | Determines if CloudWatch trigger event created | string | `false` | no |
| lambda_timeout | Seconds the function can run before timing out | string | `3` | no |
| lambda_mem_size | RAM assigned to the function (in MB) | string | `128` | no |


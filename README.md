# terraform-aws-sns-to-cloudwatch-logs-lambda

[![Latest Release](https://img.shields.io/github/release/robertpeteuil/terraform-aws-sns-to-cloudwatch-logs-lambda.svg)](https://github.com/robertpeteuil/terraform-aws-sns-to-cloudwatch-logs-lambda) [![license](https://img.shields.io/github/license/robertpeteuil/terraform-aws-sns-to-cloudwatch-logs-lambda.svg?colorB=2067b8)](https://github.com/robertpeteuil/terraform-aws-sns-to-cloudwatch-logs-lambda)

`terraform-aws-sns-to-cloudwatch-logs-lambda` is a Terraform module to provision a Lambda Function which routes SNS messages to CloudWatch Logs

- Terraform versions >= 0.12, use module `version >= "3.0.0"`
  - If using `var.aws_region` to specify deployment region use `version = "2.0.1"` or switch to provider aliases and explicit provider passing
- Terraform versions <= 0.11, use module `version = "1.0.1"`

## Terraform Module Features

This Module allows simple and rapid deployment

- Creates Lambda function, Lambda Layer, IAM Policies, Triggers, and Subscriptions
- Creates (or use existing) SNS Topic, CloudWatch Log Group and Log Group Stream
- Options:
  - Create CloudWatch Event to prevent Function hibernation
  - Set Log Group retention period
- Python function editable in repository and in Lambda UI
  - Python dependencies packages in Lambda Layers zip
- Optionally create custom Lambda Layer zip using [build-lambda-layer-python](https://github.com/robertpeteuil/build-lambda-layer-python)
  - Enables adding/changing dependencies
  - Enables compiling for different version of Python
- New behavior in `3.0.0` - inherits `region` from calling module's AWS Provider for resource creation/discovery.
  - Deploy to alternate regions via provider aliases and [expicit provider passing](https://www.terraform.io/docs/configuration/modules.html#passing-providers-explicitly)

## SNS to CloudWatch Logs Features

This Lambda Function forwards subject & body of SNS messages to CloudWatch Log Group Stream

- Enhances the value of CloudWatch Logs by enabling easy entry creation from any service, function and script that can send SNS notifications
- Enables cloud-init, bootstraps and functions to easily write log entries to a centralized CloudWatch Log
- Simplifies troubleshooting of solutions with decentralized logic
  - scripts and functions spread across instances, Lambda and services
- Easily add instrumentation to scripts: `aws sns publish --topic-arn $TOPIC_ARN --message $LOG_ENTRY`
  - Use with IAM instance policy requires `--region $AWS_REGION` parameter

## Usage

``` ruby
module "sns_logger" {
  source            = "robertpeteuil/sns-to-cloudwatch-logs-lambda/aws"
  version           = "3.0.0"     # Use with Terraform >= 0.13
  # version           = "2.0.1"   # Use with Terraform ~ 0.12.x
  #   last version with var.aws_region and provider in module
  # version           = "1.0.1"   # Latest version for Terraform <= 0.11

  sns_topic_name    = "projectx-logging"
  log_group_name    = "projectx"
  log_stream_name   = "script-logs"
}
```

> NOTE: Make sure you are using [version pinning](https://www.terraform.io/docs/modules/usage.html#module-versions) to avoid unexpected changes when the module is updated.

## Required Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| sns_topic_name | Name of SNS Topic to be logged by Gateway | string | - | yes |
| log_group_name | Name of CloudWatch Log Group | string | - | yes |
| log_stream_name | Name of CloudWatch Log Stream | string | - | yes |

## Optional Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| create_sns_topic | Create new SNS topic | string | `true` | no |
| create_log_group | Create new log group | string | `true` | no |
| create_log_stream | Create new log stream | string | `true` | no |
| log_group_retention_days | Log Group retention (days) | string | `0` (forever) | no |
| lambda_func_name | Name for Lambda Function | string | dynamically calculated | no |
| lambda_description | Lambda Function Description | string | `Route SNS messages to CloudWatch Logs` | no |
| lambda_tags | Mapping of Tags to assign to Lambda function | map | `{}` | no |
| lambda_publish_func | Publish Lambda Function | string | `false` | no |
| lambda_runtime | Lambda runtime for Function | string | `python3.6` | no |
| lambda_timeout | Function time-out (seconds) | string | `3` | no |
| lambda_mem_size | Function RAM assigned (MB) | string | `128` | no |
| create_warmer_event | Create CloudWatch trigger event to prevent hibernation | string | `false` | no |

terraform-aws-sns-to-cloudwatch-logs-lambda Changelog
=====================================================

All notable changes to this project will be documented in this file.

This project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).


## Unreleased

- Make variable `lambda_func_name` fully control the name of the Lambda
  function.

## [3.0.1] - 2020-08-08

- Clarification on changes for Terraform 0.13

## [3.0.0] - 2020-08-08

**Breaking Change**

- removed `provider` block from module to enable Terraform 0.13 module features
  - required to allow use of new modules arguments `for_each`, `count`, and `depends_on`
  - `var.aws_region` removed as only used in provider block

Enhancements

- add `required_providers` section to `terraform` block, specifies min ver for aws provider

Bug Fix

- fix error that could occur if `create_warmer_event` set to `false`

## [2.0.1] - 2019-06-19

- add Terraform 0.11/0.12 version compatibility info to README.md

## [2.0.0] - 2019-05-27

- update for HCL2 in Terraform versions > 0.12
- constrain AWS provider for terraform 0.12 version >= 2.12

## [1.0.1] - 2019-04-12

- constrain AWS provider to versions >= 2.0
  - necessary due to [attribute values swap](https://www.terraform.io/docs/providers/aws/guides/version-2-upgrade.html#arn-and-layer_arn-attribute-value-swap) in versions >= 2.0

## [1.0.0] - 2019-03-30

- Moved all Python dependencies to Lambda Layers
- Python function editable in repository and in Lambda UI
- Default Python version switched to 3.6
- Add optional dynamically calculated function name based on topic and Cloudwatch Group/Stream
- Optionally create custom Lambda Layer zip using [build-lambda-layer-python](https://github.com/robertpeteuil/build-lambda-layer-python)
  - Enables adding/changing dependencies
  - Enables compiling for different version of Python
- Add new variable `lambda_runtime`

## [0.2.6] - 2018-10-14

Add ability to assign tags to created lambda function using new map variable `lambda_tags`

## [0.2.5] - 2018-10-09

Comment Cleanup

## [0.2.4] - 2018-08-20

Update README

## [0.2.3] - 2018-08-01

Update README

## [0.2.2] - 2018-08-01

Update README

## [0.2.1] - 2018-07-29

Added additional outputs:

- `lambda_version` - Latest published version of Lambda Function
- `lambda_last_modified` - The date the Lambda Function was last modified

## [0.2.0] - 2018-07-28

Update README

## [0.1.3] - 2018-07-28

Add additional outputs

## [0.1.2] - 2018-07-28

Minor Edits

## [0.1.1] - 2018-07-28

Adjust outputs

## [0.1.0] - 2018-07-28

Initial Release

[2.0.0]: https://github.com/robertpeteuil/terraform-aws-sns-to-cloudwatch-logs-lambda/compare/1.0.1...2.0.0
[1.0.1]: https://github.com/robertpeteuil/terraform-aws-sns-to-cloudwatch-logs-lambda/compare/1.0.0...1.0.1
[1.0.0]: https://github.com/robertpeteuil/terraform-aws-sns-to-cloudwatch-logs-lambda/compare/0.2.6...1.0.0
[0.2.6]: https://github.com/robertpeteuil/terraform-aws-sns-to-cloudwatch-logs-lambda/compare/0.2.5...0.2.6
[0.2.5]: https://github.com/robertpeteuil/terraform-aws-sns-to-cloudwatch-logs-lambda/compare/0.2.4...0.2.5
[0.2.4]: https://github.com/robertpeteuil/terraform-aws-sns-to-cloudwatch-logs-lambda/compare/0.2.3...0.2.4
[0.2.3]: https://github.com/robertpeteuil/terraform-aws-sns-to-cloudwatch-logs-lambda/compare/0.2.2...0.2.3
[0.2.2]: https://github.com/robertpeteuil/terraform-aws-sns-to-cloudwatch-logs-lambda/compare/0.2.1...0.2.2
[0.2.1]: https://github.com/robertpeteuil/terraform-aws-sns-to-cloudwatch-logs-lambda/compare/0.2.0...0.2.1
[0.2.0]: https://github.com/robertpeteuil/terraform-aws-sns-to-cloudwatch-logs-lambda/compare/0.1.3...0.2.0
[0.1.3]: https://github.com/robertpeteuil/terraform-aws-sns-to-cloudwatch-logs-lambda/compare/0.1.2...0.1.3
[0.1.2]: https://github.com/robertpeteuil/terraform-aws-sns-to-cloudwatch-logs-lambda/compare/0.1.1...0.1.2
[0.1.1]: https://github.com/robertpeteuil/terraform-aws-sns-to-cloudwatch-logs-lambda/compare/0.1.0...0.1.1
[0.1.0]: https://github.com/robertpeteuil/terraform-aws-sns-to-cloudwatch-logs-lambda/tree/0.1.0

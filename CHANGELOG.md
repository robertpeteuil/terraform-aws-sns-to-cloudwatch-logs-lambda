# terraform-aws-sns-to-cloudwatch-logs-lambda Changelog

All notable changes to this project will be documented in this file.

This project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2019-03-30

- Moved all Python dependancies to Lambda Layers
- Python function editable in repository and in Lambda UI
- Default Python version switched to 3.6
- Optionally create custom Lambda Layer zip using [build-lambda-layer-python submodule](https://github.com/robertpeteuil/build-lambda-layer-python)
  - Enables adding/changing dependancies
  - Enables compiling for different version of Python
- Implement Lambda Layers to hold all base python dependancies
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

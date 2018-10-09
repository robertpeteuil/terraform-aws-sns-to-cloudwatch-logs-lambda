# -----------------------------------------------------------------
# AWS SNS TO CLOUDWATCH LOGS LAMBDA GATEWAY
# -----------------------------------------------------------------

terraform {
  required_version = "~> 0.11.7"
}

# -----------------------------------------------------------------
# CREATE LAMBDA FUNCTION - SNS TO CLOUDWATCH LOGS GATEWAY 
#   environment variables used for the 'log_group' and 'log_stream'
#   function published if 'lambda_publish_func' set
# -----------------------------------------------------------------

resource "aws_lambda_function" "sns_cloudwatchlog" {
  function_name = "${var.lambda_func_name}"
  description   = "${var.lambda_description}"

  filename         = "${path.module}/source.zip"
  source_code_hash = "${base64sha256(file("${path.module}/source.zip"))}"

  publish = "${var.lambda_publish_func ? 1 : 0}"
  role    = "${aws_iam_role.lambda_cloudwatch_logs.arn}"

  runtime     = "python2.7"
  handler     = "lambda_function.lambda_handler"
  timeout     = "${var.lambda_timeout}"
  memory_size = "${var.lambda_mem_size}"

  environment {
    variables = {
      log_group  = "${var.log_group_name}"
      log_stream = "${var.log_stream_name}"
    }
  }
}

# -----------------------------------------------------------------
# SNS TOPIC
#   create new topic (if create_sns_topic set), else use existing topic
#   arn referenced by "lambda_permssion" and "aws_sns_topic_subscription" 
# -----------------------------------------------------------------

# create if specified
resource "aws_sns_topic" "sns_log_topic" {
  count = "${var.create_sns_topic ? 1 : 0}"
  name  = "${var.sns_topic_name}"
}

# retrieve topic if not created, arn referenced
data "aws_sns_topic" "sns_log_topic" {
  count = "${var.create_sns_topic ? 0 : 1}"
  name  = "${var.sns_topic_name}"
}

# -----------------------------------------------------------------
# CLOUDWATCH LOG GROUP
#   create new log_group (if create_log_group set)
# -----------------------------------------------------------------

resource "aws_cloudwatch_log_group" "sns_logged_item_group" {
  count             = "${var.create_log_group ? 1 : 0}"
  name              = "${var.log_group_name}"
  retention_in_days = "${var.log_group_retention_days}"
}

# retrieve log group if not created, arn included in outputs
data "aws_cloudwatch_log_group" "sns_logged_item_group" {
  count = "${var.create_log_group ? 0 : 1}"
  name  = "${var.log_group_name}"
}

# -----------------------------------------------------------------
# CLOUDWATCH LOG STREAM
#   created new log stream (if create_log_stream set)
# -----------------------------------------------------------------

# create stream in log_group previously created or specified
resource "aws_cloudwatch_log_stream" "sns_logged_item_stream" {
  count          = "${var.create_log_stream ? 1 : 0}"
  name           = "${var.log_stream_name}"
  log_group_name = "${var.create_log_group ? join("", aws_cloudwatch_log_group.sns_logged_item_group.*.name) : var.log_group_name}"
}

# -----------------------------------------------------------------
# SUBSCRIBE LAMBDA FUNCTION TO SNS TOPIC
# -----------------------------------------------------------------

resource "aws_sns_topic_subscription" "lambda" {
  topic_arn = "${var.create_sns_topic ? join("", aws_sns_topic.sns_log_topic.*.arn) : join("", data.aws_sns_topic.sns_log_topic.*.arn)}"
  protocol  = "lambda"
  endpoint  = "${var.lambda_publish_func ? aws_lambda_function.sns_cloudwatchlog.qualified_arn : aws_lambda_function.sns_cloudwatchlog.arn}"
}

# -----------------------------------------------------------------
# ENABLE SNS TOPIC AS LAMBDA FUNCTION TRIGGER
#   multiple resource blockss until 'null' parameter feature in Terraform v0.12.0
# -----------------------------------------------------------------

# function published - "qualifier" set to function version
resource "aws_lambda_permission" "sns_cloudwatchlog_published" {
  count         = "${var.lambda_publish_func ? 1 : 0}"
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.sns_cloudwatchlog.function_name}"
  principal     = "sns.amazonaws.com"
  source_arn    = "${var.create_sns_topic ? join("", aws_sns_topic.sns_log_topic.*.arn) : join("", data.aws_sns_topic.sns_log_topic.*.arn)}"
  qualifier     = "${aws_lambda_function.sns_cloudwatchlog.version}"
}

# function not published - dont specify "qualifier" parameter
resource "aws_lambda_permission" "sns_cloudwatchlog" {
  count         = "${var.lambda_publish_func ? 0 : 1}"
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.sns_cloudwatchlog.function_name}"
  principal     = "sns.amazonaws.com"
  source_arn    = "${var.create_sns_topic ? join("", aws_sns_topic.sns_log_topic.*.arn) : join("", data.aws_sns_topic.sns_log_topic.*.arn)}"
}

# -------------------------------------------------------------------------------------
# CREATE IAM ROLE AND POLICIES FOR LAMBDA FUNCTION
# -------------------------------------------------------------------------------------

# Create IAM role
resource "aws_iam_role" "lambda_cloudwatch_logs" {
  name               = "lambda_${lower(var.lambda_func_name)}"
  assume_role_policy = "${data.aws_iam_policy_document.lambda_cloudwatch_logs.json}"
}

# Add base Lambda Execution policy
resource "aws_iam_role_policy" "lambda_cloudwatch_logs_polcy" {
  name   = "lambda_${lower(var.lambda_func_name)}_policy"
  role   = "${aws_iam_role.lambda_cloudwatch_logs.id}"
  policy = "${data.aws_iam_policy_document.lambda_cloudwatch_logs_policy.json}"
}

# JSON POLICY - assume role
data "aws_iam_policy_document" "lambda_cloudwatch_logs" {
  statement {
    actions = ["sts:AssumeRole"]

    principals = {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

# JSON POLICY - base Lambda Execution policy
data "aws_iam_policy_document" "lambda_cloudwatch_logs_policy" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "logs:PutLogEvents",
    ]

    resources = ["*"]
  }
}

# -----------------------------------------------------------------
# CREATE CLOUDWATCH EVENT TO PREVENT LAMBDA FUNCTION SUSPENSION
# -----------------------------------------------------------------

# create cloudwatch event to run every 15 minutes
resource "aws_cloudwatch_event_rule" "warmer" {
  count = "${var.create_warmer_event ? 1 : 0}"

  name                = "sns_logger_warmer"
  description         = "Keeps ${var.lambda_func_name} Warm"
  schedule_expression = "rate(15 minutes)"
}

# set event target as sns_to_cloudwatch_logs lambda function 
resource "aws_cloudwatch_event_target" "warmer" {
  count = "${var.create_warmer_event ? 1 : 0}"

  rule      = "${aws_cloudwatch_event_rule.warmer.name}"
  target_id = "Lambda"
  arn       = "${var.lambda_publish_func ? aws_lambda_function.sns_cloudwatchlog.qualified_arn : aws_lambda_function.sns_cloudwatchlog.arn}"

  input = <<JSON
{
	"Records": [{
		"EventSource": "aws:events"
	}]
}
JSON
}

# -----------------------------------------------------------------
# ENABLE CLOUDWATCH EVENT AS LAMBDA FUNCTION TRIGGER
#   multiple resource blockss until 'null' parameter feature in Terraform v0.12.0
# -----------------------------------------------------------------

# function published - "qualifier" set to function version
resource "aws_lambda_permission" "warmer_published" {
  count = "${var.create_warmer_event ? var.lambda_publish_func ? 1 : 0 : 0}"

  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.sns_cloudwatchlog.function_name}"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.warmer.arn}"
  qualifier     = "${aws_lambda_function.sns_cloudwatchlog.version}"
}

# function not published - dont specify "qualifier" parameter
resource "aws_lambda_permission" "warmer" {
  count = "${var.create_warmer_event ? var.lambda_publish_func ? 0 : 1 : 0}"

  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.sns_cloudwatchlog.function_name}"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.warmer.arn}"
}

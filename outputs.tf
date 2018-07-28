# -------------------------------------------------------------------------------------------------------------
# AWS SNS TO CLOUDWATCH LOGS LAMBDA GATEWAY - OUTPUTS
# -------------------------------------------------------------------------------------------------------------

output "lambda_func_name" {
  description = "Name assigned to the Lambda Function."
  value       = "${var.lambda_func_name}"
}

output "lambda_func_arn" {
  description = "ARN of created Lambda Function."
  value       = "${aws_lambda_function.sns_cloudwatchlog.arn}"
}

output "lambda_endpoint" {
  description = "Endpoint of created Lambda Function."
  value       = "${var.lambda_publish_func ? aws_lambda_function.sns_cloudwatchlog.qualified_arn  : aws_lambda_function.sns_cloudwatchlog.arn}"
}

output "iam_role_id_lambda" {
  description = "Lambda IAM Role ID."
  value       = "${aws_iam_role.lambda_cloudwatch_logs.id}"
}

output "iam_role_arn_lambda" {
  description = "Lambda IAM Role ID."
  value       = "${aws_iam_role.lambda_cloudwatch_logs.arn}"
}

output "sns_topic_name" {
  description = "Name of SNS Topic logging to CloudWatch Log."
  value       = "${var.sns_topic_name}"
}

output "sns_topic_arn" {
  description = "ARN of SNS Topic logging to CloudWatch Log."
  value       = "${var.create_sns_topic ? join("", aws_sns_topic.sns_log_topic.*.arn) : join("", data.aws_sns_topic.sns_log_topic.*.arn)}"
}

output "log_group_name" {
  description = "Name of CloudWatch Log Group."
  value       = "${var.log_group_name}"
}

output "log_stream_name" {
  description = "Name of CloudWatch Log Stream."
  value       = "${var.log_stream_name}"
}

output "cloudwatch_event_rule_arn" {
  description = "ARN of CloudWatch Trigger Event created to prevent hibernation."
  value       = "${join("", aws_cloudwatch_event_rule.warmer.*.arn)}"
}

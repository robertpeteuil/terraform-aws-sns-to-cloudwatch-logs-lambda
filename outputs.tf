# ----------------------------------------------------------------
# AWS SNS TO CLOUDWATCH LOGS LAMBDA GATEWAY - OUTPUTS
# ----------------------------------------------------------------

output "lambda_name" {
  description = "Name assigned to Lambda Function."
  value       = var.lambda_func_name
}

output "lambda_arn" {
  description = "ARN of created Lambda Function."
  value       = var.lambda_publish_func ? aws_lambda_function.sns_cloudwatchlog.qualified_arn : aws_lambda_function.sns_cloudwatchlog.arn
}

output "lambda_version" {
  description = "Latest published version of Lambda Function."
  value       = aws_lambda_function.sns_cloudwatchlog.version
}

output "lambda_last_modified" {
  description = "The date Lambda Function was last modified."
  value       = aws_lambda_function.sns_cloudwatchlog.last_modified
}

output "lambda_iam_role_id" {
  description = "Lambda IAM Role ID."
  value       = aws_iam_role.lambda_cloudwatch_logs.id
}

output "lambda_iam_role_arn" {
  description = "Lambda IAM Role ARN."
  value       = aws_iam_role.lambda_cloudwatch_logs.arn
}

output "sns_topic_name" {
  description = "Name of SNS Topic logging to CloudWatch Log."
  value       = var.sns_topic_name
}

output "sns_topic_arn" {
  description = "ARN of SNS Topic logging to CloudWatch Log."
  value       = var.create_sns_topic ? aws_sns_topic.sns_log_topic[0].arn : data.aws_sns_topic.sns_log_topic[0].arn
}

output "log_group_name" {
  description = "Name of CloudWatch Log Group."
  value       = var.log_group_name
}

output "log_group_arn" {
  description = "ARN of CloudWatch Log Group."
  value       = var.create_log_group ? aws_cloudwatch_log_group.sns_logged_item_group[0].arn : data.aws_cloudwatch_log_group.sns_logged_item_group[0].arn
}

output "log_stream_name" {
  description = "Name of CloudWatch Log Stream."
  value       = var.log_stream_name
}

output "log_stream_arn" {
  description = "ARN of CloudWatch Log Stream."
  value       = var.create_sns_topic ? aws_sns_topic.sns_log_topic[0].arn : data.aws_sns_topic.sns_log_topic[0].arn
}

output "cloudwatch_event_rule_arn" {
  description = "ARN of CloudWatch Trigger Event created to prevent hibernation."
  value       = var.create_warmer_event ? aws_cloudwatch_event_rule.warmer[0].arn : ""
}


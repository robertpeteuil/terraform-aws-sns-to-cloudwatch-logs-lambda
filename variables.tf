# -----------------------------------------------------------------
# REQUIRED VARIABLES WITHOUT DEFAULT VALUES
# -----------------------------------------------------------------

variable aws_region {
  type        = "string"
  description = "Region where AWS resources will be created."
}

variable sns_topic_name {
  type        = "string"
  description = "Name of SNS Topic logging to CloudWatch Log."
}

variable log_group_name {
  type        = "string"
  description = "Name of CloudWatch Log Group created or used (if previously created)."
}

variable log_stream_name {
  type        = "string"
  description = "Name of CloudWatch Log Stream created or used (if previously created).  If using an existing stream it must exist in the Log group specified in 'log_group_name'."
}

# -----------------------------------------------------------------
# VARIABLES DEFINITIONS WITH DEFAULT VALUES
# -----------------------------------------------------------------

# SNS TOPIC, LOG GROUP, LOG STREAM

variable create_sns_topic {
  default     = true
  description = "Boolean flag that determines if SNS topic, 'sns_topic_name' is created. If 'false' it uses an existing topic of that name."
}

variable create_log_group {
  default     = true
  description = "Boolean flag that determines if log group, 'log_group_name' is created.  If 'false' it uses an existing group of that name."
}

variable create_log_stream {
  default     = true
  description = "Boolean flag that determines if log stream, 'log_stream_name' is created. If 'false' it uses an existing stream of that name."
}

variable log_group_retention_days {
  default     = 0
  description = "Number of days to retain data in the log group (0 = always retain)."
}

# LAMBDA FUNCTION

variable lambda_func_name {
  type        = "string"
  default     = "SNStoCloudWatchLogs"
  description = "Name to assign to Lambda Function."
}

variable lambda_description {
  type        = "string"
  default     = ""
  description = "Description to assign to Lambda Function."
}

variable lambda_publish_func {
  default     = false
  description = "Boolean flag that determines if Lambda function is published as a version."
}

variable create_warmer_event {
  default     = false
  description = "Boolean flag that determines if a CloudWatch Trigger event is created to prevent Lambda function from suspending."
}

variable lambda_timeout {
  default     = 3
  description = "Number of seconds that the function can run before timing out. The AWS default is 3s and the maximum runtime is 5m"
}

variable lambda_mem_size {
  default     = 128
  description = "Amount of RAM (in MB) assigned to the function. The default (and minimum) is 128MB, and the maximum is 3008MB."
}

variable lambda_runtime {
  type        = "string"
  default     = "python3.6"
  description = "Lambda runtime to use for the function."
}

variable "lambda_tags" {
  description = "A mapping of tags to assign to Lambda Function."
  default     = {}
}

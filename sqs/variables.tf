variable "name" {
  type        = string
  description = "The Lambda function language runtime"
}

variable "deadletter_queue" {
  type        = bool
  description = "If the SQS queue requires a deadletter queue"
  default     = false
}

variable "region" {
  description = "Default region of your resources"
  type        = string
}

variable "account_id" {
  description = "The ID of the default AWS account"
  type        = string
}

variable "allowed_services" {
  type        = list(string)
  description = "The services that are allowed to send messages to this SQS queue"
  default     = []
}

variable "fanout" {
  type        = bool
  description = "If it should use fanout pattern with SNS"
  default     = false
}

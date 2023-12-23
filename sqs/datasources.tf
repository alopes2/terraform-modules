locals {
  allowed_service = var.fanout ? concat([aws_sns_topic.topic.arn], var.allowed_services) : var.allowed_services
}

data "aws_iam_policy_document" "sqs-queue-policy" {
  policy_id = "arn:aws:sqs:${var.region}:${var.account_id}:${var.name}/SQSDefaultPolicy"

  statement {
    sid    = "${var.name}-allow-send-messages"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["*"]
    }

    actions = [
      "SQS:SendMessage",
    ]

    resources = [
      "arn:aws:sqs:${var.region}:${var.account_id}:${var.name}",
    ]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"

      values = local.allowed_service
    }
  }
}

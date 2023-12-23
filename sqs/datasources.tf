data "aws_iam_policy_document" "sqs-queue-policy" {
  policy_id = "arn:aws:sqs:${var.region}:${var.account_id}:${var.queue_name}/SQSDefaultPolicy"

  statement {
    sid    = "${var.queue_name}-allow-send-messages"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["*"]
    }

    actions = [
      "SQS:SendMessage",
    ]

    resources = [
      "arn:aws:sqs:${var.region}:${var.account_id}:${var.queue_name}",
    ]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"

      values = var.allowed_services
    }
  }
}

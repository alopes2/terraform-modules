resource "aws_sqs_queue" "queue" {
  name   = "${var.name}-queue"
  policy = data.aws_iam_policy_document.sqs-queue-policy.json
}

resource "aws_sqs_queue" "deadletter" {
  count = var.deadletter_queue ? 1 : 0
  name  = "${var.name}-queue-dlq"
  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = [aws_sqs_queue.queue.arn]
  })
}

resource "aws_sns_topic" "topic" {
  count = var.fanout ? 1 : 0
  name  = "${var.name}-topic"
}

resource "aws_sns_topic_subscription" "topic_subscription" {
  count                = var.fanout ? 1 : 0
  topic_arn            = aws_sns_topic.topic[0].arn
  protocol             = "sqs"
  endpoint             = aws_sqs_queue.queue.arn
  raw_message_delivery = true
}

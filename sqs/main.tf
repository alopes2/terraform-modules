resource "aws_sqs_queue" "queue" {
  name = "${var.queue_name}-queue"
}

resource "aws_sqs_queue" "deadletter" {
  count = var.deadletter_queue ? 1 : 0
  name  = "${var.queue_name}-queue-dlq"
  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = [aws_sqs_queue.aws_sqs_queue.arn]
  })
}

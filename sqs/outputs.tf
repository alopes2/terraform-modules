output "queue_arn" {
  value = aws_sqs_queue.queue.arn
}

output "queue_name" {
  value = aws_sqs_queue.queue.name
}

output "dlq_arn" {
  value = var.deadletter_queue ? aws_sqs_queue.deadletter[0].arn : null
}

output "dlq_name" {
  value = var.deadletter_queue ? aws_sqs_queue.deadletter[0].name : null
}

output "topic_arn" {
  value = var.fanout ? aws_sns_topic.topic[0].arn : null
}

output "topic_name" {
  value = var.fanout ? aws_sns_topic.topic[0].name : null
}

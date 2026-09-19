
output "load_balancer_dns" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.web.dns_name
}

output "autoscaling_group_name" {
  description = "Auto Scaling Group name"
  value       = aws_autoscaling_group.web.name
}

output "target_group_arn" {
  description = "Target Group ARN"
  value       = aws_lb_target_group.web.arn
}

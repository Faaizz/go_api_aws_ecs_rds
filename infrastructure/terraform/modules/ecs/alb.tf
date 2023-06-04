resource "aws_lb" "this" {
  name_prefix        = "ecs"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.alb_security_groups
  subnets            = var.alb_subnets
}

resource "aws_lb_target_group" "this" {
  port        = local.ports.hostPort
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = module.vpc.vpc_id

  health_check {
    path     = "/healthz"
    port     = local.ports.hostPort
    protocol = "HTTP"
  }
}

resource "aws_lb_listener" "backend" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

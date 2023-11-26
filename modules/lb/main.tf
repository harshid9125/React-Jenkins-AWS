# ------------------ Application load balancer -------------------------------->

resource "aws_lb" "application_load_balancer" {
  name               = "test-l"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_security_group_id]
  subnets            = [var.public_subnet_az1_id, var.public_subnet_az2_id]

  enable_deletion_protection = false

  tags = {
    Environment = "Ec2-1"
  }
}

# ------------------ lb - Target - Group -------------------------------->
resource "aws_lb_target_group" "alb_target" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

# ----------------------- lb listeners --------------------------------------> 
resource "aws_lb_listener" "ec2_listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
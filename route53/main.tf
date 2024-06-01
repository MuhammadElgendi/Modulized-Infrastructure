# resource "aws_route53_zone" "public_zone" {
#   name = var.domain_name
# }

# resource "aws_route53_record" "webapp" {
#   zone_id = aws_route53_zone.public_zone.zone_id
#   name    = "www.${var.domain_name}"
#   type    = "A"
#   alias {
#     name                   = aws_lb.web_app_lb.dns_name
#     zone_id                = aws_lb.web_app_lb.zone_id
#     evaluate_target_health = true
#   }
# }


# ###########  THE LOADBLANCER #########

# resource "aws_lb" "web_app_lb" {
#   name               = "web-app-lb"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.web_app_sg.id]
#   subnets            = [aws_subnet.public.id]
# }

# resource "aws_lb_target_group" "web_app_tg" {
#   name     = "web-app-tg"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = var.vpc_id

#   health_check {
#     path                = "/"
#     interval            = 30
#     timeout             = 5
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#     matcher             = "200"
#   }
# }

# resource "aws_lb_listener" "http" {
#   load_balancer_arn = aws_lb.web_app_lb.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type = "forward"

#     target_group_arn = aws_lb_target_group.web_app_tg.arn
#   }
# }

# resource "aws_lb_target_group_attachment" "web_app_attachment" {
#   target_group_arn = aws_lb_target_group.web_app_tg.arn
#   target_id        = var.instance_id 
#   port             = 80
# }




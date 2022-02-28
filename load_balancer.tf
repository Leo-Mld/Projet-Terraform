module "elb_http" {
  source  = "terraform-aws-modules/elb/aws"
  version = "~> 3.0.0"

  name            = "elb-example"
  subnets         = [aws_subnet.public-subnet.id]
  security_groups = [aws_security_group.allow_http.id]

  listener = [
    {
      instance_port     = 80
      instance_protocol = "http"
      lb_port           = 80
      lb_protocol       = "http"
    },
    # {
    #   instance_port     = 8080
    #   instance_protocol = "http"
    #   lb_port           = 8080
    #   lb_protocol       = "http"
    #   ssl_certificate_id = "arn:aws:acm:eu-west-1:235367859451:certificate/6c270328-2cd5-4b2d-8dfd-ae8d0004ad31"
    # },
  ]

  health_check = {
    target              = "HTTP:80/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }

  #   access_logs = {
  #     bucket = "my-access-logs-bucket"
  #   }

  // ELB attachments
  number_of_instances = var.count_instances
  instances           = aws_instance.web[*].id

  tags = {
    Owner       = "user"
    Environment = "dev"
  }

  #METADATA
  depends_on = [aws_internet_gateway.gw]
}


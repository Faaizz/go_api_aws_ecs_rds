data "aws_region" "current" {}

locals {
  project_name = "go-api"

  task = {
    name = "backend"
    exec_role = {
      name = "backend-ecs-task-execution"
    }
    role = {
      name = "backend-ecs-task"
    }
    container = {
      name = "backend"
      port_mappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
        }
      ]
    }
    web_container = {
      name = "web"
      port_mappings = [
        {
          containerPort = var.web_container_port
          hostPort      = var.web_container_port
        }
      ]
    }
  }
}

resource "aws_ecs_cluster" "this" {
  name = local.project_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "this" {
  family = local.project_name
  container_definitions = jsonencode([
    {
      name         = local.task.container.name
      image        = var.container_image_uri
      essential    = true
      portMappings = local.task.container.port_mappings
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-create-group" : "true"
          "awslogs-group" : "awslogs-go-api"
          "awslogs-region" : data.aws_region.current.name
          "awslogs-stream-prefix" : "awslogs-go-api"
        }
      }
      cpu = 512
      environment = [
        {
          Name  = "BASIC_AUTH_USER"
          Value = var.basic_auth_user
        },
        {
          Name  = "BASIC_AUTH_PASSWORD"
          Value = var.basic_auth_password
        },
        {
          Name  = "DB_USER"
          Value = var.db_user
        },
        {
          Name  = "DB_PASSWORD"
          Value = var.db_password
        },
        {
          Name  = "DB_NAME"
          Value = var.db_name
        },
        {
          Name  = "DB_HOST"
          Value = var.db_host
        },
        {
          Name  = "DB_PORT"
          Value = var.db_port
        },
        {
          Name  = "DB_SSLMODE"
          Value = "prefer"
        },
      ]
    },
    {
      name         = local.task.web_container.name
      image        = var.web_container_image_uri
      essential    = true
      portMappings = local.task.web_container.port_mappings
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-create-group" : "true"
          "awslogs-group" : "awslogs-go-web"
          "awslogs-region" : data.aws_region.current.name
          "awslogs-stream-prefix" : "awslogs-go-web"
        }
      }
      cpu = 512
      environment = [
        {
          Name  = "BOOK_URL"
          Value = "http://localhost:${local.task.container.port_mappings[0].containerPort}/api/v1/book"
        },
      ]
    }
  ])
  task_role_arn            = aws_iam_role.task.arn
  execution_role_arn       = aws_iam_role.task_exec.arn
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  requires_compatibilities = ["FARGATE"]

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}

resource "aws_ecs_service" "this" {
  name            = local.project_name
  cluster         = aws_ecs_cluster.this.id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 2

  deployment_minimum_healthy_percent = 25
  health_check_grace_period_seconds  = 30

  network_configuration {
    subnets         = var.ecs_subnets
    security_groups = var.ecs_security_groups
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = local.task.container.name
    container_port   = var.container_port
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.web.arn
    container_name   = local.task.web_container.name
    container_port   = var.web_container_port
  }
}

resource "aws_appautoscaling_target" "this" {
  max_capacity       = 10
  min_capacity       = 2
  resource_id        = "service/${aws_ecs_cluster.this.name}/${aws_ecs_service.this.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "this" {
  name               = "scale-ecs"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.this.resource_id
  scalable_dimension = aws_appautoscaling_target.this.scalable_dimension
  service_namespace  = aws_appautoscaling_target.this.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value       = 75
    scale_in_cooldown  = 60
    scale_out_cooldown = 60
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
  }
}

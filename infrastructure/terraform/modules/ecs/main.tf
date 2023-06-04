data "aws_region" "current" {}

locals {
  project_name = "go-api"

  ports = {
    containerPort = 8080
    hostPort      = 80
  }

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
          containerPort = local.ports.containerPort
          hostPort      = local.ports.hostPort
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
  family = var.task_name
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
      cpu = 992
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
          Value = "enable"
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
}

resource "aws_ecs_service" "this" {
  name            = local.project_name
  cluster         = aws_ecs_cluster.this.id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 1

  network_configuration {
    subnets         = var.ecs_subnets
    security_groups = var.ecs_security_groups
    # assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.ecs.arn
    container_name   = local.task.container.name
    container_port   = local.ports.hostPort
  }
}

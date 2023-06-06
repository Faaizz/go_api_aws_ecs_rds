module "ecs" {
  source = "../modules/ecs"

  container_image_uri     = var.container_image_uri
  container_port          = 8080
  web_container_image_uri = var.web_container_image_uri
  web_container_port      = 3000
  basic_auth_user         = var.basic_auth_user
  basic_auth_password     = var.basic_auth_password

  db_user     = data.terraform_remote_state.db.outputs.db_instance_username
  db_password = data.terraform_remote_state.db.outputs.db_instance_password
  db_name     = data.terraform_remote_state.db.outputs.db_instance_name
  db_host     = data.terraform_remote_state.db.outputs.db_instance_address
  db_port     = data.terraform_remote_state.db.outputs.db_instance_port

  vpc_id              = data.terraform_remote_state.vpc.outputs.vpc_id
  ecs_subnets         = data.terraform_remote_state.vpc.outputs.private_subnets
  ecs_security_groups = [data.terraform_remote_state.vpc.outputs.ecs_sg_id]
  alb_subnets         = data.terraform_remote_state.vpc.outputs.public_subnets
  alb_security_groups = [data.terraform_remote_state.vpc.outputs.alb_sg_id]
}

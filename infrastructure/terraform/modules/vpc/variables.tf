variable "name" {
  description = "The name of the VPC"
  type        = string
}
variable "cidr" {
  description = "The CIDR block of the VPC"
  type        = string
  default     = "10.0.0.0/16"
  validation {
    condition     = can(regex("^[0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+/[0-9]+$", var.cidr))
    error_message = "CIDR block must be in the form x.x.x.x/x"
  }
}

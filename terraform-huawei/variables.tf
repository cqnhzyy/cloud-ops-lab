variable "region" {
  description = "华为云区域"
  type        = string
  default     = "cn-south-1" # 华南-广州
}

variable "instance_name" {
  description = "ECS 实例名称"
  type        = string
  default     = "my-web-server-from-tf"
}

variable "image_id" {
  description = "镜像 ID（在 ECS 控制台查询）"
  type        = string
}

variable "flavor_id" {
  description = "规格 ID"
  type        = string
  default     = "s6.small.1"
}

variable "availability_zone" {
  description = "可用区"
  type        = string
  default     = "cn-south-1a"
}

variable "vpc_network_id" {
  description = "VPC 子网 ID"
  type        = string
}

variable "secgroup_name" {
  description = "安全组名称"
  type        = string
  default     = "my-tf-secgroup"
}

variable "ssh_allowed_cidr" {
  description = "允许 SSH 的源网段（务必收紧，不要用 0.0.0.0/0）"
  type        = string
}

variable "admin_pass" {
  description = "ECS 登录密码"
  type        = string
  sensitive   = true
}

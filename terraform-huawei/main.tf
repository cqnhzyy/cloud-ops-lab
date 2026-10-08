# 华为云 Provider 配置
terraform {
  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = "~> 1.0"
    }
  }
}

# 认证信息通过环境变量注入，不要写进代码：
#   export HW_ACCESS_KEY="..."
#   export HW_SECRET_KEY="..."
provider "huaweicloud" {
  region = var.region
}

# ---------------------------------------------------------------------------
# 安全组
# ---------------------------------------------------------------------------
resource "huaweicloud_networking_secgroup" "my_secgroup" {
  name        = var.secgroup_name
  description = "Security group created by Terraform"
}

# 只开放必要端口（最小权限原则）
resource "huaweicloud_networking_secgroup_rule" "http_ingress" {
  security_group_id = huaweicloud_networking_secgroup.my_secgroup.id
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
}

resource "huaweicloud_networking_secgroup_rule" "https_ingress" {
  security_group_id = huaweicloud_networking_secgroup.my_secgroup.id
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "0.0.0.0/0"
}

# SSH 只允许自己的办公网段，不要开 0.0.0.0/0
resource "huaweicloud_networking_secgroup_rule" "ssh_ingress" {
  security_group_id = huaweicloud_networking_secgroup.my_secgroup.id
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = var.ssh_allowed_cidr
}

# ---------------------------------------------------------------------------
# ECS 实例
# ---------------------------------------------------------------------------
resource "huaweicloud_compute_instance" "my_web_server" {
  name               = var.instance_name
  image_id           = var.image_id
  flavor_id          = var.flavor_id
  availability_zone  = var.availability_zone
  security_group_ids = [huaweicloud_networking_secgroup.my_secgroup.id]

  network {
    uuid = var.vpc_network_id
  }

  system_disk_type = "SAS"
  system_disk_size = 40

  # 密码从变量注入，禁止在代码里硬编码
  admin_pass = var.admin_pass

  # cloud-init：开机自动装好 Nginx
  user_data = <<-EOF
    #!/bin/bash
    yum install -y nginx
    systemctl start nginx
    systemctl enable nginx
  EOF
}

output "instance_ip" {
  value = huaweicloud_compute_instance.my_web_server.access_ip_v4
}

# Terraform + 华为云：ECS 自动化部署

用 Terraform 在华为云上创建一台装好 Nginx 的 ECS，含安全组最小权限配置。

## 背景

手动在控制台点来点去创建资源，效率低且无法复现。这个实验把「一台 Web 服务器 + 安全组」用代码描述出来，做到一键创建、一键销毁。

## 结构

| 文件 | 说明 |
|---|---|
| `main.tf` | Provider、安全组、安全组规则、ECS 实例、output |
| `variables.tf` | 所有可调参数 |
| `terraform.tfvars.example` | 参数模板（复制为 `terraform.tfvars` 使用） |

## 安全设计

- **密码不落代码**：`admin_pass` 通过变量注入，`terraform.tfvars` 已被 gitignore；推荐改用环境变量 `TF_VAR_admin_pass`
- **认证走环境变量**：`HW_ACCESS_KEY` / `HW_SECRET_KEY`，不写进 `.tf`
- **SSH 不开全网**：`ssh_allowed_cidr` 必须收紧到自己的网段，而不是 `0.0.0.0/0`
- **只开必要端口**：80 / 443 对公网，22 仅对指定网段

## 使用

```bash
export HW_ACCESS_KEY="你的AK"
export HW_SECRET_KEY="你的SK"

cp terraform.tfvars.example terraform.tfvars
vim terraform.tfvars          # 填入镜像 ID、子网 ID、SSH 网段

terraform init                # 下载 Provider
terraform plan                # 预览将要创建的资源
terraform apply               # 执行创建
terraform output instance_ip  # 查看分配到的公网 IP
terraform destroy             # 实验完销毁，避免计费
```

## 踩过的坑

1. **`image_id` / `vpc_network_id` 必须填真实值** —— 这两个无法默认，需要去控制台查
2. **`terraform destroy` 要记得跑** —— 否则 ECS 会一直计费
3. **安全组规则方向**：`direction = "ingress"` 是入方向，出方向默认全通

## 参考

原始学习笔记见 [study-notes](https://cqnhzyy.github.io/study-notes/) 的《"基础设施即代码"初探：我的Terraform学习笔记》。

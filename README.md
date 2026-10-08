# cloud-ops-lab

云计算运维 / SRE 方向的实验合集。每个子目录是一个可独立运行、可复现的实验。

## 目录

| 目录 | 内容 | 状态 |
|---|---|---|
| [`terraform-huawei/`](./terraform-huawei/) | 华为云 ECS + 安全组自动化部署（Terraform） | ✅ 可用 |
| [`log-cleaner/`](./log-cleaner/) | Nginx 旧日志自动清理脚本（Python） | ✅ 可用 |
| [`ansible-roles/`](./ansible-roles/) | Ansible Playbook 与 Role（RHCE 内容整理） | 🚧 待整理 |
| [`k8s-practice/`](./k8s-practice/) | K3s 集群练习 | 🚧 待补充 |

## 约定

- 每个子目录有独立 README，说明背景、用法、踩过的坑
- **凭据一律不入库**：认证走环境变量，变量文件用 `.tfvars.example` / `.env.example` 形式提供模板
- 实验类资源记得 `terraform destroy` / 释放，避免持续计费

## 许可

MIT

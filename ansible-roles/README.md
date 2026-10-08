# ansible-roles

Ansible Playbook 与 Role 练习（RHCE EX294 内容整理）。

## 计划放什么

| 类型 | 说明 |
|---|---|
| `playbooks/` | 常用 playbook：批量装包、配置下发、服务管理 |
| `roles/` | 角色化组织：如 `nginx`、`mysql`、`users` |
| `inventory/` | 主机清单（**真实 IP 与密码不要提交**，用 `hosts.example`） |
| `ansible.cfg` | 配置模板 |

## 要覆盖的 RHCE 知识点

- Inventory 与主机清单管理
- Ad-Hoc 常用模块：`command` / `copy` / `file` / `yum` / `service`
- Playbook 编写与 YAML 语法
- 变量、事实（facts）、Jinja2 模板
- Roles 角色化组织与 Galaxy
- `handlers` / `tags` / 条件与循环
- Ansible Vault 加密敏感信息

## 约定

- **密码与密钥用 Ansible Vault 加密，或走 `--ask-vault-pass`**
- `inventory/hosts` 不入库，只提交 `hosts.example`
- 每个 role 配一个简要 README

---

🚧 内容待补充。

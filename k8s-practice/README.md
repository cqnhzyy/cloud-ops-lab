# k8s-practice

K3s / Kubernetes 练习环境。

## 计划放什么

| 类型 | 说明 |
|---|---|
| `manifests/` | Deployment / Service / Ingress / ConfigMap 等 YAML |
| `k3s-install/` | K3s 单机与多节点安装脚本 |
| `troubleshooting/` | 排障记录（CrashLoopBackOff / Pending / ImagePullBackOff） |
| `helm/` | 自建 Chart 练习 |

## 想覆盖的东西

- 集群搭建（kubeadm / K3s）
- Pod 生命周期与多容器模式
- Deployment / DaemonSet / StatefulSet
- Service 三种类型与 Ingress
- ConfigMap / Secret、Volume / PV / PVC
- 探针 liveness / readiness / startup
- 调度：亲和性、污点容忍、资源请求与限制
- RBAC 与服务账号
- HPA 弹性伸缩

## 约定

- **`kubeconfig` 绝对不入库**（已在 `.gitignore` 中）
- 排障记录用「现象 → 排查 → 根因 → 解决」的四段式写
- YAML 里不要写真实密码，用 Secret + `stringData` 占位

---

🚧 内容待补充。

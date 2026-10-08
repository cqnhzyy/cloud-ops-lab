# log-cleaner：自动清理旧日志

一个几十行的 Python 脚本，把重复的手动清日志工作自动化掉。

## 由来

某次 Cloud Eye 磁盘告警显示使用率到 87%，登上去一查是 Nginx 的 `access.log` 涨太快。手动清理太麻烦，于是写了这个脚本挂到 crontab。

## 用法

```bash
# 默认：清理 /var/log/nginx/ 下 7 天前的 .log
python3 clean_old_logs.py

# 自定义目录与保留天数
python3 clean_old_logs.py --dir /path/to/logs --days 30
```

## 部署到 crontab

```cron
# 每周一凌晨 2 点自动清理
0 2 * * 1 /usr/bin/python3 /path/to/clean_old_logs.py > /dev/null 2>&1
```

## 设计取舍

- **只删 `.log`，不递归子目录** —— 避免误删
- **按 mtime 判断**，不用文件名日期 —— 更通用
- **先算后删，最后出报告** —— 释放了多少空间一目了然

## 已知局限

- 不判断文件是否被进程占用（Linux 下删除被打开的文件不会报错，但空间不会立即释放，需要重启进程）
- 没有 dry-run 模式。**生产环境首次运行建议先改成打印而不删除**
- 没有文件锁，多实例并发跑同一目录可能互相干扰

如果要做成生产可用，下一步应该加：`--dry-run` 参数、日志输出到 syslog、以及和 logrotate 的 `copytruncate` 配合。

## 参考

原始学习笔记见 [study-notes](https://cqnhzyy.github.io/study-notes/) 的《Python脚本实战：自动清理服务器日志文件》。

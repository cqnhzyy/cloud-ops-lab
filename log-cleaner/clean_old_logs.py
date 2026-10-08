#!/usr/bin/env python3
"""
自动清理旧日志文件脚本

功能：删除指定目录下超过指定天数的 .log 文件
思路：仿照 logrotate，只清理过期的归档日志，不做暴力删除
"""
import argparse
import os
import time


def clean_old_logs(directory, days):
    """
    清理指定目录中早于指定天数的 .log 文件

    :param directory: 要清理的目录路径
    :param days: 保留的天数
    """
    cutoff_time = time.time() - (days * 24 * 60 * 60)
    total_freed_space = 0
    deleted_files = []

    print(f"开始在目录 [{directory}] 中清理 {days} 天前的 .log 文件...")

    for filename in os.listdir(directory):
        if not filename.endswith(".log"):
            continue
        filepath = os.path.join(directory, filename)
        if not os.path.isfile(filepath):
            continue

        file_mtime = os.path.getmtime(filepath)
        file_size = os.path.getsize(filepath)
        if file_mtime >= cutoff_time:
            continue

        try:
            os.remove(filepath)
            total_freed_space += file_size
            deleted_files.append(filename)
            print(f"已删除: {filename} (大小: {file_size / 1024 / 1024:.2f}MB)")
        except OSError as e:
            print(f"删除文件 {filename} 时出错: {e}")

    print("\n===== 清理完成 =====")
    print(f"共删除文件: {len(deleted_files)} 个")
    print(f"共释放磁盘空间: {total_freed_space / 1024 / 1024:.2f} MB")
    if deleted_files:
        print("被删除的文件列表:")
        for f in deleted_files:
            print(f"  - {f}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="清理旧日志文件")
    parser.add_argument("--dir", type=str, default="/var/log/nginx/",
                        help="要清理的目录路径 (默认: /var/log/nginx/)")
    parser.add_argument("--days", type=int, default=7,
                        help="保留的天数 (默认: 7)")
    args = parser.parse_args()

    clean_old_logs(args.dir, args.days)

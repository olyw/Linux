#!/bin/bash
# 初始化debian脚本
# 更换镜像源为清华源
echo "更换镜像源为清华源..."
sed -i 's/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list

# 更新并升级软件包
echo "更新并升级软件包..."
apt update && apt upgrade -y

# 安装常用工具
echo "安装常用工具..."
apt install -y curl wget git vim htop

# 配置时区
echo "设置时区为 Asia/Shanghai..."
timedatectl set-timezone Asia/Shanghai

# 配置 SSH 允许 root 远程登录并启用密码验证
echo "配置 SSH登录 ..."
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config  # 启用 root 登录
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config  # 启用密码认证
systemctl restart sshd  # 重启 SSH 服务使配置生效

# 清理无用软件包
echo "清理无用软件包..."
apt autoremove -y
apt autoclean -y

# 系统重启（可选）
read -p "是否现在重启系统？(y/n): " reboot_choice
if [[ "$reboot_choice" == "y" || "$reboot_choice" == "Y" ]]; then
    reboot
fi

echo "系统初始化完成！"

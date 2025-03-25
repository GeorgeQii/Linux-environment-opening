#!/bin/bash

# 定义函数：打开 SSH 服务
open_ssh() {
    echo "正在打开 SSH 服务..."
    sudo systemctl enable ssh
    sudo systemctl start ssh
    if sudo systemctl is-active --quiet ssh; then
        echo "SSH 服务已成功启动。"
    else
        echo "启动 SSH 服务失败，请检查错误。"
    fi
}

# 定义函数：下载 AdGuard Home
download_adguard_home() {
    echo "正在下载 AdGuard Home..."
    wget -O AdGuardHome.tar.gz https://static.adguard.com/adguardhome/AdGuardHome_linux_amd64.tar.gz
    if [ $? -eq 0 ]; then
        tar -zxvf AdGuardHome.tar.gz
        rm AdGuardHome.tar.gz
        echo "AdGuard Home 已成功下载并解压。"
    else
        echo "下载 AdGuard Home 失败，请检查网络连接。"
    fi
}

# 定义函数：安装 Docker 并换源
install_docker_and_change_mirror() {
    echo "正在安装 Docker..."
    sudo apt-get update
    sudo apt-get install -y docker.io

    if [ $? -eq 0 ]; then
        echo "正在更换 Docker 镜像源..."
        sudo mkdir -p /etc/docker
        sudo tee /etc/docker/daemon.json <<-'EOF'
{
    "registry-mirrors": [
        "https://docker.1ms.run",
        "https://docker.xuanyuan.me"
    ]
}
EOF
        sudo systemctl daemon-reload
        sudo systemctl restart docker
        echo "Docker 已安装并更换了镜像源。"
    else
        echo "安装 Docker 失败，请检查错误。"
    fi
}

# 显示菜单
show_menu() {
    clear
    echo "请选择要执行的操作："
    echo "1. 打开 SSH 服务"
    echo "2. 下载 AdGuard Home"
    echo "3. 安装 Docker 并换源"
    echo "4. 退出"
    echo
    read -p "请输入选项（1-4）： " choice
    case $choice in
        1) open_ssh ;;
        2) download_adguard_home ;;
        3) install_docker_and_change_mirror ;;
        4) echo "退出脚本。"; exit 0 ;;
        *) echo "无效选项，请重新选择。"; sleep 2 ;;
    esac
}

# 主循环
while true; do
    show_menu
done

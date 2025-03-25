# Ubuntu 设置脚本

这是一个用于在 Ubuntu 系统上执行常见设置任务的交互式脚本。用户可以通过简单的菜单选择来完成以下操作：
- 打开 SSH 服务
- 下载 AdGuard Home
- 安装 Docker 并更换镜像源

## 功能特点
- **交互式菜单**：用户可以通过简单的数字选择来执行任务。
- **分步骤操作**：每个任务独立，用户可以根据需要选择执行。
- **错误提示**：每个操作都包含基本的错误检查，如果操作失败会提示用户。

## 使用方法

### 1. 下载脚本
将以下脚本保存为一个 `.sh` 文件，例如 `menu.sh`：

```bash
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
2. 赋予脚本执行权限
在终端中运行以下命令，赋予脚本执行权限：
bash
复制
chmod +x menu.sh
3. 运行脚本
在终端中运行脚本：
bash
复制
./menu.sh
4. 选择操作
根据菜单提示选择要执行的操作：
选项 1：打开 SSH 服务。
选项 2：下载 AdGuard Home。
选项 3：安装 Docker 并更换镜像源。
选项 4：退出脚本。
注意事项
权限问题：部分操作（如安装 Docker 和启动 SSH）需要管理员权限，因此可能需要输入密码。
网络连接：下载 AdGuard Home 和安装 Docker 需要良好的网络连接。
系统兼容性：此脚本适用于基于 Debian 的系统（如 Ubuntu）。其他系统可能需要调整脚本内容。
作者
GeorgeQii

版本
1.0.0

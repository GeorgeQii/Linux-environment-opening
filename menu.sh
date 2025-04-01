#!/bin/bash

# 定义颜色变量
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# 打印菜单
print_menu() {
    echo "请选择要执行的操作："
    echo "1) 安装 AdGuard Home"
    echo "2) 关闭 Ubuntu DNS 解析的 53 端口占用"
    echo "3) 安装 Docker"
    echo "4) 配置 Docker 镜像站"
    echo "5) 安装网心云并自动更新"
    echo "6) 打印重要的系统信息和错误信息"
    echo "7) 配置代理"
    echo "8) 退出"
}

# 安装 AdGuard Home
install_adguardhome() {
    echo -e "${GREEN}开始安装 AdGuard Home...${NC}"
    wget --no-verbose -O - https://raw.githubusercontent.com/AdguardTeam/AdGuardHome/master/scripts/install.sh | sh -s -- -v
    echo -e "${GREEN}AdGuard Home 安装完成！${NC}"
}

# 关闭 Ubuntu DNS 解析的 53 端口占用
close_dns_port() {
    echo -e "${GREEN}关闭 Ubuntu DNS 解析的 53 端口占用...${NC}"
    sudo systemctl stop systemd-resolved
    sudo systemctl disable systemd-resolved
    sudo rm -f /etc/resolv.conf
    sudo ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf
    echo -e "${GREEN}53 端口占用已关闭！${NC}"
}

# 安装 Docker
install_docker() {
    echo -e "${GREEN}开始安装 Docker...${NC}"
    sudo curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
    echo -e "${GREEN}Docker 安装完成！${NC}"
}

# 配置 Docker 镜像站
configure_docker_mirror() {
    echo -e "${GREEN}配置 Docker 镜像站...${NC}"
    sudo bash -c 'cat <<EOF | sudo tee /etc/docker/daemon.json > /dev/null
{
    "registry-mirrors": [
        "https://docker.m.daocloud.io",
        "https://docker.1panel.live",
        "https://hub.rat.dev"
    ]
}
EOF'
    sudo service docker restart
    echo -e "${GREEN}Docker 镜像站配置完成并已重启 Docker 服务！${NC}"
}

# 安装网心云并自动更新
install_wxedge_and_update() {
    echo -e "${GREEN}开始安装网心云并设置自动更新...${NC}"
    sudo mkdir -p /wxedge_storage
    sudo docker run -d --name=wxedge --restart=always --privileged --net=host --tmpfs /run --tmpfs /tmp -v /wxedge_storage:/storage:rw images-cluster.xycloud.com/wxedge/wxedge:latest
    sudo docker run -d --name watchtower --restart always -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower --cleanup wxedge
    echo -e "${GREEN}网心云安装完成并已设置自动更新！${NC}"
}

# 打印重要的系统信息和错误信息
print_system_info() {
    echo -e "${GREEN}打印重要的系统信息和错误信息...${NC}"
    echo "系统信息："
    uname -a
    echo "磁盘使用情况："
    df -h
    echo "内存使用情况："
    free -m
    echo "错误信息："
    dmesg | grep -i error
}

# 配置代理
configure_proxy() {
    echo -e "${GREEN}配置代理...${NC}"
    read -p "请输入代理 IP 地址: " ip
    read -p "请输入代理端口: " port
    sudo bash -c "echo 'export http_proxy=http://$ip:$port/' >> /etc/environment"
    sudo bash -c "echo 'export https_proxy=https://$ip:$port/' >> /etc/environment"
    sudo bash -c "echo 'export no_proxy=localhost,127.0.0.1' >> /etc/environment"
    echo -e "${GREEN}代理配置完成！${NC}"
}

# 主程序
while true; do
    print_menu
    read -p "请输入选项（1-8）： " choice
    case $choice in
        1)
            install_adguardhome
            ;;
        2)
            close_dns_port
            ;;
        3)
            install_docker
            ;;
        4)
            configure_docker_mirror
            ;;
        5)
            install_wxedge_and_update
            ;;
        6)
            print_system_info
            ;;
        7)
            configure_proxy
            ;;
        8)
            echo -e "${GREEN}退出程序...${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}无效的选项，请重新输入！${NC}"
            ;;
    esac
done

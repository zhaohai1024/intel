# 使用 Debian 12 (Bullseye) 的 minimal 镜像作为基础
FROM debian:bullseye-slim

# 添加 i386 架构支持
RUN dpkg --add-architecture i386

# 更新 apt 包列表
RUN apt update

# 安装一系列软件包
RUN DEBIAN_FRONTEND=noninteractive apt install wine qemu-kvm *zenhei* xz-utils dbus-x11 curl firefox-esr git wget -y

# 下载 noVNC 的源代码
RUN wget https://github.com/novnc/noVNC/archive/refs/tags/v1.2.0.tar.gz

# 解压 noVNC 源代码
RUN tar -xvf v1.2.0.tar.gz

# 创建一个脚本（luo.sh）用于启动 noVNC
RUN echo 'whoami ' >> /luo.sh
RUN echo 'cd /noVNC-1.2.0' >> /luo.sh
RUN echo './utils/launch.sh --vnc localhost:5900 --listen 8900' >> /luo.sh
RUN chmod 755 /luo.sh

# 暴露容器的端口
EXPOSE 8900

# 定义容器启动时的默认命令
CMD /luo.sh

#!/bin/bash
# 设置一些环境变量
PREFIX_URL="https://downloads.immortalwrt.org/releases/23.05.3/targets"
DEVICE_PLATFORM="x86_64"
DEVICE_TARGET="x86"
DEVICE_SUBTARGET="64"
DOCKER_IMAGE_ARCH="linux/amd64"
KERNEL_VERSION=""

# 选择 ImageBuilder 的下载路径和文件名
IMAGEBUILDER_URL="$PREFIX_URL/$DEVICE_TARGET/$DEVICE_SUBTARGET/immortalwrt-imagebuilder-23.05.3-$DEVICE_TARGET-$DEVICE_SUBTARGET.Linux-x86_64.tar.zst"

# 下载 Image Builder
echo "Downloading Image Builder..."
wget -q $IMAGEBUILDER_URL

# 解压 Image Builder
echo "Extracting Image Builder..."
tar -I zstd -xf *.tar.zst

# 进入解压后的 Image Builder 目录
cd immortalwrt-imagebuilder-23.05.3-$DEVICE_TARGET-$DEVICE_SUBTARGET.Linux-x86_64

# 复制配置文件并修改
echo "Copying and modifying repositories.conf..."
cp -f ../../config/repositories.conf .
sed -i "s/DEVICE_SUBTARGET/$DEVICE_SUBTARGET/g; \
    s/DEVICE_TARGET/$DEVICE_TARGET/g; \
    s/DEVICE_PLATFORM/$DEVICE_PLATFORM/g" repositories.conf

# 复制文件目录
cp -rf ../../files .
chmod +x files/etc/rc.local

# 获取内核版本
echo "Getting Kernel Version..."
KERNEL_VERSION=$(ls packages | grep kernel | awk -F '_' '{print $2}')
echo "Kernel Version: $KERNEL_VERSION"

# 修改 distfeeds.conf
sed -i "s/DEVICE_SUBTARGET/$DEVICE_SUBTARGET/g; \
    s/DEVICE_TARGET/$DEVICE_TARGET/g; \
    s/KERNEL_VERSION/$KERNEL_VERSION/g; \
    s/DEVICE_PLATFORM/$DEVICE_PLATFORM/g" files/etc/opkg/distfeeds.conf

# 构建 Mini RootFS
echo "Building Mini RootFS..."
sed -i "/CONFIG_TARGET_ROOTFS_SQUASHFS/s/.*/# CONFIG_TARGET_ROOTFS_SQUASHFS is not set/; \
    /CONFIG_TARGET_ROOTFS_EXT4FS/s/.*/# CONFIG_TARGET_ROOTFS_EXT4FS is not set/" .config
CONFIG_MINI_PACKAGES=$(cat ../../config/mini-packages.config | tr -s "\n" " ")
make image PACKAGES="$CONFIG_MINI_PACKAGES" FILES="files"
# 测试：make image PACKAGES="luci" FILES="files"
# 将生成的 RootFS 复制回上一级目录
cp bin/targets/$DEVICE_TARGET/$DEVICE_SUBTARGET/*rootfs.tar.gz ../

# 清理工作目录
echo "Cleaning up..."
# cd ../
# rm -rf immortalwrt-imagebuilder-23.05.3-$DEVICE_TARGET-$DEVICE_SUBTARGET.Linux-x86_64

echo "Build complete! The generated RootFS is in $(pwd)."

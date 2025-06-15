## docker 运行方法

使用 docker-compose

```yml
services:
  openwrt:
    image: 14790897/openwrt:x86_64
    container_name: openwrt
    restart: always
    # privileged: true
    cap_add:
      - NET_ADMIN # 增加 NET_ADMIN 权限
      - NET_RAW
    networks:
      macvlan_net:
    command: /sbin/init

networks:
  macvlan_net:
    driver: macvlan
    driver_opts:
      parent: enp1s0 # 宿主机的网卡名称，需要使用ip link show 手动查询，保持一致
    ipam:
      config:
        - subnet: 192.168.0.0/24 # 定义容器使用的子网，需要和当前网络一致
          gateway: 192.168.0.1 # 定义网关，需要和当前网络一致
```

运行后进入 容器

```sh
docker exec -it openwrt /bin/bash
```

```sh
nano /etc/config/network
```

修改 IP 地址和路由器同一网段，网关是路由器地址
![image|369x500](https://linux.do/uploads/default/original/3X/1/b/1bc20192030fc5da0c9b652341b77f34c55b211f.png)
然后重启网络服务：

<!-- cat /etc/config/network -->

/etc/init.d/network restart

然后访问配置的 IP 地址就可以用了

参考：

https://post.smzdm.com/p/arqxqm8q/

## 自定义包和系统配置发布到自己的 dockerhub

### 1.fork 仓库

### 2.配置 action 的 secrets

设置 DOCKERHUB_USERNAME 和 DOCKERHUB_PWD 用于登录 dockerhub

### 3.自定义安装的包

修改 config\normal-packages.config，添加自己的包 (哪些可以添加? https://downloads.immortalwrt.org/releases/packages-24.10/aarch64_generic)

### 4.自定义系统配置

修改 files\etc 下面的系统文件就可以更改系统上对应的配置

### 5.编译和上传

点击 Actions，选择 workflow，Multi-Arch Images，点击 Run workflow，等待编译完成

## 代码解读

config/platform.config
举例：x86_64/x86/64/linux-amd64/amd64
解释：x86_64 是镜像的标签, x86 是 target, 64 是 subtarget, linux-amd64 是镜像构建时使用的平台, 第五个是额外的镜像标签

arm_cortex-a15_neon-vfpv4/armsr/armv7/linux-arm-v7/armv7 需要在 stable 分支构建

## 可以安装的包

来源： https://github.com/ophub/amlogic-s9xxx-openwrt/blob/main/config/imagebuilder/imagebuilder.sh#L188
acpid attr base-files bash bc blkid block-mount blockd bsdtar btrfs-progs busybox bzip2 \
 cgi-io chattr comgt comgt-ncm containerd coremark coreutils coreutils-base64 coreutils-nohup \
 coreutils-truncate curl docker docker-compose dockerd dosfstools dumpe2fs e2freefrag e2fsprogs \
 exfat-mkfs f2fs-tools f2fsck fdisk gawk getopt git gzip hostapd-common iconv iw iwinfo jq \
 jshn kmod-brcmfmac kmod-brcmutil kmod-cfg80211 kmod-mac80211 libjson-script liblucihttp \
 liblucihttp-lua losetup lsattr lsblk lscpu mkf2fs mount-utils openssl-util parted \
 perl-http-date perlbase-file perlbase-getopt perlbase-time perlbase-unicode perlbase-utf8 \
 pigz ppp ppp-mod-pppoe proto-bonding pv rename resize2fs runc tar tini ttyd tune2fs \
 uclient-fetch uhttpd uhttpd-mod-ubus unzip uqmi usb-modeswitch uuidgen wget-ssl whereis \
 which wpad-basic wwan xfs-fsck xfs-mkfs xz xz-utils ziptool zoneinfo-asia zoneinfo-core zstd \
 \
 luci luci-base luci-compat luci-i18n-base-zh-cn luci-lib-base luci-lib-docker \
 luci-lib-ip luci-lib-ipkg luci-lib-jsonc luci-lib-nixio luci-mod-admin-full luci-mod-network \
 luci-mod-status luci-mod-system luci-proto-3g luci-proto-bonding luci-proto-ipip luci-proto-ipv6 \
 luci-proto-ncm luci-proto-openconnect luci-proto-ppp luci-proto-qmi luci-proto-relay \
 \
 luci-app-amlogic luci-i18n-amlogic-zh-cn \

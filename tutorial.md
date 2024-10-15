## 代码解读

config/platform.config
举例：x86_64/x86/64/linux-amd64/amd64
解释：x86_64 是镜像的标签 x86 是 target 64 是 subtarget linux-amd64 是镜像构建时使用的平台
aarch64_generic/armsr/armv8/linux-arm64/armv8 需要稳定版本才能构建否则报错，具体看 ./遇到的报错.md

## 配置方法

使用 docker-compose

```yml
services:
  openwrt:
    image: 14790897/openwrt:x86_64
    container_name: openwrt
    restart: always
    privileged: true
    networks:
      macvlan_net:
    command: /sbin/init

networks:
  macvlan_net:
    driver: macvlan
    driver_opts:
      parent: enp1s0
    ipam:
      config:
        - subnet: 192.168.0.0/24 # 定义容器使用的子网
          gateway: 192.168.0.1 # 定义网关
```

运行后进入 容器
docker exec -it openwrt /bin/bash
nano /etc/config/network
修改 IP 地址和路由器同一网段，网关是路由器地址
![image|369x500](https://linux.do/uploads/default/original/3X/1/b/1bc20192030fc5da0c9b652341b77f34c55b211f.png)
然后重启网络服务：
<!-- cat /etc/config/network -->
/etc/init.d/network restart

然后访问配置的 IP 地址就可以用了


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
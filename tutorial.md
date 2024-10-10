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
        ipv4_address: 192.168.0.188 # 为容器指定静态 IP 地址
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
![image|369x500](upload://3XyxYevJvcGL0pA4oaUsROvt7cj.png)
然后重启网络服务：

/etc/init.d/network restart

然后访问配置的 IP 地址就可以用了

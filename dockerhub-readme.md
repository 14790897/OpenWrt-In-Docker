# [OpenWrt-In-Docker](https://github.com/14790897/OpenWrt-In-Docker)

[![GitHub Stars](https://img.shields.io/github/stars/14790897/OpenWrt-In-Docker.svg?style=flat-square&label=Stars&logo=github)](https://github.com/14790897/OpenWrt-In-Docker/stargazers)
[![GitHub Forks](https://img.shields.io/github/forks/14790897/OpenWrt-In-Docker.svg?style=flat-square&label=Forks&logo=github)](https://github.com/14790897/OpenWrt-In-Dockerr/fork)
[![Docker Stars](https://img.shields.io/docker/stars/14790897/openwrt.svg?style=flat-square&label=Stars&logo=docker)](https://hub.docker.com/r/14790897/openwrt)
[![Docker Pulls](https://img.shields.io/docker/pulls/14790897/openwrt.svg?style=flat-square&label=Pulls&logo=docker&color=orange)](https://hub.docker.com/r/14790897/openwrt)

本项目旨在构建适用于树莓派 1~4 、适用于 armv6/armv7/armv8(aarch64)/x86_64(amd64) 平台设备的 OpenWrt 镜像 (每日更新)。

Github: <https://github.com/14790897/OpenWrt-In-Docker>

DockerHub: <https://hub.docker.com/repository/docker/14790897/openwrt/general>

## 支持设备及镜像版本

本项目基于 [immortalwrt: master](https://github.com/immortalwrt/immortalwrt/tree/master)，每日上午 8 点编译 OpenWrt 镜像

### OpenWrt 标准镜像

OpenWrt 标准镜像为集成常用软件包的 Docker 镜像，镜像自带软件包可满足大多数情景下的使用需求。

|  支持设备/平台  |         DockerHub         |
| :-------------: | :-----------------------: |
|    树莓派 1B    |   14790897/openwrt:rpi1   |
|    树莓派 2B    |   14790897/openwrt:rpi2   |
| 树莓派 3B / 3B+ |   14790897/openwrt:rpi3   |
|    树莓派 4B    |   14790897/openwrt:rpi4   |
|    树莓派 5     |   14790897/openwrt:rpi5   |
|      armv7      |  14790897/openwrt:armv7   |
|  arm8/aarch64   |  14790897/openwrt:armv8   |
|  x86_64/amd64   |  14790897/openwrt:x86_64  |
|     玩客云      | 14790897/openwrt:onecloud |

### OpenWrt-Mini 镜像

OpenWrt-Mni 镜像为几乎未添加额外软件包的 Docker 镜像，你可以自行通过 opkg 安装你需要的软件包。

|  支持设备/平台  |           DockerHub            |
| :-------------: | :----------------------------: |
|    树莓派 1B    |   14790897/openwrt-mini:rpi1   |
|    树莓派 2B    |   14790897/openwrt-mini:rpi2   |
| 树莓派 3B / 3B+ |   14790897/openwrt-mini:rpi3   |
|    树莓派 4B    |   14790897/openwrt-mini:rpi4   |
|    树莓派 5     |   14790897/openwrt-mini:rpi5   |
|      armv7      |  14790897/openwrt-mini:armv7   |
|  arm8/aarch64   |  14790897/openwrt-mini:armv8   |
|  x86_64/amd64   |  14790897/openwrt-mini:x86_64  |
|     玩客云      | 14790897/openwrt-mini:onecloud |

## 注意事项

- 其中，树莓派 2B 镜像同时适用于 2B/3B/3B+/4B 。
- 若拉取镜像时不加任何标签，则将使用 latest 标签拉取镜像，latest 指向的镜像与树莓派 2B 镜像实际上为同一镜像。

- 由于 Docker 容器与宿主机共享内核，所以 Docker 容器的内核特性与宿主机当前的内核特性相同。
- 本项目固件支持 opkg 安装软件包，软件源内有 7000+ 个软件包可供选择。
- (对于高级用户) 某些软件包可能依赖一些特定的内核特性，所以我不保证 opkg 软件源中的所有软件包都可以正常使用。且因为上文所述原因，在 OpenWrt 中安装 kmod 是无效的，如果有需求，请提前在宿主机中提前载入相应的内核模块，例如:

```sh
modprobe ip6_udp_tunnel
modprobe ip6table_nat
modprobe pppoe
modprobe tun
modprobe udp_tunnel
modprobe xt_TPROXY
```

## 镜像详细使用方法

[「在 Docker 中运行 OpenWrt 旁路网关」](./tutorial.md)

## 鸣谢

<https://github.com/SuLingGG/OpenWrt-Docker>

P3TERX/Actions-OpenWrt (本项目基于此项目):

<https://github.com/P3TERX/Actions-OpenWrt>

OpenWrt Source Repository:

<https://github.com/openwrt/openwrt/>

Lean's OpenWrt source:

<https://github.com/coolsnowwolf/lede>

CTCGFW's Team:

<https://github.com/project-openwrt>

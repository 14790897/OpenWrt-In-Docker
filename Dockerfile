FROM scratch

LABEL org.opencontainers.image.authors="liuweiqing"

ADD *.tar.gz /

# 将修改IP的功能放在docker里的初始运行命令中
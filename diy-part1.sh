#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# 此脚本在 "feeds update" 之前运行。
# 已针对 512MB 内存设备在 mt7981.config 中关闭激进省内存
# （CONFIG_MTK_MEMORY_SHRINK* 均置为 not set），无线 token_rx_cnt
# 回到官方满血 12288，因此不再需要 999-Increase-token-rx-cnt 补丁。
#

# 取消 Dnsmasq 缓存，由 smartdns 负责（当前注释，如需启用去掉行首 #）
# sed -i 's/cachesize\t8000/cachesize\t0/g' package/network/services/dnsmasq/files/dhcp.conf
# sed -i 's/mini_ttl\t3600/mini_ttl\t0/g' package/network/services/dnsmasq/files/dhcp.conf

# Remove 6in4（移除 IPv6 6in4 隧道支持）
sed -i 's/ +6in4//g' package/emortal/ipv6-helper/Makefile
sed -i '/hotplug.d/d' package/emortal/ipv6-helper/Makefile
rm -fv package/emortal/ipv6-helper/files/60-6in4

# 如需添加第三方 feed，取消对应行注释（示例）
# echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
# echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

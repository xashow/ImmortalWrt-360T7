#!/bin/bash
#=============================================================
# diy-360t7.sh — 360T7 (MT7981) DIY 脚本
#=============================================================
set -euo pipefail
log() { echo ">>> [360T7] $*"; }
# ============================================================
# 设置主机名
# ============================================================
CFG=./package/base-files/files/bin/config_generate

log "设置主机名 → 360T7"
grep -n "hostname" "$CFG" || true
sed -i -E "s/(hostname=['\"])ImmortalWrt(['\"])/\1360T7\2/" "$CFG"
grep -q "360T7" "$CFG" || { echo "主机名替换失败"; exit 1; }

# ============================================================
# Golang
# ============================================================
log "替换 Golang → 27.x"
rm -rf feeds/packages/lang/golang
git clone --depth=1 -b 27.x https://github.com/sbwml/packages_lang_golang feeds/packages/lang/golang

# ============================================================
# 清理 feeds 过时代理组件
# ============================================================
log "清理 feeds 旧代理相关包"
rm -rf feeds/packages/net/{xray-core,v2ray-geodata,sing-box,chinadns-ng,dns2socks,hysteria,ipt2socks,microsocks,naiveproxy,shadowsocks-rust,shadowsocksr-libev,simple-obfs,tcping,v2ray-plugin,xray-plugin,geoview,shadow-tls}
rm -rf feeds/luci/applications/luci-app-passwall

# passwall 仓库注释，需要使用再取消注释
# git clone --depth=1 https://github.com/Openwrt-Passwall/openwrt-passwall-packages.git package/passwall-packages
# git clone --depth=1 https://github.com/Openwrt-Passwall/openwrt-passwall.git package/passwall

# nikki 已移除
# git clone --depth=1 https://github.com/nikkinikki-org/OpenWrt-nikki package/nikki

# log "克隆 lucky"
# git clone --depth=1 https://github.com/gdy666/luci-app-lucky package/lucky
# log "克隆 quickfile"
# git clone --depth=1 https://github.com/sbwml/luci-app-quickfile package/luci-app-quickfile

# ============================================================
log "完成 ✓"


#!/bin/bash

#修改默认IP地址
sed -i 's/192.168.1.1/192.168.31.1/g' package/base-files/files/bin/config_generate

# Git稀疏克隆，只克隆指定目录到本地
function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../package
  cd .. && rm -rf $repodir
}

# git_sparse_clone master https://github.com/syb999/openwrt-19.07.1 package/network/services/msd_lite

# 添加adguardhome
# git_sparse_clone master https://github.com/kiddin9/openwrt-packages adguardhome luci-app-adguardhome

# 添加ddns-go
# git_sparse_clone master https://github.com/kiddin9/openwrt-packages ddns-go luci-app-ddns-go

# 删除不需要的文件
# rm -rf feeds/packages/net/{xray-core,v2ray-core,v2ray-geodata,sing-box}
rm -rf feeds/packages/lang/golang
# rm -rf feeds/packages/net/v2ray-geodata
rm -rf feeds/packages/net/smartdns
rm -rf feeds/luci/luci-app-smartdns

# 添加Turboacc
# curl -sSL https://raw.githubusercontent.com/chenmozhijin/turboacc/luci/add_turboacc.sh -o add_turboacc.sh && bash add_turboacc.sh

# 添加cloudflarespeedtest
# git clone --depth=1 https://github.com/immortalwrt-collections/openwrt-cdnspeedtest.git package/cdnspeedtest
# git clone --depth=1 https://github.com/mingxiaoyu/luci-app-cloudflarespeedtest.git package/cloudflarespeedtest

# 添加vlmcsd
git clone https://github.com/siwind/openwrt-vlmcsd.git package/vlmcsd
git clone https://github.com/siwind/luci-app-vlmcsd.git package/luci-app-vlmcsd

# 添加passwall及依赖
# git clone https://github.com/sbwml/openwrt_helloworld package/helloworld
git clone https://github.com/xiaorouji/openwrt-passwall-packages.git package/openwrt-passwall-packages
git clone https://github.com/xiaorouji/openwrt-passwall.git package/openwrt-passwall
# git clone -b luci-smartdns-dev --single-branch https://github.com/xiaorouji/openwrt-passwall.git package/openwrt-passwall

# 添加lucky
git clone https://github.com/gdy666/luci-app-lucky.git package/lucky

# 添加MosDNS
# git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
# git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

# 添加SmartDNS
git clone https://github.com/pymumu/openwrt-smartdns.git package/smartdns
git clone https://github.com/pymumu/luci-app-smartdns.git package/luci-app-smartdns

# 替换golang版本为1.22.x
git clone https://github.com/sbwml/packages_lang_golang -b 22.x feeds/packages/lang/golang

# 添加常用插件包
# git clone https://github.com/kenzok8/openwrt-packages package/openwrt-package
# git clone master https://github.com/kenzok8/small package/small

# ./scripts/feeds update -a
# ./scripts/feeds install -a

#!/bin/bash

# 修改默认IP
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

# 添加autoupdate
# git_sparse_clone master https://github.com/kiddin9/openwrt-packages autoupdate luci-app-autoupdate

# 添加netdata
git clone --depth=1 https://github.com/Jason6111/luci-app-netdata.git package/luci-app-netdata

# 添加adguardhome
# git_sparse_clone master https://github.com/kiddin9/openwrt-packages adguardhome luci-app-adguardhome

# 添加passwall
# git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages package/openwrt-passwall
# git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall package/luci-app-passwall

# 添加opcnclash
# git_sparse_clone master https://github.com/vernesong/OpenClash luci-app-openclash

# 添加Turboacc
curl -sSL https://raw.githubusercontent.com/chenmozhijin/turboacc/luci/add_turboacc.sh -o add_turboacc.sh && bash add_turboacc.sh

# 添加MosDNS
# rm -rf feeds/packages/net/v2ray-geodata
# git clone --depth=1 https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
# git clone --depth=1 https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

# 添加argon
# git clone --depth=1 https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
# git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config

# 添加cloudflarespeedtest
git clone --depth=1 https://github.com/immortalwrt-collections/openwrt-cdnspeedtest.git package/cdnspeedtest
git clone --depth=1 https://github.com/mingxiaoyu/luci-app-cloudflarespeedtest.git package/cloudflarespeedtest
./scripts/feeds install golang cdnspeedtest

# 替换golang版本为1.22.x
# rm -rf feeds/packages/lang/golang
# git clone https://github.com/sbwml/packages_lang_golang -b 22.x feeds/packages/lang/golang

# 使用golang 1.21编译xray-core & xray-plugin
git apply xray-core/patches/010-go1.21.patch
git apply xray-plugin/patches/010-go1.21.patch

# 添加常用插件包
git clone --depth=1 -b master https://github.com/kenzok8/openwrt-packages package/openwrt-package
git clone --depth=1 -b master https://github.com/kenzok8/small package/small

# ./scripts/feeds update -a
# ./scripts/feeds install -a

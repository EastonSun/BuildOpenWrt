#!/bin/bash

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

# 删除不需要的文件
rm -rf feeds/packages/net/v2ray-geodata
git clone --depth=1 https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

# 添加Turboacc
# curl -sSL https://raw.githubusercontent.com/chenmozhijin/turboacc/luci/add_turboacc.sh -o add_turboacc.sh && bash add_turboacc.sh

# 添加cloudflarespeedtest
# git clone --depth=1 https://github.com/immortalwrt-collections/openwrt-cdnspeedtest.git package/cdnspeedtest
# git clone --depth=1 https://github.com/mingxiaoyu/luci-app-cloudflarespeedtest.git package/cloudflarespeedtest

# 添加vlmcsd
git clone https://github.com/siwind/openwrt-vlmcsd.git package/vlmcsd
git clone https://github.com/siwind/luci-app-vlmcsd.git package/luci-app-vlmcsd

# 替换golang版本为1.22.x
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 22.x feeds/packages/lang/golang

# 添加常用插件包
git clone --depth=1 -b master https://github.com/kenzok8/openwrt-packages package/openwrt-package
git clone --depth=1 -b master https://github.com/kenzok8/small package/small

# ./scripts/feeds update -a
# ./scripts/feeds install -a

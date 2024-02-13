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

# svn_export "master" "target/linux/x86" "route" "https://github.com/coolsnowwolf/lede"

# 添加netdata
git_sparse_clone master https://github.com/immortalwrt/packages/trunk/admin netdata

# 修改默认IP
sed -i 's/192.168.1.1/192.168.31.1/g' package/base-files/files/bin/config_generate

git clone --depth=1 -b master https://github.com/kenzok8/openwrt-packages package/openwrt-package
git clone --depth=1 -b master https://github.com/kenzok8/small package/small

# 添加Turboacc
curl -sSL https://raw.githubusercontent.com/chenmozhijin/turboacc/luci/add_turboacc.sh -o add_turboacc.sh && bash add_turboacc.sh

# ./scripts/feeds update -a
# ./scripts/feeds install -a

# kernel_deb_builder
利用 GitHub Actions 自动编译 Linux 内核为 deb 包,仓库上游:https://github.com/debuggerx01/kernel_deb_builder

# 如何使用
如果您想要利用我的这个自动化脚本根据自己的需求编译内核，请参考如下步骤：

#### 1. Fork 仓库
访问(https://github.com/Linux-qitong/kernel_deb_builder) ，点击右上角的 `Fork` 按钮，并 clone 到本地

#### 2. 更新 config 文件
在本地将您获取的 config 文件替换根目录下的config，可以从您系统的 /boot/config*文件复制，或者手动编辑
可以把config重命名，比如config1，就需要修改build_action.sh，修改cp ../config .config为cp ../config1 .config

#### 3. 修改build_action.sh 
替换里面的内核下载链接以及解压信息即可编译，build_action_xanmod.sh和build_action_zen.sh是我自己添加的，脚本内容都是一样的，单纯为了区分编译内核

#### 4. 编写自定义修改脚本
新建patch.d目录，修改sh脚本取消# source ../patch.d/*.sh注释，然后编写自己的脚本放在这个目录下，在脚本执行过程中会自动应用该目录下的所有脚本

#### 5. 推送修改
推送后，action 需要手动触发，可以在您的仓库页面的 `Actions` 选项卡手动点击触发

Enjoy～ :grin:

了解更多请看：

[修改 Linux 内核使系统启动时间缩短约 30 秒](https://www.debuggerx.com/2021/07/07/Modify-the-linux-kernel-to-reduce-the-boot-speed-by-about-30-seconds/)


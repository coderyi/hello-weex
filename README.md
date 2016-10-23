# Hello Weex    




###简介

hello-weex包括一个Weex App，和自己扩展的WeexiOSKit。


weex version为
[v0.7.0 - 10月16日](https://github.com/alibaba/weex/tree/cb65b3cb892b2ddd36528b2c971303a529d68bd3)的版本

###Weex App: Monkey for GitHub

Monkey主要是用来展示GitHub上的开发者的排名，以及仓库的排名。


###WeexiOSKit

### 运行

0. 环境
	0. 安装 [Node.js](http://nodejs.org/) 4.0+
    0. 在根目录下 
        0. `npm install`, 安装工程 
        0. `./start` 到这里web版已经运行起来，浏览器输入`http://localhost:12580/` 就能看到了。
    0. Install [iOS Environment](https://developer.apple.com/library/ios/documentation/IDEs/Conceptual/AppStoreDistributionTutorial/Setup/Setup.html)
    0. Install [CocoaPods](https://guides.cocoapods.org/using/getting-started.html)
0. 运行 iOS playground
    0. `cd ios/playground`
    0. `pod install`
    0. 在 Xcode里打开 `WeexDemo.xcworkspace` 
    0. 点击Xcode的 <img src="http://img1.tbcdn.cn/L1/461/1/5470b677a2f2eaaecf412cc55eeae062dbc275f9" height="16" > (`Run` 按钮) 或者用快捷键 `cmd + r` 
    0. 如果你想在真机上运行. 在 `DemoDefine.h`, 修改 `CURRENT_IP` 为你自己的IP


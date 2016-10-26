# Hello Weex    




###简介

hello-weex包括一个Weex App，和自己扩展的WeexiOSKit。


weex version为
[v0.7.0 - 10月16日](https://github.com/alibaba/weex/tree/cb65b3cb892b2ddd36528b2c971303a529d68bd3)的版本

Weex App 的代码位于 [examples](https://github.com/coderyi/hello-weex/tree/master/examples)目录下

WeexiOSKit的代码位于 [ios/playground/WeexDemo/WeexiOSKit](https://github.com/coderyi/hello-weex/tree/master/ios/playground/WeexDemo/WeexiOSKit)目录下


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



###Weex App: Monkey for GitHub

Monkey主要是用来展示GitHub上的开发者的排名，以及仓库的排名。

<div flex-direction:"row">
<img  src="https://github.com/coderyi/hello-weex/blob/master/img/mu.png?raw=true" width="250" height="445">
<img  src="https://github.com/coderyi/hello-weex/blob/master/img/mr.png?raw=true" width="250" height="445">
</div>

###WeexiOSKit

WeexiOSKit主要是扩展了一些iOS的Component和Module，这样在weex端就可以很好的使用了。

Component 包括segmented-control（UISegmentedControl）,stepper（UIStepper）,seek-bar（UISeekBar）,search-bar（UISearchBar）,date-picker（UIDatePicker）。

Module主要包括actionSheet（UIActionSheet），MBProgressHUD（MBProgressHUD，loading视图），geolocation（CLLocationManager坐标），vibration（震动）。





####Component

<div flex-direction:"row">

<img  src="https://github.com/coderyi/hello-weex/blob/master/img/ia.png?raw=true" width="250" height="445">

<img  src="https://github.com/coderyi/hello-weex/blob/master/img/ib.png?raw=true" width="250" height="445">
</div>


####Module

<div flex-direction:"row">

<img  src="https://github.com/coderyi/hello-weex/blob/master/img/ic.png?raw=true" width="250" height="445">




<img  src="https://github.com/coderyi/hello-weex/blob/master/img/id.png?raw=true" width="250" height="445">



<img  src="https://github.com/coderyi/hello-weex/blob/master/img/ie.png?raw=true" width="250" height="445">
</div>

###WeexiOSKit使用

####Component

segmented-control:支持iOS & web
   
属性:items(segmented-control里的项目，以分号隔开)，momentary（是否设置选中状态），tint-color（颜色）
      
event:`onchange`


```
<segmented-control 
	style="width: 240;height: 120;margin-top:20" 
	items="hello;world" 
	momentary= "false" 
	tint-color= "red" 
	onchange="onSCChangeAction">
</segmented-control>
```



stepper   
属性: value(当前的值)，step-value（默认为1），minimum-value（最小值），maximum-value="100（最大值），tint-color（颜色）
      
event:`onchange`


```
<stepper style="width: 240;height: 120;margin-top:20" value="20" step-value= "10" minimum-value="0" maximum-value="100" tint-color= "red" onchange="onChangeAction"></stepper>
```

seek-bar   
属性: value(当前的值)，minimum-value（最小值），maximum-value="100（最大值），minimum-track-tint-color,maximum-track-tint-color, thumb-tint-color, minimum-track-image-src,maximum-track-image-src,thumb-image-src
      
event:`onchange`

```
<seek-bar style=" width: 400;height: 70;margin-top:20;margin-left:20" minimum-value="0" maximum-value="100" value="50" onchange="seekBarChange" minimum-track-tint-color="blue" maximum-track-tint-color="blue" thumb-tint-color="red" > sdsd</seek-bar>

<seek-bar style=" width: 160;height: 140;margin-top:20;margin-left:220" minimum-value="0" maximum-value="100" value="50" onchange="imageSeekBarChange"  thumb-image-src="https://raw.githubusercontent.com/jainsourabh2/SayIt/master/iOS/SayIt/SayIt/rating1.png" maximum-track-image-src="http://pic002.cnblogs.com/images/2012/348285/2012042611243397.png" minimum-track-image-src="http://pic002.cnblogs.com/images/2012/348285/2012042611244465.png"> sdsd</seek-bar>
```



search-bar   
属性: tint-color（颜色）
      
event:`onclick `



```
<search-bar style="width: 300;height: 120;margin-top:20"  tint-color= "red" onclick="onclicksearch"></search-bar>
```

date-picker   
属性: tint-color（颜色）
      
event:`onchange `


```
<date-picker style="width: 640;height: 400;margin-top:20"  tint-color= "red" onchange="onclickdatepicker" ></date-picker>
```

####Module


MBProgressHUD为loading模块
函数：showHUD（显示HUD，参数为title，detail，mode[枚举值indicator/text]，cancelTitle，contentColor），hideHUD隐藏HUD（）

```
  toast: function() {
    var MBProgressHUD = require('@weex-module/MBProgressHUD');
    MBProgressHUD.showHUD({title:"loading",contentColor:"red",mode:"indicator"});
    setTimeout(function () {
      MBProgressHUD.hideHUD();
    }, 2000)
  }
```


actionSheet
函数：actionSheetShow（参数为cancelButtonTitle，destructiveButtonTitle，otherButtonTitles（数组），以及一个回调）


```
  actionSheet: function() {
    var me= this;
    var actionSheet = require('@weex-module/actionSheet');
    actionSheet.actionSheetShow({
      'cancelButtonTitle': 'cancel',
      'destructiveButtonTitle': 'destructive',
      'otherButtonTitles': me.buttons
    }, function(result) {
    });
  }
```

geolocation 定位模块

函数getCurrentPosition（参数accuracy，distanceFilter）


```
  geolocationAction: function() {
    var me= this;
    var geolocation = require('@weex-module/geolocation');
    geolocation.getCurrentPosition({
      'accuracy': '1000',
      'distanceFilter': '10'
    }, function(result) {
      me.geolocationValue = JSON.stringify(result);
    }, function(result) {
    });
  }
```

vibration
函数：vibrate（真机震动）

```
  vibrate: function() {
    var vibration = require('@weex-module/vibration');
    vibration.vibrate()
  }
```


###weex-web-kit

weex-web-kit代码位于[html5/browser/weex-web-kit](https://github.com/coderyi/hello-weex/tree/master/html5/browser/weex-web-kit)目录下

<img  src="https://github.com/coderyi/hello-weex/blob/master/img/web-sc.png" width="250" height="445">

```
<segmented-control style="width: 240;height: 120;margin-top:20" items="hello;world" momentary= "false" tint-color= "red" onchange="onChangeAction"></segmented-control>
```


#### Licenses

All source code is licensed under the [MIT License](https://opensource.org/licenses/MIT).


欢迎加入Weex学习小组，一起学习Weex！

<img src="https://raw.githubusercontent.com/coderyi/blog/master/other/images/weexwechat.jpeg" width="225" height="300">




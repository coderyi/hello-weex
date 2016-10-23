

var modal
__weex_define__('@weex-temp/x', function(__weex_require__) {
    modal = __weex_require__('@weex-module/modal')
})

var navigator
__weex_define__('@weex-temp/x', function(__weex_require__) {
    navigator = __weex_require__('@weex-module/navigator')
})

var data = {
    baseurl: 'http://localhost:12580/project/build/',
    baseImageUrl: 'http://xiaobaiossdevortest.oss-cn-beijing.aliyuncs.com/common/',
    baseh5url: 'http://localhost:12580/index.html?page=./examples/build/',
    debug: true
}

function isIosPlatform(self) {
    var platform = self.$getConfig().env.platform
    return platform === "iOS"
}

function getDeviceInfo(self) {
    var env = self.$getConfig().env
    var deviceWidth = env.deviceWidth
    var deviceHeight = env.deviceHeight
    var deviceInfo = {
        deviceWidth: deviceWidth,
        deviceHeight: deviceHeight
    }
    return deviceInfo
}


function push(self, url) {
    var filterUrl = url
    var params = {
        'url': getBaseUrl() + filterUrl,
        'animated': 'true',
    }
    navigator.push(params, function(e) {
        //callback
    })
    toastDebug(self, getBaseUrl() + filterUrl);

}

function pop(self) {
    var params = {
        'animated': 'true',
    }
    navigator.pop(params, function(e) {
        //callback
    })
}

function toastDebug(self, content) {
    if (data.debug) {
        toast(self, content);
    }
}

function toast(self, content) {
    // new format
    modal.toast({message: content,'duration': 2.0})

    //old format
    // self.$call('modal', 'toast', {
    //     'message': content,
    //     'duration': 2.0
    // })
}
//get url's parameter by name ,better getUrlParam
function getParameterByName(name, url) {
    name = name.replace(/[\[\]]/g, "\\$&")
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url)
    if (!results) return null
    if (!results[2]) return ''
    return decodeURIComponent(results[2].replace(/\+/g, " "))
}


function getBaseUrl() {
    // in Native
    var base = data.baseurl
    if (typeof window === 'object') {
        // in Browser or WebView
        base = data.baseh5url
    }
    return base
}

function getAppBaseUrl(self) {
    var dir ='examples'
    var url = self.$getConfig().bundleUrl;
           
    var bundleUrl = url;
    bundleUrl = new String(bundleUrl);

    var nativeBase;
    var isAndroidAssets = bundleUrl.indexOf('file://assets/') >= 0;

    var isiOSAssets = bundleUrl.indexOf('file:///') >= 0;
    if (isAndroidAssets) {
      nativeBase = 'file://assets/';
    }
    else if (isiOSAssets) {
      nativeBase = bundleUrl.substring(0, bundleUrl.lastIndexOf('/') + 1);
    }
    else {
     //http://127.0.0.1:12580/examples/build/reading.js
      var host = 'localhost:12580';
      var matches = /\/\/([^\/]+?)\//.exec(self.$getConfig().bundleUrl);
      if (matches && matches.length >= 2) {
        host = matches[1];
      }
      //nativeBase = 'http://' + host + '/weex_tmp/h5_render/';
      nativeBase = 'http://' + host + '/' + dir + '/build/';
    }
    var h5Base = './index.html?page=./' + dir + '/build/';
    //Native端
    var base = nativeBase;
    //H5端
    if (typeof window === 'object') {
      base = h5Base;
    }


    return base
}

function getTabbarBaseUrl(self) {
    var bundleUrl = self.$getConfig().bundleUrl;
    var dir ='examples'

    var nativeBase;
    var isAndroidAssets = bundleUrl.indexOf('file://assets/') >= 0;
    var isiOSAssets = bundleUrl.indexOf('file:///') >= 0;
    if (isAndroidAssets) {
      nativeBase = 'file://assets/';
    }
    else if (isiOSAssets) {
      // file:///var/mobile/Containers/Bundle/Application/{id}/WeexDemo.app/
      // file:///Users/{user}/Library/Developer/CoreSimulator/Devices/{id}/data/Containers/Bundle/Application/{id}/WeexDemo.app/
      nativeBase = bundleUrl.substring(0, bundleUrl.lastIndexOf('/') + 1);
    }
    else {
      var host = 'localhost:12580';
      var matches = /\/\/([^\/]+?)\//.exec(self.$getConfig().bundleUrl);
      if (matches && matches.length >= 2) {
        host = matches[1];
      }
      nativeBase = 'http://' + host + '/' + dir + '/build/';
    }
    var h5Base = './' + dir + '/build/';
    // in Native
    var base = nativeBase;
    if (typeof window === 'object') {
      // in Browser or WebView
      base = h5Base;
    }
    return base 

}

function getBaseImageUrl() {
    return data.baseImageUrl
}

function weexLog(log) {
    console.log(log)
    nativeLog(log)
}



exports.isIosPlatform = isIosPlatform
exports.getDeviceInfo = getDeviceInfo
exports.push = push
exports.pop = pop
exports.toastDebug = toastDebug
exports.toast = toast
exports.getParameterByName = getParameterByName
exports.getBaseUrl = getBaseUrl
exports.getBaseImageUrl = getBaseImageUrl
exports.getAppBaseUrl = getAppBaseUrl
exports.getTabbarBaseUrl = getTabbarBaseUrl
exports.weexLog = weexLog

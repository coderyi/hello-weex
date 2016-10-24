/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ({

/***/ 0:
/***/ function(module, exports, __webpack_require__) {

	var __weex_template__ = __webpack_require__(125)
	var __weex_style__ = __webpack_require__(126)
	var __weex_script__ = __webpack_require__(127)

	__weex_define__('@weex-component/7204d692ff7221b7b0fce407bfd1049e', [], function(__weex_require__, __weex_exports__, __weex_module__) {

	    __weex_script__(__weex_module__, __weex_exports__, __weex_require__)
	    if (__weex_exports__.__esModule && __weex_exports__.default) {
	      __weex_module__.exports = __weex_exports__.default
	    }

	    __weex_module__.exports.template = __weex_template__

	    __weex_module__.exports.style = __weex_style__

	})

	__weex_bootstrap__('@weex-component/7204d692ff7221b7b0fce407bfd1049e',undefined,undefined)

/***/ },

/***/ 86:
/***/ function(module, exports) {

	

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


/***/ },

/***/ 117:
/***/ function(module, exports) {

	/**
	 * Created by walid on 16/6/13.
	 * params : {method:POST/GET,url:http://xxx,header:{key:value},
	 *                 body:{key:value}}
	 */

	var stream
	__weex_define__('@weex-temp/x', function(__weex_require__) {
	    stream = __weex_require__('@weex-module/stream')
	})

	var modal
	__weex_define__('@weex-temp/x', function(__weex_require__) {
	    modal = __weex_require__('@weex-module/modal')
	})

	var apiURL = {
	    baseXbUrl: 'https://api.github.com',
	}

	function requestGet(url, callback) {
	    requestGetWithBody(url, null, callback);
	}

	function requestGetWithBody(url, body, callback) {

	    stream.fetch({
	        method: 'GET',
	        url: apiURL.baseXbUrl + url,
	        type: 'json',
	        body: body
	    }, function(ret) {
	        var resultObj = ret;
	        if (typeof resultObj == 'string') {
	            resultObj = JSON.parse(resultObj);
	        }
	        var serverResultData = resultObj.data;
	        if (typeof serverResultData == 'string') {
	            serverResultData = JSON.parse(serverResultData);
	        }
	        callback(serverResultData);
	    }, function(progress) {
	    })
	}

	function requestPost(url, callback) {
	    requestPostWithBody(url, null, callback);
	}

	function requestPostWithBody(url, body, callback) {

	    stream.fetch({
	        method: 'POST',
	        url: apiURL.baseXbUrl + url,
	        type: 'json',
	        body: body
	    }, function(ret) {
	        var resultObj = ret;
	        nativeLog('resultObj  = ' + ret);
	        if (typeof resultObj == 'string') {
	            resultObj = JSON.parse(resultObj);
	        }
	        var serverResultData = resultObj.data;
	        if (typeof serverResultData == 'string') {
	            serverResultData = JSON.parse(serverResultData);
	        }
	        callback(serverResultData);
	    }, function(progress) {
	    })

	}

	function requestUserRank(language,location,page, callback){
	    var GET_URL_JSONP;
	    if (language === 'All language') {
	        GET_URL_JSONP = 'https://api.github.com/search/users?sort=followers&page='+page+'&q=location:'+location;

	    }else {
	        GET_URL_JSONP = 'https://api.github.com/search/users?sort=followers&page='+page+'&q=language:'+language;
	        if (location !== 'World') {
	            GET_URL_JSONP = GET_URL_JSONP +'%20location:'+location;
	        }
	    }

	    stream.fetch({
	        method: 'GET',
	        url: GET_URL_JSONP,
	        type:'jsonp'
	    }, function(ret) {
	        if(!ret.ok){
	        }else{
	        }
	        callback(ret.data.items);
	    },function(response){
	        console.log('get in progress:'+response.length);
	    });
	}

	function requestUserDetail(login, callback){
	    var GET_URL_JSONP = 'https://api.github.com/users/'+login;

	    stream.fetch({
	        method: 'GET',
	        url: GET_URL_JSONP,
	        type:'jsonp'
	    }, function(ret) {
	        if(!ret.ok){
	        }else{
	        }

	        callback(ret.data);
	    },function(response){
	    });



	    



	}


	function requestRepRank(language,page, callback){

	    var GET_URL_JSONP;

	    GET_URL_JSONP = 'https://api.github.com/search/repositories?sort=stars&order=desc&page='+page+'&q=language:'+language;

	    stream.fetch({
	        method: 'GET',
	        url: GET_URL_JSONP,
	        type:'json'
	    }, function(ret) {
	        if(!ret.ok){
	        }else{
	        }
	        callback(ret.data.items);
	    },function(response){
	        console.log('get in progress:'+response.length);
	    });
	}



	exports.requestGet = requestGet
	exports.requestGetWithBody = requestGetWithBody
	exports.requestPost = requestPost
	exports.requestPostWithBody = requestPostWithBody
	exports.requestUserRank = requestUserRank
	exports.requestUserDetail = requestUserDetail
	exports.requestRepRank = requestRepRank


/***/ },

/***/ 125:
/***/ function(module, exports) {

	module.exports = {
	  "type": "div",
	  "classList": [
	    "userDiv"
	  ],
	  "children": [
	    {
	      "type": "div",
	      "classList": [
	        "userHeader"
	      ],
	      "children": [
	        {
	          "type": "image",
	          "style": {
	            "width": 120,
	            "height": 120,
	            "marginTop": 20
	          },
	          "attr": {
	            "src": function () {return this.user_avatar_url}
	          }
	        },
	        {
	          "type": "testyi",
	          "style": {
	            "backgroundColor": "#FF0000",
	            "marginTop": 20
	          },
	          "attr": {
	            "value": "qf疯1"
	          }
	        }
	      ]
	    },
	    {
	      "type": "div",
	      "classList": [
	        "userRow"
	      ],
	      "children": [
	        {
	          "type": "text",
	          "style": {
	            "backgroundColor": "#2323ff",
	            "marginTop": 20
	          },
	          "attr": {
	            "value": function () {return this.user_login+'x爱上'}
	          }
	        },
	        {
	          "type": "text",
	          "style": {
	            "backgroundColor": "#2323ff",
	            "marginTop": 20
	          },
	          "attr": {
	            "value": function () {return this.userdetail.name}
	          }
	        },
	        {
	          "type": "text",
	          "style": {
	            "backgroundColor": "#2323ff",
	            "marginTop": 20
	          },
	          "attr": {
	            "value": function () {return this.userdetail.company}
	          }
	        }
	      ]
	    },
	    {
	      "type": "div",
	      "classList": [
	        "userFooter"
	      ],
	      "children": [
	        {
	          "type": "text",
	          "style": {
	            "backgroundColor": "#2323ff",
	            "marginTop": 20
	          },
	          "attr": {
	            "value": function () {return this.userdetail.email}
	          }
	        },
	        {
	          "type": "text",
	          "style": {
	            "backgroundColor": "#2323ff",
	            "marginTop": 20
	          },
	          "events": {
	            "click": "onclickcell"
	          },
	          "attr": {
	            "value": function () {return this.userdetail.blog}
	          }
	        },
	        {
	          "type": "text",
	          "style": {
	            "backgroundColor": "#2323ff",
	            "marginTop": 20
	          },
	          "attr": {
	            "value": function () {return this.userdetail.location}
	          }
	        }
	      ]
	    }
	  ]
	}

/***/ },

/***/ 126:
/***/ function(module, exports) {

	module.exports = {
	  "userDiv": {
	    "width": 740,
	    "height": 400,
	    "flexDirection": "row",
	    "backgroundColor": "#ffffff",
	    "margin": 5,
	    "padding": 10,
	    "borderWidth": 1,
	    "borderColor": "#cccccc",
	    "overflow": "visible"
	  },
	  "userHeader": {
	    "flexDirection": "column",
	    "flex": 1,
	    "marginLeft": 5,
	    "backgroundColor": "#ffff33"
	  },
	  "userRow": {
	    "flexDirection": "column",
	    "flex": 2,
	    "marginLeft": 5,
	    "backgroundColor": "#fff12f"
	  },
	  "userFooter": {
	    "flexDirection": "column",
	    "flex": 3,
	    "marginLeft": 5,
	    "backgroundColor": "#34ffff"
	  }
	}

/***/ },

/***/ 127:
/***/ function(module, exports, __webpack_require__) {

	module.exports = function(module, exports, __weex_require__){'use strict';

	var utils = __webpack_require__(86);
	var monkeyApi = __webpack_require__(117);

	module.exports = {

	  data: function () {return {
	    user_login: 'dd',
	    user_avatar_url: '',
	    user_name: 'ddda',
	    user_email: 'dd',
	    user_blog: 'dd',
	    user_location: 'add',
	    user_company: 'dd',
	    userdetail: '',
	    baseURL: '',
	    dir: 'examples'
	  }},
	  created: function created() {

	    this.baseURL = utils.getAppBaseUrl(this);
	  },
	  ready: function ready(e) {
	    var me = this;
	    var bundleUrl = me.$getConfig().bundleUrl;
	    me.user_login = utils.getParameterByName('login', bundleUrl);
	    me.user_avatar_url = utils.getParameterByName('avataUrl', bundleUrl);
	    me.requestDetail(me.user_login);
	  },

	  methods: {
	    requestDetail: function requestDetail(login) {
	      var me = this;
	      monkeyApi.requestUserDetail(login, function (data) {
	        me.userdetail = data;
	        me.userdetail.created_at = me.userdetail.created_at.substring(0, 10);
	        console.log('userdetail' + me.userdetail.blog);
	      });
	    },
	    onclickcell: function onclickcell(e) {
	      this.$openURL(this.baseURL + 'm-webview.js?src=' + this.userdetail.blog);
	    }
	  }
	};}
	/* generated by weex-loader */


/***/ }

/******/ });
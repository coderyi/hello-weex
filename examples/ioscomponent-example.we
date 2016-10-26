<template>
  <scroller>
    <wxc-panel title="segmented-control" type="primary">
      <segmented-control style="width: 240;height: 120;margin-top:20" items="hello;world" momentary= "false" tint-color= "red" onchange="onSCChangeAction"></segmented-control>
    </wxc-panel>

    <wxc-panel title="stepper" type="primary">
      <div style="flex-direction: row">
        <stepper style="width: 240;height: 120;margin-top:20" value="20" step-value= "10" minimum-value="0" maximum-value="100" tint-color= "red" onchange="onChangeAction"></stepper>
        <text style="margin-top:30">{{'stepperValue :'+stepperValue}}</text>
      </div>
    </wxc-panel>

    <wxc-panel title="seek-bar" type="primary">
      <seek-bar style=" width: 400;height: 70;margin-top:20;margin-left:20" minimum-value="0" maximum-value="100" value="50" onchange="seekBarChange" minimum-track-tint-color="blue" maximum-track-tint-color="blue" thumb-tint-color="red" > sdsd</seek-bar>
      <text style="margin-top:30">{{'seek-bar value :'+seekBarValue}}</text>

      <seek-bar style=" width: 160;height: 140;margin-top:20;margin-left:220" minimum-value="0" maximum-value="100" value="50" onchange="imageSeekBarChange"  thumb-image-src="https://raw.githubusercontent.com/jainsourabh2/SayIt/master/iOS/SayIt/SayIt/rating1.png" maximum-track-image-src="http://pic002.cnblogs.com/images/2012/348285/2012042611243397.png" minimum-track-image-src="http://pic002.cnblogs.com/images/2012/348285/2012042611244465.png"> sdsd</seek-bar>
      <text style="margin-top:30">{{'seek-bar value :'+imageSeekBarValue}}</text>            
    </wxc-panel>

    <wxc-panel title="search-bar" type="primary">
        <search-bar style="width: 300;height: 120;margin-top:20"  tint-color= "red" onclick="onclicksearch"></search-bar>
        <text style="margin-top:30">{{'search-bar search result :'+searchBarValue}}</text>
    </wxc-panel>

    <wxc-panel title="date-picker" type="primary">
      <date-picker style="width: 640;height: 400;margin-top:20"  tint-color= "red" onchange="onclickdatepicker" ></date-picker>
      <text style="margin-top:30">{{'date-picker value :'+datePickerValue}}</text>
    </wxc-panel>
  </scroller>
</template>

<style>
</style>

<script>
  require('weex-components');
  module.exports = {
    data: {
      stepperValue:'',
      seekBarValue:'',
      imageSeekBarValue:'',
      searchBarValue:'',
      datePickerValue:''
    },
    created: function(){
    },
    ready: function(e) {
    },

    methods: {
      onSCChangeAction: function (e){
      },
      onChangeAction: function (e){
        this.stepperValue = e.value;
      },
      seekBarChange: function (e){
        this.seekBarValue = parseInt(e.value)
      },
      imageSeekBarChange: function (e){
        this.imageSeekBarValue = parseInt(e.value)
      },
      onclicksearch: function (e) {
        if (e.value) {
          this.searchBarValue = e.value
        }
      },
      onclickdatepicker: function (e) {
        this.datePickerValue = e.value
      }
    }
  }
</script>

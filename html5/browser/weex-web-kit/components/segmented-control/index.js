'use strict'
import './segmented-control.css'

const DEFAULT_FONT_SIZE = 32
const DEFAULT_TEXT_OVERFLOW = 'ellipsis'

function getProto (Weex) {
  const Atomic = Weex.Atomic
  return {
  create () {
    const node = document.createElement('div')
    node.classList.add('weex-container','weex-sc')

    node.style.fontSize = DEFAULT_FONT_SIZE * this.data.scale + 'px'

    this.style.lines.call(this, this.data.style.lines)


    return node
  },    


  clearAttr () {
    this.node.firstChild.textContent = ''
  }
}
  
}

const attr = {
  items: function (val) {

  if (!this.items) {

    while (this.node.firstChild) {
      this.node.removeChild(this.node.firstChild);
    }

    console.log('sdysd'+val+'sdd'+this.items);
    var res = val.split(";");

    var color = '2px solid '+this.tintColor;

    this.node.style.borderLeft = color

    for (var i = 0; i < res.length; i++) {

      var item = res[i];

      var textNode = document.createElement('span')
      textNode.style.whiteSpace = 'pre-wrap'
      textNode.style.wordWrap = 'break-word'
      textNode.style.display = '-webkit-box'
      textNode.style.lineHeight = this.data.style.height +'px'


      textNode.style.webkitBoxOrient = 'vertical'
      textNode.classList.add('weex-element','weex-sc-item')
      textNode.style.overflow = 'hidden'
      textNode.textContent = item
      textNode.style.borderRight = color
      textNode.style.borderBottom = color
      textNode.style.borderTop = color
      textNode.style.color = this.tintColor
      textNode.index = i;
      var me = this;
      textNode.addEventListener( "click", function() {
        me.currentIndex = this.index;
        if (me.momentary == 'false') {

          var res =me.node.childNodes
          for (var i = 0; i < res.length; i++) {
            var textNode = res[i]
            textNode.style.backgroundColor = 'white'
            textNode.style.color = me.tintColor

          }


          this.style.backgroundColor = me.tintColor
          this.style.color = 'white'
        }
        me.dispatchEvent("change",  {
          value: me.currentIndex
        })

        me.data.attr.checked= this.index;


        },true);

        this.node.appendChild(textNode)

      }



    }
  },
  momentary: function (value) {
    if (value) {
      this.momentary =value;


    }

  },
  tintColor: function (value) {
    if (value) {
      this.tintColor =value;


    }

  },

}
const style = {
  lines: function (val) {
    val = parseInt(val)
    if (isNaN(val)) {
      return
    }
  
  }
}


const event = {
  change: {
    updator () {
      return {
        attrs: {
          checked: this.currentIndex
        }
      }
    },
    extra () {
      return {
        value: this.currentIndex
      }
    }
  }



}



function init (Weex) {
  const Atomic = Weex.Atomic
  const extend = Weex.utils.extend

  function SegmentedControl (data) {
    this.checked = data.attr.checked

    Atomic.call(this, data)
  }
  SegmentedControl.prototype = Object.create(Atomic.prototype)

  extend(SegmentedControl.prototype, getProto(Weex))
  extend(SegmentedControl.prototype, { attr })
  extend(SegmentedControl.prototype, {
    style: extend(Object.create(Atomic.prototype.style), style)
  })

  Weex.registerComponent('segmented-control', SegmentedControl)
}

export default { init }

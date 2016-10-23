'use strict'

import Weex from './render'

/**
 * install components and APIs
 */
import root from './base/root'
import div from './base/div'
import components from './extend/components'
import api from './extend/api'
import weexwebkit from './weex-web-kit'

Weex.install(root)
Weex.install(div)
Weex.install(components)
Weex.install(api)
Weex.install(weexwebkit)

export default Weex

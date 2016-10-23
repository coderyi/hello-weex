


Pod::Spec.new do |s|
  s.name         = "WeexiOSKit"
  s.version      = "0.1"
  s.summary      = "WeexiOSKit -  Weex 's iOS components and module,and so on"
  s.homepage     = "https://github.com/coderyi/hello-weex"
  s.license      = "MIT"
  s.authors      = { "coderyi" => "coderyi@163.com" }
  s.source       = { :git => "https://github.com/coderyi/hello-weex.git", :tag => "0.1" }
  s.frameworks   = 'Foundation', 'CoreGraphics', 'UIKit'
  s.platform     = :ios, '7.0'
  s.source_files = 'ios/playground/WeexDemo/WeexiOSKit/**/*.{h,m,png}'
  s.requires_arc = true
  


 

end
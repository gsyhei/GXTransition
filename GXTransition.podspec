#
#  Be sure to run `pod spec lint GXTransition.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "GXTransition"
  s.version      = "1.0.5"
  s.summary      = "iOS常用转场动画（包括自定义和OC自带转场动画）Commonly used transition animation in iOS.(including custom transition animation and objective-c own transition animation.)"
  s.homepage     = "https://github.com/gsyhei/GXTransition"
  s.license      = "MIT"
  s.author       = { "Gin" => "279694479@qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/gsyhei/GXTransition.git", :tag => "1.0.5" }
  s.requires_arc = true
  s.source_files = "GXTransition"
  s.frameworks   = "Foundation","UIKit"

end

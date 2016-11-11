#
Pod::Spec.new do |s|
  s.name         = "AEGuideView"
  s.version      = "1.0.0"
  s.summary      = "An easy way to let your app show guide view during startup."
  s.description  = "An easy way to let your app show guide view during startup. This framework is written by objective-c"
  s.homepage     = "http://github.com/canicelebrate/AEGuideView"
  #s.screenshots  = "https://dl.dropboxusercontent.com/u/73895323/MMPickerView-GitHub.png"
  s.license      = 'MIT'
  s.author       = { "William Wang" => "canicelebrate@gmail.com" }
  s.source       = { :git => "https://github.com/canicelebrate/AEGuideView.git", :tag => s.version }
  s.platform     = :ios, '8.0'
  s.source_files = 'AEGuideView/*.{h,m}'
  #s.public_header_files = "AEGuideView/AEGuideView.h"
  #s.framework  = 'CoreGraphics'
  s.requires_arc = true
end

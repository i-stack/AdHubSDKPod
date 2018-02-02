#
# Be sure to run `pod lib lint AdHubSDKPod.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AdHubSDKPod'
  s.version          = '1.8.8.8'
  s.summary          = 'AdHubSDK is a delightful iOS AdHubSDK advertising platform.'
  s.homepage         = 'https://github.com/songMW'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'songMW' => 'songshoubing7664@163.com' }
  s.source           = { :git => 'https://github.com/songMW/AdHubSDKPod.git', :tag => s.version.to_s }

  s.ios.deployment_target = '7.0'

  #s.source_files = 'AdHubSDKPod/Classes/**/*'
  
  s.vendored_frameworks = 'AdHubSDKPod/Classes/*.framework'
  s.resources = 'AdHubSDKPod/Classes/*.bundle'

  s.frameworks = ['UIKit', 'Twitter', 'MobileCoreServices', 'Security', 'QuartzCore', 'SystemConfiguration', 'JavaScriptCore', 'WebKit', 'CoreMedia', 'CoreTelephony', 'CoreLocation', 'CoreMotion', 'AdSupport', 'CFNetwork', 'MessageUI', 'AVFoundation', 'SafariServices', 'StoreKit', 'CoreGraphics']

end

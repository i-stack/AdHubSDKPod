#
# Be sure to run `pod lib lint AdHubSDKPod.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AdHubSDKPod'
  s.version          = '0.3.0'
  s.summary          = 'AdHubSDK 广告平台, 用于请求广告的iOS SDK pod version'

 s.description      = <<-DESC
支持开屏, banner, 原生, 激励, 插屏, 自定义类型广告请求
1. 修复原生广告点击跳转后内存不能释放的问题
2. ua修复
3. 修改高级API问题
4. 修改开屏广告点击问题
5. 修改iOS7.0模式下 HTML格式不能加载问题
6. 添加原生广告点击时坐标获取
7. pod create framework with example
8. fix User-Agent
 DESC


  s.homepage         = 'https://github.com/songMW/AdHubSDKPod'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'songMW' => 'songshoubing7664@163.com' }
  s.source           = { :git => 'https://github.com/songMW/AdHubSDKPod.git', :tag => s.version.to_s }

  s.ios.deployment_target = '7.0'

  #s.source_files = 'AdHubSDKPod/Classes/**/*'
  
  s.vendored_frameworks = 'AdHubSDKPod/Classes/*.framework'
  s.resources = 'AdHubSDKPod/Classes/*.bundle'

  s.frameworks = ['UIKit', 'Twitter', 'MobileCoreServices', 'Security', 'QuartzCore', 'SystemConfiguration', 'JavaScriptCore', 'WebKit', 'CoreMedia', 'CoreTelephony', 'CoreLocation', 'CoreMotion', 'AdSupport', 'CFNetwork', 'MessageUI', 'AVFoundation', 'SafariServices', 'StoreKit', 'CoreGraphics']

end

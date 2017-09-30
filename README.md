# AdHubSDKPod

[![CI Status](http://img.shields.io/travis/songMW/AdHubSDKPod.svg?style=flat)](https://travis-ci.org/songMW/AdHubSDKPod)
[![Version](https://img.shields.io/cocoapods/v/AdHubSDKPod.svg?style=flat)](http://cocoapods.org/pods/AdHubSDKPod)
[![License](https://img.shields.io/cocoapods/l/AdHubSDKPod.svg?style=flat)](http://cocoapods.org/pods/AdHubSDKPod)
[![Platform](https://img.shields.io/cocoapods/p/AdHubSDKPod.svg?style=flat)](http://cocoapods.org/pods/AdHubSDKPod)

AdHubSDKPod

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

AdHubSDKPod is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
platform :ios, '7.0'

target 'TargetName' do
pod "AdHubSDKPod", '~> 0.4.0'
end
```

Then, run the following command:

```bash
$ pod install
```

## License

AdHubSDKPod is available under the MIT license. See the LICENSE file for more info.

## How To Get Started
-  AdHub SDK 目录为 AdHubSample/lib/AdHubSDK.framework。
-  使用 Sample 工程时需要向 AdHub 申请 AppID 以及每种广告对应的 SpaceID。
-  参数说明:
                --  AppID               AdHub后台申请, 必填
                -- Space ID          AdHub后台申请, 必填
                -- Space Param   填任意字符串,   必填
- 默认AdHub广告id, 开发者也可以自行输入。


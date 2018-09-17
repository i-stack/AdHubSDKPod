//
//  AdHubInterstitialDelegate.h
//  AdHubSDK
//
//  Created by Toymi on 16/12/2.
//  Copyright © 2016年 haobo. All rights reserved.
//

#import "AdHubAdDelegate.h"

@class AdHubInterstitial;
@class AdHubRequestError;

@protocol AdHubInterstitialDelegate <AdHubAdDelegate>

@optional
/**
 插屏请求成功 若请求的是第三方广告此代理方法不回调
 */
- (void)interstitialDidReceiveAd:(AdHubInterstitial *)ad;

/**
 插屏请求失败
 */
- (void)interstitial:(AdHubInterstitial *)ad didFailToReceiveAdWithError:(AdHubRequestError *)error;

/**
 插屏展现
 */
- (void)interstitialDidPresentScreen:(AdHubInterstitial *)ad;

/**
 插屏点击 landingPageURL 为空时说明有详情页
 */
- (void)interstitialDidClick:(NSString *)landingPageURL;

/**
 插屏关闭
 */
- (void)interstitialDidDismissScreen:(AdHubInterstitial *)ad;

/**
 @return 展现 interstitial 点击二跳所需的 UIViewController，不能为空
 */
- (UIViewController *)adInterstitialViewControllerForPresentingModalView;

@end

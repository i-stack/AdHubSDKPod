//
//  HaoBoRequstAdBaseViewController.h
//  AdHubSDK
//
//  Created by Mac on 2017/7/3.
//  Copyright © 2017年 AdHub. All rights reserved.
//

#import "HaoBoBaseViewController.h"

@interface HaoBoRequstAdBaseViewController : HaoBoBaseViewController

@property (nonatomic,strong,readonly)AdHubNative *native;

- (void)showBanner:(NSString *)spaceID;
- (void)showInterstitial:(NSString *)spaceID;
- (void)showCustom:(NSString *)spaceID;
- (void)showRewardVideo:(NSString *)spaceID;
- (void)showSplash:(NSString *)spaceID;
- (void)showNative:(NSString *)spaceID;
// 原生广告加载成功后 如需自行展示, 需重载此方法
- (void)nativeDidLoaded:(AdHubNative *)ad;
- (void)nativeShowExposeLog:(AdHubNativeAdDataModel *)dataModel;
- (void)nativeClickExposeLog:(AdHubNativeAdDataModel *)dataModel;
- (void)setNativeAdSDKOpenUrl:(BOOL)state;

@end

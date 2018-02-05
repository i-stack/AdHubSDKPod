//
//  HaoBoNativeAdView.h
//  AdHubSDK
//
//  Created by Mac on 2017/7/1.
//  Copyright © 2017年 AdHub. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HaoBoNativeAdViewDelegate <NSObject>

- (void)closeBtnClick;
- (void)clickImage:(AdHubNativeAdDataModel *)dataModel;
- (void)adImageAlreadyLoad:(AdHubNativeAdDataModel *)dataModel;

@end

@interface HaoBoNativeAdView : UIView

@property (nonatomic,assign)id<HaoBoNativeAdViewDelegate>delegate;

- (void)showOneImageThreeTextAd:(AdHubNative *)ad;
- (void)showOneTextThreeImageAd:(AdHubNative *)ad;

@end

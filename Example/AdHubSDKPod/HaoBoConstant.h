//
//  HaoBoConstant.h
//  AdHubSDK
//
//  Created by Mac on 2017/6/23.
//  Copyright © 2017年 AdHub. All rights reserved.
//

#ifndef HaoBoConstant_h
#define HaoBoConstant_h

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger) {
    AnalogyRequestType_interstitial,
    AnalogyRequestType_banner,
    AnalogyRequestType_rewardVideo,
    AnalogyRequestType_native,
    AnalogyRequestType_custom,
    AnalogyRequestType_splash
}AnalogyRequestType;

static NSString *const kHaoBo_logEvent = @"logEvent";
static NSString *const kHaoBo_appID = @"appID";
static NSString *const kHaoBo_intersitialSpaceID = @"intersitialSpaceID";
static NSString *const kHaoBo_bannerSpaceID = @"bannerSpaceID";
static NSString *const kHaoBo_rewardVideoSpaceID = @"rewardVideoSpaceID";
static NSString *const kHaoBo_customSpaceID = @"customSpaceID";
static NSString *const kHaoBo_nativeSpaceID = @"nativeSpaceID";
static NSString *const kHaoBo_splashSpaceID = @"splashSpaceID";
static NSString *const kHaoBo_spacefParam = @"spacefParam";
static CGFloat const kHaoBo_tabBarHeight = 49;

#endif /* HaoBoConstant_h */

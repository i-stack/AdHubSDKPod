//
//  HaoBoSpaceInfo.h
//  AdHubSDK
//
//  Created by Mac on 2017/6/23.
//  Copyright © 2017年 AdHub. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HaoBoSpaceInfo : NSObject

+ (HaoBoSpaceInfo *)sharedInstall;

@property (nonatomic,strong,readonly)NSString *appID;
@property (nonatomic,strong,readonly)NSString *intersitialSpaceID;
@property (nonatomic,strong,readonly)NSString *bannerSpaceID;
@property (nonatomic,strong,readonly)NSString *rewardVideoSpaceID;
@property (nonatomic,strong,readonly)NSString *customSpaceID;
@property (nonatomic,strong,readonly)NSString *nativeSpaceID;
@property (nonatomic,strong,readonly)NSString *splashSpaceID;
@property (nonatomic,strong,readonly)NSString *spacefParam;

- (NSArray *)defaultSpaces;

- (void)resetSpaceInfoToDefatult;

@end

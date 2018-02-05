//
//  HaoBoSpaceInfo.m
//  AdHubSDK
//
//  Created by Mac on 2017/6/23.
//  Copyright © 2017年 AdHub. All rights reserved.
//

#import "HaoBoSpaceInfo.h"

static HaoBoSpaceInfo *info = nil;

@implementation HaoBoSpaceInfo

+ (HaoBoSpaceInfo *)sharedInstall
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        info = [[self alloc]init];
    });
    return info;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        info = [super allocWithZone:zone];
    });
    return info;
}

- (instancetype)init
{
    if (self = [super init]) {
        _spacefParam = @"预留字段";
    }
    return self;
}

- (NSString *)appID
{
    NSString *userDefalutAppID = [HaoBoUtls userDefualtForKey:kHaoBo_appID];
    if (userDefalutAppID.length) {
        return userDefalutAppID;
    }
    return @"276";
}

- (NSString *)intersitialSpaceID
{
    NSString *userDefalutIntersitialSpaceID = [HaoBoUtls userDefualtForKey:kHaoBo_intersitialSpaceID];
    if (userDefalutIntersitialSpaceID.length) {
        return userDefalutIntersitialSpaceID;
    }
    NSArray *spaceIDS = @[@"914", @"915", @"916", @"917", @"918", @"919", @"920", @"921", @"922", @"923"];
    NSUInteger x = [self randomSpaceID:spaceIDS.count];
    return spaceIDS[x];
}

- (NSString *)bannerSpaceID
{
    NSString *userDefalutBannerSpaceID = [HaoBoUtls userDefualtForKey:kHaoBo_bannerSpaceID];
    if (userDefalutBannerSpaceID.length) {
        return userDefalutBannerSpaceID;
    }
    NSArray *spaceIDS = @[@"910", @"911", @"912", @"913"];
    NSUInteger x = [self randomSpaceID:spaceIDS.count];
    return spaceIDS[x];
}

- (NSString *)rewardVideoSpaceID
{
    NSString *userDefalutRewardVideoSpaceID = [HaoBoUtls userDefualtForKey:kHaoBo_rewardVideoSpaceID];
    if (userDefalutRewardVideoSpaceID.length) {
        return userDefalutRewardVideoSpaceID;
    }
    NSArray *spaceIDS = @[@"933"];
    NSUInteger x = [self randomSpaceID:spaceIDS.count];
    return spaceIDS[x];
}

- (NSString *)customSpaceID
{
    NSString *userDefalutCustomSpaceID = [HaoBoUtls userDefualtForKey:kHaoBo_customSpaceID];
    if (userDefalutCustomSpaceID.length) {
        return userDefalutCustomSpaceID;
    }
    NSArray *spaceIDS = @[@"932"];
    NSUInteger x = [self randomSpaceID:spaceIDS.count];
    return spaceIDS[x];
}

- (NSString *)nativeSpaceID
{
    NSString *userDefalutNativeSpaceID = [HaoBoUtls userDefualtForKey:kHaoBo_nativeSpaceID];
    if (userDefalutNativeSpaceID.length) {
        return userDefalutNativeSpaceID;
    }
    NSArray *spaceIDS = @[@"940", @"993"];
    NSUInteger x = [self randomSpaceID:spaceIDS.count];
    return spaceIDS[x];
}

- (NSString *)splashSpaceID
{
    NSString *userDefalutSplashSpaceID = [HaoBoUtls userDefualtForKey:kHaoBo_splashSpaceID];
    if (userDefalutSplashSpaceID.length) {
        return userDefalutSplashSpaceID;
    }
    NSArray *spaceIDS = @[@"929", @"930", @"931"];
    NSUInteger x = [self randomSpaceID:spaceIDS.count];
    return spaceIDS[x];
}

- (NSArray *)defaultSpaces
{
    NSArray *array = @[@"Log Event",
                       [HaoBoSpaceInfo sharedInstall].intersitialSpaceID,
                       [HaoBoSpaceInfo sharedInstall].bannerSpaceID,
                       [HaoBoSpaceInfo sharedInstall].rewardVideoSpaceID,
                       [HaoBoSpaceInfo sharedInstall].customSpaceID,
                       [HaoBoSpaceInfo sharedInstall].nativeSpaceID,
                       [HaoBoSpaceInfo sharedInstall].splashSpaceID];
    return array;
}

- (void)resetSpaceInfoToDefatult
{
    [HaoBoUtls userDefaultRemoveKey:kHaoBo_appID];
    [HaoBoUtls userDefaultRemoveKey:kHaoBo_logEvent];
    [HaoBoUtls userDefaultRemoveKey:kHaoBo_intersitialSpaceID];
    [HaoBoUtls userDefaultRemoveKey:kHaoBo_bannerSpaceID];
    [HaoBoUtls userDefaultRemoveKey:kHaoBo_rewardVideoSpaceID];
    [HaoBoUtls userDefaultRemoveKey:kHaoBo_customSpaceID];
    [HaoBoUtls userDefaultRemoveKey:kHaoBo_nativeSpaceID];
    [HaoBoUtls userDefaultRemoveKey:kHaoBo_splashSpaceID];
}

- (NSUInteger)randomSpaceID:(NSInteger)spaceIDCount
{
    NSUInteger x = arc4random() % spaceIDCount;
    return x;
}

@end

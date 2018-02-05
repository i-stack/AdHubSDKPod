//
//  AdHubTestManager.m
//  AdHubSDK
//
//  Created by Mac on 2017/5/16.
//  Copyright © 2017年 haobo. All rights reserved.
//

#import "AdHubTestManager.h"

static AdHubTestManager *singleInstall = nil;

@implementation AdHubTestManager

+ (AdHubTestManager *)install
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleInstall = [[self alloc]init];
    });
    return singleInstall;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleInstall = [super allocWithZone:zone];
    });
    return singleInstall;
}

- (instancetype)init
{
    if (self = [super init]) {
        _requestCount = 0;
        _requestDoneContinue = NO;
        _allLogState = NO;
    }
    return self;
}

@end

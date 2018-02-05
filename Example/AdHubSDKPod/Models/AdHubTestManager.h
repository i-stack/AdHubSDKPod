//
//  AdHubTestManager.h
//  AdHubSDK
//
//  Created by Mac on 2017/5/16.
//  Copyright © 2017年 haobo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AdHubTestManager : NSObject

+ (AdHubTestManager *)install;

@property (nonatomic,assign)NSInteger requestCount;
@property (nonatomic,assign)BOOL allLogState;
@property (nonatomic,assign)BOOL requestDoneContinue;

@end

//
//  HaoBoInputModel.m
//  AdHubSDK
//
//  Created by Mac on 2017/6/23.
//  Copyright © 2017年 AdHub. All rights reserved.
//

#import "HaoBoInputModel.h"

@implementation HaoBoInputModel

- (instancetype)initAdCellBtn:(HaoBoButton *)cellBtn
{
    if (self = [super init]) {
        [self configInputModel:cellBtn];
    }
    return self;
}

- (void)configInputModel:(HaoBoButton *)cellBtn
{
    if (cellBtn.btnPosition == HaoBoCellBtnPosition_left) {
        self.title = @"input addid";
        self.placeholder = @"appid for sdk";
    }
    else{
        HaoBoRequestAdType adType = cellBtn.requestAdType;
        switch (adType) {
            case HaoBoRequestAdType_LogEvent:
                self.title = @"log event";
                self.placeholder = @"log for sdk";
                break;
                
            case HaoBoRequestAdType_intersitial:
                self.title = @"intersitial info";
                self.message = @"set space id for intersitial Ad";
                self.placeholder = @"input space id:";
                break;
                
            case HaoBoRequestAdType_banner:
                self.title = @"banner info";
                self.message = @"set space id for banner Ad";
                self.placeholder = @"input space id:";
                break;
                
            case HaoBoRequestAdType_reward_video:
                self.title = @"reward video info";
                self.message = @"set space id for reward video Ad";
                self.placeholder = @"input space id:";
                break;
                
            case HaoBoRequestAdType_custom:
                self.title = @"custom info";
                self.message = @"set space id for custom Ad";
                self.placeholder = @"input space id:";
                break;
                
            case HaoBoRequestAdType_native:
                self.title = @"native info";
                self.message = @"set space id for native Ad";
                self.placeholder = @"input space id:";
                break;
                
            case HaoBoRequestAdType_splash:
                self.title = @"splash info";
                self.message = @"set space id for splash Ad";
                self.placeholder = @"input space id:";
                break;
                
            default:
                break;
        }
    }
}

@end

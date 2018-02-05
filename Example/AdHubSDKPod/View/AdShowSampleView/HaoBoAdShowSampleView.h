//
//  HaoBoAdShowSampleView.h
//  AdHubSDK
//
//  Created by Mac on 2017/7/1.
//  Copyright © 2017年 AdHub. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HaoBoAdShowSampleViewDelegate <NSObject>

- (void)clickCellToShowAd:(AnalogyRequestType)type;

@end

@interface HaoBoAdShowSampleView : UIView

@property (nonatomic,assign)id<HaoBoAdShowSampleViewDelegate>delegate;

@end

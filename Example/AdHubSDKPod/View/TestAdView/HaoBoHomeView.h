//
//  HaoBoHomeView.h
//  AdHubSDK
//
//  Created by Mac on 2017/6/23.
//  Copyright © 2017年 AdHub. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HaoBoHomeViewDelegate <NSObject>

@required
- (UIViewController *)presentTextFieldVC;
- (void)beginRequstAd:(HaoBoRequestAdType)adType;
- (void)submitLogEvent;
- (void)showLog;
- (void)analogyAdMoreClick:(BOOL)openState;

@end

@interface HaoBoHomeView : UIView

@property (nonatomic,assign)id<HaoBoHomeViewDelegate>delegate;

@end

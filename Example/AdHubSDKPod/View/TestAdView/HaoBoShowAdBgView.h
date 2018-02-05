//
//  HaoBoShowAdBgView.h
//  AdHubSDK
//
//  Created by Mac on 2017/6/29.
//  Copyright © 2017年 AdHub. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HaoBoShowAdBgViewDelegate  <NSObject>

- (void)showAdBgViewCloseBtnClick;

@end

@interface HaoBoShowAdBgView : UIView

@property (nonatomic,assign)id<HaoBoShowAdBgViewDelegate>delegate;

@end

//
//  HaoBoButton.h
//  AdHubSDK
//
//  Created by Mac on 2017/6/23.
//  Copyright © 2017年 AdHub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HaoBoButton : UIButton

@property (nonatomic,assign)HaoBoCellBtnPosition btnPosition;
@property (nonatomic,assign)HaoBoRequestAdType requestAdType;
@property (nonatomic,assign)CGFloat row;
@property (nonatomic,assign)CGFloat section;

@end

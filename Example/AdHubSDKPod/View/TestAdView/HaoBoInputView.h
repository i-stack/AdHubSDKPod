//
//  HaoBoInputView.h
//  AdHubSDK
//
//  Created by Mac on 2017/6/22.
//  Copyright © 2017年 AdHub. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HaoBoInputModel;

typedef void (^HaoBoInputViewTextFieldTextBlock)(HaoBoInputModel *model);

@interface HaoBoInputView : UIView

- (instancetype)initWithFrame:(CGRect)frame textFieldText:(HaoBoInputViewTextFieldTextBlock)textFieldTextBlock;

- (void)configueTextField:(HaoBoInputModel *)inputModel;

@end

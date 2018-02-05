//
//  HaoBoInputModel.h
//  AdHubSDK
//
//  Created by Mac on 2017/6/23.
//  Copyright © 2017年 AdHub. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HaoBoButton.h"

@interface HaoBoInputModel : NSObject

@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *message;
@property (nonatomic,strong)NSString *placeholder;

//textField 返回结果
@property (nonatomic,strong)NSString *outputText;

- (instancetype)initAdCellBtn:(HaoBoButton *)cellBtn;

@end

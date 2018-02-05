//
//  HaoBoInputViewTableViewCell.h
//  AdHubSDK
//
//  Created by Mac on 2017/6/23.
//  Copyright © 2017年 AdHub. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HaoBoInputViewTableViewCellDelegate <NSObject>

- (void)cellBtnClick:(HaoBoButton *)clickBtn;

@end

@interface HaoBoInputViewTableViewCell : UITableViewCell

@property (nonatomic,assign)id<HaoBoInputViewTableViewCellDelegate>delegate;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath;

- (void)updateCellData:(NSArray *)data indexPath:(NSIndexPath *)indexPath;

@end

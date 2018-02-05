//
//  HaoBoInputViewTableViewCell.m
//  AdHubSDK
//
//  Created by Mac on 2017/6/23.
//  Copyright © 2017年 AdHub. All rights reserved.
//

#import "HaoBoInputViewTableViewCell.h"

static CGFloat const rightBtnWidth = 100;
static CGFloat const leftSpace = 10;
static CGFloat const rightSpace = -leftSpace;
static CGFloat const space = leftSpace;
static CGFloat const bottomSpace = -10;

@interface HaoBoInputViewTableViewCell ()

@property (nonatomic,strong)HaoBoButton *leftBtn;
@property (nonatomic,strong)HaoBoButton *rightBtn;

@end

@implementation HaoBoInputViewTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.leftBtn = [HaoBoButton buttonWithType:UIButtonTypeCustom];;
        self.leftBtn.backgroundColor = [UIColor orangeColor];
        [self.leftBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self.leftBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.leftBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.leftBtn.btnPosition = HaoBoCellBtnPosition_left;
        self.leftBtn.row = indexPath.row;
        self.leftBtn.section = indexPath.section;
        self.leftBtn.requestAdType = self.leftBtn.row;
        [self addSubview:self.leftBtn];
        
        self.rightBtn = [HaoBoButton buttonWithType:UIButtonTypeCustom];
        self.rightBtn.backgroundColor = [UIColor blueColor];
        [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.rightBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.rightBtn.btnPosition = HaoBoCellBtnPosition_right;
        self.rightBtn.row = indexPath.row;
        self.rightBtn.section = indexPath.section;
        self.rightBtn.requestAdType = self.rightBtn.row;
        [self addSubview:self.rightBtn];
        
        [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(0));
            make.bottom.equalTo(@(bottomSpace));
            make.right.equalTo(@(rightSpace));
            make.width.equalTo(@(rightBtnWidth));
        }];
        
        [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(0));
            make.left.equalTo(@(leftSpace));
            make.bottom.equalTo(@(bottomSpace));
            make.right.equalTo(self.rightBtn.mas_left).offset(-space);
        }];
    }
    return self;
}

- (void)updateCellData:(NSArray *)data indexPath:(NSIndexPath *)indexPath
{
    self.leftBtn.btnPosition = HaoBoCellBtnPosition_left;
    self.leftBtn.row = indexPath.row;
    self.leftBtn.section = indexPath.section;
    self.leftBtn.requestAdType = self.leftBtn.row;
    
    self.rightBtn.btnPosition = HaoBoCellBtnPosition_right;
    self.rightBtn.row = indexPath.row;
    self.rightBtn.section = indexPath.section;
    self.rightBtn.requestAdType = self.rightBtn.row;
    
    
    if (indexPath.row < 7) {
        self.leftBtn.hidden = NO;
        self.rightBtn.hidden = NO;
        if (data.count > indexPath.row) {
            if (indexPath.row == 0) {
                NSString *appID = [HaoBoSpaceInfo sharedInstall].appID;
                [self.leftBtn setTitle:[NSString stringWithFormat:@"%@%@", data[0], appID] forState:UIControlStateNormal];
            }
            else{
                [self.leftBtn setTitle:data[indexPath.row] forState:UIControlStateNormal];
            }
        }
        NSArray *spaces = [HaoBoSpaceInfo sharedInstall].defaultSpaces;
        if (spaces.count > indexPath.row) {
            [self.rightBtn setTitle:spaces[indexPath.row] forState:UIControlStateNormal];
        }
    }
    else{
        self.leftBtn.hidden = YES;
        self.rightBtn.hidden = YES;
        self.textLabel.text = data[indexPath.row];
        self.textLabel.textAlignment = NSTextAlignmentLeft;
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor blueColor];
    }
}

- (void)leftBtnClick:(HaoBoButton *)sender
{
    [self rightBtnClick:sender];
}

- (void)rightBtnClick:(HaoBoButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(cellBtnClick:)]) {
        [self.delegate cellBtnClick:sender];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

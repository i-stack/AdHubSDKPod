//
//  HaoBoShowAdBgView.m
//  AdHubSDK
//
//  Created by Mac on 2017/6/29.
//  Copyright © 2017年 AdHub. All rights reserved.
//

#import "HaoBoShowAdBgView.h"
#import "HaoBoUtls.h"

static CGFloat const btnSize = 60;
static CGFloat const btnTop = 15;
static CGFloat const btnRight = -btnTop;

@interface HaoBoShowAdBgView()

@property (nonatomic,strong)UIButton *closeBtn;

@end

@implementation HaoBoShowAdBgView

- (void)dealloc
{
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        [self addSubview:self.closeBtn];
        [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(btnTop));
            make.right.equalTo(@(btnRight));
            make.width.height.equalTo(@(btnSize));
        }];
    }
    return self;
}

- (void)closeBtnClick
{
    if ([self.delegate respondsToSelector:@selector(showAdBgViewCloseBtnClick)]) {
        [self.delegate showAdBgViewCloseBtnClick];
    }
}

- (UIButton *)closeBtn
{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[self currentBundelImage:@"QC_sm_channel_close"] forState:UIControlStateNormal];
        [_closeBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (UIImage *)currentBundelImage:(NSString *)imagePath
{
    NSString *bundelPath = [[NSBundle mainBundle]pathForResource:@"AdHubSDKResources" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundelPath];
    UIImage *image;
    if ([HaoBoUtls currentSystemVersion_iOS8]) {
        image = [UIImage imageNamed:imagePath inBundle:bundle compatibleWithTraitCollection:nil];
    }
    else{
        image = [UIImage imageWithContentsOfFile:[bundle pathForResource:imagePath ofType:@"png"]];
    }
    return image;
}

@end

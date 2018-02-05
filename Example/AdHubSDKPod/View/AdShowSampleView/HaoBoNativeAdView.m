//
//  HaoBoNativeAdView.m
//  AdHubSDK
//
//  Created by Mac on 2017/7/1.
//  Copyright © 2017年 AdHub. All rights reserved.
//

#import "HaoBoNativeAdView.h"
#import "HaoBoShowAdBgView.h"
#import "UIImageView+WebCache.h"

static CGFloat const labelHeigh = 40;

@interface HaoBoNativeAdView ()<HaoBoShowAdBgViewDelegate>

@property (nonatomic,strong)HaoBoShowAdBgView *showAdBgView;
@property (nonatomic,strong)UIView *showAdView;
@property (nonatomic,strong)UILabel *headLineLabel;
@property (nonatomic,strong)UILabel *bodyLable;
@property (nonatomic,strong)UILabel *testsLable;
@property (nonatomic,strong)UILabel *bottomAdTipsLabel;
@property (nonatomic,strong)AdHubNativeAdDataModel *dataModel;

@end

@implementation HaoBoNativeAdView

- (void)dealloc
{
    [self.showAdBgView removeFromSuperview];
    self.showAdBgView = nil;
    [self.showAdView removeFromSuperview];
    self.showAdView = nil;
    self.dataModel = nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [[UIApplication sharedApplication].keyWindow addSubview:self.showAdBgView];
        [self setShowAdBgViewConstraint];
        
        [self.showAdBgView addSubview:self.showAdView];
        [self setShowAdViewConstraint];
    }
    return self;
}

- (void)showOneImageThreeTextAd:(AdHubNative *)ad
{
    AdHubNativeAdDataModel *dataModel = ad.adDataModels[0];
    self.dataModel = dataModel;
    
    [self.showAdView addSubview:self.headLineLabel];
    [self setHeadLineLabelConstraint];
    self.headLineLabel.text = @"暂无介绍";
    if (dataModel.headLine.length) {
        self.headLineLabel.text = dataModel.headLine;
    }
    
    [self.showAdView addSubview:self.bodyLable];
    [self setBodyLableConstraint];
    self.bodyLable.text = @"暂无介绍";
    if (dataModel.body.length) {
        self.bodyLable.text = dataModel.body;
    }
    [self.showAdView addSubview:self.bottomAdTipsLabel];
    [self setBottomAdTipsLabelConstraint];
    
    [self.showAdView addSubview:self.testsLable];
    [self setTestsLabelConstraint];
    for (NSString *str in dataModel.texts) {
        self.testsLable.text = [str stringByAppendingString:str];
    }
    
    UIImageView *adImage = [[UIImageView alloc]init];
    adImage.userInteractionEnabled = YES;
    [adImage setTranslatesAutoresizingMaskIntoConstraints:NO];
    [adImage addGestureRecognizer:[self tapGestureRecognizer]];
    [self.showAdView addSubview:adImage];
    if ([HaoBoUtls currentSystemVersion_iOS8]) {
        [NSLayoutConstraint activateConstraints:@[
                                                  [NSLayoutConstraint constraintWithItem:adImage attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bodyLable attribute:NSLayoutAttributeBottom multiplier:1 constant:0],
                                                  [NSLayoutConstraint constraintWithItem:adImage attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.showAdView attribute:NSLayoutAttributeLeft multiplier:1 constant:10],
                                                  [NSLayoutConstraint constraintWithItem:adImage attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.showAdView attribute:NSLayoutAttributeRight multiplier:1 constant:-10],
                                                  [NSLayoutConstraint constraintWithItem:adImage attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.testsLable attribute:NSLayoutAttributeTop multiplier:1 constant:-10],
                                                  ]];
    }
    else{
        [self.showAdView addConstraints:@[
                                          [NSLayoutConstraint constraintWithItem:adImage attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bodyLable attribute:NSLayoutAttributeBottom multiplier:1 constant:0],
                                          [NSLayoutConstraint constraintWithItem:adImage attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.showAdView attribute:NSLayoutAttributeLeft multiplier:1 constant:10],
                                          [NSLayoutConstraint constraintWithItem:adImage attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.showAdView attribute:NSLayoutAttributeRight multiplier:1 constant:-10],
                                          [NSLayoutConstraint constraintWithItem:adImage attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.testsLable attribute:NSLayoutAttributeTop multiplier:1 constant:-10],
                                          ]];
    }

    NSString *imagePath = dataModel.imageUrlString;
    if (!imagePath.length) {
        if (dataModel.images.count) {
            imagePath = dataModel.images.firstObject;
        }
    }
    [adImage sd_setImageWithURL:[NSURL URLWithString:imagePath]completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!error) {
            if ([self.delegate respondsToSelector:@selector(adImageAlreadyLoad:)]) {
                [self.delegate adImageAlreadyLoad:dataModel];
            }
        }
    }];
}

- (void)showOneTextThreeImageAd:(AdHubNative *)ad
{
    AdHubNativeAdDataModel *dataModel = ad.adDataModels[0];
    
    [self.showAdView addSubview:self.headLineLabel];
    [self setHeadLineLabelConstraint];
    self.headLineLabel.text = @"暂无介绍";
    if (dataModel.headLine.length) {
        self.headLineLabel.text = dataModel.headLine;
    }

    for (int i = 0; i < dataModel.images.count; i++) {
        NSString *imagePath = dataModel.images[i];
        UIImageView *adImage = [[UIImageView alloc]init];
        adImage.userInteractionEnabled = YES;
        [adImage setTranslatesAutoresizingMaskIntoConstraints:NO];
        [adImage addGestureRecognizer:[self tapGestureRecognizer]];
        [self.showAdView addSubview:adImage];
        if ([HaoBoUtls currentSystemVersion_iOS8]) {
            [NSLayoutConstraint activateConstraints:@[
                                                      [NSLayoutConstraint constraintWithItem:adImage attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.headLineLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:10],
                                                      [NSLayoutConstraint constraintWithItem:adImage attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.showAdView attribute:NSLayoutAttributeLeft multiplier:1 constant:5 + 105 * i],
                                                      [NSLayoutConstraint constraintWithItem:adImage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:100],
                                                      [NSLayoutConstraint constraintWithItem:adImage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:100],
                                                      ]];
        }
        else{
            [self.showAdView addConstraints:@[
                                              [NSLayoutConstraint constraintWithItem:adImage attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.headLineLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:10],
                                              [NSLayoutConstraint constraintWithItem:adImage attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.showAdView attribute:NSLayoutAttributeLeft multiplier:1 constant:5 + 105 * i],
                                              [NSLayoutConstraint constraintWithItem:adImage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:100],
                                              [NSLayoutConstraint constraintWithItem:adImage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:100],
                                              ]];
        }
        
        [adImage sd_setImageWithURL:[NSURL URLWithString:imagePath]completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
           
            if (i == dataModel.images.count - 1) {
                if (!error) {
                    if ([self.delegate respondsToSelector:@selector(adImageAlreadyLoad:)]) {
                        [self.delegate adImageAlreadyLoad:dataModel];
                    }
                }
            }
        }];
    }
    [self.showAdView addSubview:self.bottomAdTipsLabel];
    [self setBottomAdTipsLabelConstraint];
    
    [self.showAdView addSubview:self.testsLable];
    [self setTestsLabelConstraint];
    for (NSString *str in dataModel.texts) {
        self.testsLable.text = [str stringByAppendingString:str];
    }
}

#pragma mark - lazy load
- (UILabel *)headLineLabel
{
    if (!_headLineLabel) {
        _headLineLabel = [self label];
    }
    return _headLineLabel;
}

- (void)setHeadLineLabelConstraint
{
    if ([HaoBoUtls currentSystemVersion_iOS8]) {
        [NSLayoutConstraint activateConstraints:@[
                                                  [NSLayoutConstraint constraintWithItem:self.headLineLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.showAdView attribute:NSLayoutAttributeTop multiplier:1 constant:10],
                                                  [NSLayoutConstraint constraintWithItem:self.headLineLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.showAdView attribute:NSLayoutAttributeLeft multiplier:1 constant:10],
                                                  [NSLayoutConstraint constraintWithItem:self.headLineLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.showAdView attribute:NSLayoutAttributeRight multiplier:1 constant:-10],
                                                  [NSLayoutConstraint constraintWithItem:self.headLineLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:labelHeigh],
                                                  ]];
    }
    else{
        [self.showAdView addConstraints:@[
                                          [NSLayoutConstraint constraintWithItem:self.headLineLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.showAdView attribute:NSLayoutAttributeTop multiplier:1 constant:10],
                                          [NSLayoutConstraint constraintWithItem:self.headLineLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.showAdView attribute:NSLayoutAttributeLeft multiplier:1 constant:10],
                                          [NSLayoutConstraint constraintWithItem:self.headLineLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.showAdView attribute:NSLayoutAttributeRight multiplier:1 constant:-10],
                                          [NSLayoutConstraint constraintWithItem:self.headLineLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:labelHeigh],
                                          ]];
    }
}

- (UILabel *)bodyLable
{
    if (!_bodyLable) {
        _bodyLable = [self label];
    }
    return _bodyLable;
}

- (void)setBodyLableConstraint
{
    if ([HaoBoUtls currentSystemVersion_iOS8]) {
        [NSLayoutConstraint activateConstraints:@[
                                                  [NSLayoutConstraint constraintWithItem:self.bodyLable attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.headLineLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:10],
                                                  [NSLayoutConstraint constraintWithItem:self.bodyLable attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.showAdView attribute:NSLayoutAttributeLeft multiplier:1 constant:10],
                                                  [NSLayoutConstraint constraintWithItem:self.bodyLable attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.showAdView attribute:NSLayoutAttributeRight multiplier:1 constant:-10],
                                                  [NSLayoutConstraint constraintWithItem:self.bodyLable attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:labelHeigh],
                                                  ]];
    }
    else{
        [self.showAdView addConstraints:@[
                                          [NSLayoutConstraint constraintWithItem:self.bodyLable attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.headLineLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:10],
                                          [NSLayoutConstraint constraintWithItem:self.bodyLable attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.showAdView attribute:NSLayoutAttributeLeft multiplier:1 constant:10],
                                          [NSLayoutConstraint constraintWithItem:self.bodyLable attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.showAdView attribute:NSLayoutAttributeRight multiplier:1 constant:-10],
                                          [NSLayoutConstraint constraintWithItem:self.bodyLable attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:labelHeigh],
                                          ]];
    }
}

- (UILabel *)bottomAdTipsLabel
{
    if (!_bottomAdTipsLabel) {
        _bottomAdTipsLabel = [self label];
        _bottomAdTipsLabel.textColor = [UIColor blueColor];
        _bottomAdTipsLabel.layer.cornerRadius = .5;
        _bottomAdTipsLabel.layer.borderColor = _bottomAdTipsLabel.backgroundColor.CGColor;
        _bottomAdTipsLabel.layer.borderWidth = 1;
        _bottomAdTipsLabel.text = @"广告";
    }
    return _bottomAdTipsLabel;
}

- (void)setBottomAdTipsLabelConstraint
{
    if ([HaoBoUtls currentSystemVersion_iOS8]) {
        [NSLayoutConstraint activateConstraints:@[
                                                  [NSLayoutConstraint constraintWithItem:self.bottomAdTipsLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.showAdView attribute:NSLayoutAttributeBottom multiplier:1 constant:-labelHeigh - 10],
                                                  [NSLayoutConstraint constraintWithItem:self.bottomAdTipsLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.showAdView attribute:NSLayoutAttributeLeft multiplier:1 constant:10],
                                                  [NSLayoutConstraint constraintWithItem:self.bottomAdTipsLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50],
                                                  [NSLayoutConstraint constraintWithItem:self.bottomAdTipsLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:labelHeigh],
                                                  ]];
    }
    else{
        [self.showAdView addConstraints:@[
                                          [NSLayoutConstraint constraintWithItem:self.bottomAdTipsLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.showAdView attribute:NSLayoutAttributeBottom multiplier:1 constant:-labelHeigh - 10],
                                          [NSLayoutConstraint constraintWithItem:self.bottomAdTipsLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.showAdView attribute:NSLayoutAttributeLeft multiplier:1 constant:10],
                                          [NSLayoutConstraint constraintWithItem:self.bottomAdTipsLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50],
                                          [NSLayoutConstraint constraintWithItem:self.bottomAdTipsLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:labelHeigh],
                                          ]];
    }
}

- (UILabel *)testsLable
{
    if (!_testsLable) {
        _testsLable = [self label];
    }
    return _testsLable;
}

- (void)setTestsLabelConstraint
{
    if ([HaoBoUtls currentSystemVersion_iOS8]) {
        [NSLayoutConstraint activateConstraints:@[
                                                  [NSLayoutConstraint constraintWithItem:self.testsLable attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.showAdView attribute:NSLayoutAttributeBottom multiplier:1 constant:-labelHeigh - 10],
                                                  [NSLayoutConstraint constraintWithItem:self.testsLable attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bottomAdTipsLabel attribute:NSLayoutAttributeRight multiplier:1 constant:10],
                                                  [NSLayoutConstraint constraintWithItem:self.testsLable attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.showAdView attribute:NSLayoutAttributeRight multiplier:1 constant:-10],
                                                  [NSLayoutConstraint constraintWithItem:self.testsLable attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:labelHeigh],
                                                  ]];
    }
    else{
        [self.showAdView addConstraints:@[
                                          [NSLayoutConstraint constraintWithItem:self.testsLable attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.showAdView attribute:NSLayoutAttributeBottom multiplier:1 constant:-labelHeigh - 10],
                                          [NSLayoutConstraint constraintWithItem:self.testsLable attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.showAdView attribute:NSLayoutAttributeLeft multiplier:1 constant:10],
                                          [NSLayoutConstraint constraintWithItem:self.testsLable attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.showAdView attribute:NSLayoutAttributeRight multiplier:1 constant:-10],
                                          [NSLayoutConstraint constraintWithItem:self.testsLable attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:labelHeigh],
                                          ]];
    }
}

- (UILabel *)label
{
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor blackColor];
    label.numberOfLines = 2;
    label.font = [UIFont systemFontOfSize:18];
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    return label;
}

- (UIView *)showAdView
{
    if (!_showAdView) {
        _showAdView = [[UIView alloc]init];
        [_showAdView setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _showAdView;
}

- (void)setShowAdViewConstraint
{
    if ([HaoBoUtls currentSystemVersion_iOS8]) {
        [NSLayoutConstraint activateConstraints:@[
                                                  [NSLayoutConstraint constraintWithItem:self.showAdView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.showAdBgView attribute:NSLayoutAttributeTop multiplier:1 constant:50],
                                                  [NSLayoutConstraint constraintWithItem:self.showAdView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.showAdBgView attribute:NSLayoutAttributeLeft multiplier:1 constant:0],
                                                  [NSLayoutConstraint constraintWithItem:self.showAdView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.showAdBgView attribute:NSLayoutAttributeRight multiplier:1 constant:0],
                                                  [NSLayoutConstraint constraintWithItem:self.showAdView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.showAdBgView attribute:NSLayoutAttributeBottom multiplier:1 constant:50],
                                                  ]];
    }
    else{
        [self.showAdBgView addConstraints:@[
                                            [NSLayoutConstraint constraintWithItem:self.showAdView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.showAdBgView attribute:NSLayoutAttributeTop multiplier:1 constant:50],
                                            [NSLayoutConstraint constraintWithItem:self.showAdView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.showAdBgView attribute:NSLayoutAttributeLeft multiplier:1 constant:0],
                                            [NSLayoutConstraint constraintWithItem:self.showAdView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.showAdBgView attribute:NSLayoutAttributeRight multiplier:1 constant:0],
                                            [NSLayoutConstraint constraintWithItem:self.showAdView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.showAdBgView attribute:NSLayoutAttributeBottom multiplier:1 constant:50],
                                            ]];
    }
}

- (HaoBoShowAdBgView *)showAdBgView
{
    if (!_showAdBgView) {
        _showAdBgView = [[HaoBoShowAdBgView alloc]initWithFrame:CGRectZero];
        _showAdBgView.backgroundColor = [UIColor whiteColor];
        _showAdBgView.delegate = self;
        [_showAdBgView setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _showAdBgView;
}

- (void)setShowAdBgViewConstraint
{
    if ([HaoBoUtls currentSystemVersion_iOS8]) {
        [NSLayoutConstraint activateConstraints:@[
                                                  [NSLayoutConstraint constraintWithItem:self.showAdBgView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:[UIApplication sharedApplication].keyWindow attribute:NSLayoutAttributeTop multiplier:1 constant:0],
                                                  [NSLayoutConstraint constraintWithItem:self.showAdBgView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:[UIApplication sharedApplication].keyWindow attribute:NSLayoutAttributeLeft multiplier:1 constant:0],
                                                  [NSLayoutConstraint constraintWithItem:self.showAdBgView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:[UIApplication sharedApplication].keyWindow attribute:NSLayoutAttributeRight multiplier:1 constant:0],
                                                  [NSLayoutConstraint constraintWithItem:self.showAdBgView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:[UIApplication sharedApplication].keyWindow attribute:NSLayoutAttributeBottom multiplier:1 constant:0],
                                                  ]];
    }
    else{
        [[UIApplication sharedApplication].keyWindow addConstraints:@[
                                                                      [NSLayoutConstraint constraintWithItem:self.showAdBgView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:[UIApplication sharedApplication].keyWindow attribute:NSLayoutAttributeTop multiplier:1 constant:0],
                                                                      [NSLayoutConstraint constraintWithItem:self.showAdBgView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:[UIApplication sharedApplication].keyWindow attribute:NSLayoutAttributeLeft multiplier:1 constant:0],
                                                                      [NSLayoutConstraint constraintWithItem:self.showAdBgView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:[UIApplication sharedApplication].keyWindow attribute:NSLayoutAttributeRight multiplier:1 constant:0],
                                                                      [NSLayoutConstraint constraintWithItem:self.showAdBgView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:[UIApplication sharedApplication].keyWindow attribute:NSLayoutAttributeBottom multiplier:1 constant:0],
                                                                      ]];
    }
}

- (void)showAdBgViewCloseBtnClick
{
    [self.showAdBgView removeFromSuperview];
    self.showAdBgView = nil;
    if ([self.delegate respondsToSelector:@selector(closeBtnClick)]) {
        [self.delegate closeBtnClick];
    }
}

- (void)adContentShowInBgView
{
    [[UIApplication sharedApplication].keyWindow addSubview:self.showAdBgView];
    [self setShowAdBgViewConstraint];
}

- (BOOL)objcIsArray:(id)objc
{
    if ([objc isKindOfClass:[NSArray class]]) {
        NSArray *array = (NSArray *)objc;
        if (array.count) {
            return YES;
        }
        return NO;
    }
    return NO;
}

- (UITapGestureRecognizer *)tapGestureRecognizer
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    return tap;
}

- (void)tapClick
{
    if ([self.delegate respondsToSelector:@selector(clickImage:)]) {
        [self.delegate clickImage:self.dataModel];
    }
}

@end

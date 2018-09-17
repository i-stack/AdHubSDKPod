//
//  HaoBoNativeViewController.m
//  AdHubSDK
//
//  Created by Mac on 2017/7/1.
//  Copyright © 2017年 AdHub. All rights reserved.
//

#import "HaoBoNativeViewController.h"
#import "HaoBoNativeAdView.h"

@interface HaoBoNativeViewController ()<HaoBoNativeAdViewDelegate>

@property (nonatomic,assign)BOOL showOneImage;
@property (nonatomic,strong)HaoBoNativeAdView *adView;

- (IBAction)oneImageTwoText:(UIButton *)sender;
- (IBAction)threeImgeOneText:(UIButton *)sender;

@end

@implementation HaoBoNativeViewController

- (void)dealloc
{
    [self cleanAdView];
    QC_NSLog(@"%@ ----> dealloc", NSStringFromClass(self.class));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)oneImageTwoText:(UIButton *)sender
{
    self.showOneImage = YES;
    [self showNative:@"940"];
}

- (IBAction)threeImgeOneText:(UIButton *)sender
{
    self.showOneImage = NO;
    [self showNative:@"993"];
}

- (void)cleanAdView
{
    [self.adView removeFromSuperview];
    self.adView = nil;
}

- (HaoBoNativeAdView *)adView
{
    if (!_adView) {
        _adView = [[HaoBoNativeAdView alloc]init];
        _adView.delegate = self;
        [_adView setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _adView;
}

#pragma mark -- Native view delegate
// 点击曝光
- (void)clickImage:(AdHubNativeAdDataModel *)dataModel
{
    [self setNativeAdSDKOpenUrl:YES];
    if (self.native.sdkOpenAdClickUrl) {
        [self cleanAdView];
    }
    [self nativeClickExposeLog:dataModel];
    [self.native didClickAdDataModel:0];
}

// 展示曝光
- (void)adImageAlreadyLoad:(AdHubNativeAdDataModel *)dataModel
{
    [self.native didShowAdDataModel:0];
}

// 点击关闭按钮
- (void)closeBtnClick
{
    [self cleanAdView];
}

#pragma mark - Native ad overload
- (void)nativeDidLoaded:(AdHubNative *)ad
{
    [self cleanHUD];
    [self.view addSubview:self.adView];
    [self.adView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
    
    if (self.showOneImage) {
        [self.adView showOneImageThreeTextAd:ad];
    }
    else{
        [self.adView showOneTextThreeImageAd:ad];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

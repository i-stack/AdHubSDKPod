//
//  HaoBoRequstAdBaseViewController.m
//  AdHubSDK
//
//  Created by Mac on 2017/7/3.
//  Copyright © 2017年 AdHub. All rights reserved.
//

#import "HaoBoRequstAdBaseViewController.h"

@interface HaoBoRequstAdBaseViewController ()<AdHubBannerViewDelegate, AdHubInterstitialDelegate, AdHubSplashDelegate, AdHubCustomViewDelegate, AdHubRewardBasedVideoAdDelegate, AdHubNativeDelegate>

@property (nonatomic,strong)AdHubBannerView *banner;
@property (nonatomic,strong)AdHubInterstitial *interstitial;
@property (nonatomic,strong)AdHubSplash *splash;
@property (nonatomic,strong)UIView *customSplashView;
@property (nonatomic,strong)AdHubCustomView *custom;
@property (nonatomic,strong)AdHubNative *native;

@end

@implementation HaoBoRequstAdBaseViewController

- (void)dealloc
{
    [self.banner bannerCloseAd];
    [self.banner removeFromSuperview];
    self.banner = nil;
    [self.interstitial interstitialCloseAd];
    self.interstitial = nil;
    self.splash = nil;
    [self.customSplashView removeFromSuperview];
    self.customSplashView = nil;
    [self.custom customCloseAd];
    [self.custom removeFromSuperview];
    self.custom = nil;
    self.native = nil;
    self.splash = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    __weak typeof(self)weakSelf = self;
    self.bgViewCloseBlock = ^{
        [weakSelf.banner bannerCloseAd];
        weakSelf.banner = nil;
        [weakSelf.interstitial interstitialCloseAd];
        weakSelf.interstitial = nil;
        weakSelf.splash = nil;
        [weakSelf.customSplashView removeFromSuperview];
        weakSelf.customSplashView = nil;
        [weakSelf.custom customCloseAd];
        [weakSelf.custom removeFromSuperview];
        weakSelf.custom = nil;
        [weakSelf.custom customCloseAd];
        weakSelf.custom = nil;
        weakSelf.native = nil;
    };
}

#pragma mark - BannerView Ad
- (void)showBanner:(NSString *)spaceID
{
    [self showHUD];
    self.banner = [[AdHubBannerView alloc] initWithSpaceID:spaceID spaceParam:[HaoBoSpaceInfo sharedInstall].spacefParam];
    self.banner.delegate = self;
    [self.banner loadAd];
}

- (UIViewController *)adBannerViewControllerForPresentingModalView
{
    return self;
}

- (void)adViewDidReceiveAd:(AdHubBannerView *)bannerView
{
    [self cleanHUD];
    [self adContentShowInBgView];
    [self.showAdBgView addSubview:bannerView];
    [bannerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.showAdBgView);
        make.width.equalTo(@(bannerView.frame.size.width));
        make.height.equalTo(@(bannerView.frame.size.height));
    }];
}

- (void)adViewDidDismissScreen:(AdHubBannerView *)bannerView
{
    
}

- (void)adView:(AdHubBannerView *)bannerView didFailToReceiveAdWithError:(AdHubRequestError *)error
{
    self.banner = nil;
    [self.showAdBgView removeFromSuperview];
    [self cleanHUD];
    if ([HaoBoUtls currentSystemVersion_iOS8]) {
        [self showAlertWithTitle:@"Error" message:[NSString stringWithFormat:@"%@", error]];
    }
}

- (void)adViewClicked:(NSString *)landingPageURL
{
    [self printLandingPageUrlTipMessage:landingPageURL];
    if (!landingPageURL.length) {
        [self showAdBgViewCloseBtnClick];
    }
}

#pragma mark - Interstitial Ad
- (void)showInterstitial:(NSString *)spaceID
{
    [self showHUD];
    self.interstitial = [[AdHubInterstitial alloc] initWithSpaceID:spaceID spaceParam:[HaoBoSpaceInfo sharedInstall].spacefParam];
    self.interstitial.delegate = self;
    self.interstitial.needAnimation = NO;
    [self.interstitial loadAd];
}

- (void)interstitialDidReceiveAd:(AdHubInterstitial *)ad
{
    [self cleanHUD];
    [self.interstitial presentFromRootViewController:self];
}

- (void)interstitialDidFailToPresentScreen:(AdHubInterstitial *)ad
{
    [self cleanHUD];
    if ([HaoBoUtls currentSystemVersion_iOS8]) {
        [self showAlertWithTitle:@"Error" message:@"present interstitial failed!"];
    }
}

- (void)interstitial:(AdHubInterstitial *)ad didFailToReceiveAdWithError:(AdHubRequestError *)error
{
    [self cleanHUD];
    if ([HaoBoUtls currentSystemVersion_iOS8]) {
        [self showAlertWithTitle:@"Error" message:[NSString stringWithFormat:@"%@", error]];
    }
}

- (void)interstitialDidClick:(NSString *)landingPageURL
{
    [self printLandingPageUrlTipMessage:landingPageURL];
}

#pragma mark - Splash Ad
- (void)showSplash:(NSString *)spaceID
{
    [self showHUD];
    self.customSplashView = [[UIView alloc]init];
    [[UIApplication sharedApplication].keyWindow addSubview:self.customSplashView];
    [self.customSplashView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.customSplashView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo([UIApplication sharedApplication].keyWindow);
    }];
    
    UIImageView *splashContainer = [[UIImageView alloc]initWithImage:[HaoBoUtls launchImage]];
    [splashContainer setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.customSplashView addSubview:splashContainer];
    [splashContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo([UIApplication sharedApplication].keyWindow);
    }];
    _splash = [[AdHubSplash alloc] initWithSpaceID:spaceID spaceParam:[HaoBoSpaceInfo sharedInstall].spacefParam];
    _splash.delegate = self;
    [_splash loadAndDisplayUsingContainerView:self.customSplashView];
}

- (UIViewController *)adSplashViewControllerForPresentingModalView
{
    return self;
}

- (void)splashDidReceiveAd:(AdHubSplash *)ad
{
    [self cleanHUD];
}

- (void)splash:(AdHubSplash *)ad didFailToLoadAdWithError:(AdHubRequestError *)error
{
    [self splashClean];
}

- (void)splashDidDismissScreen:(AdHubSplash *)ad
{
    [self splashClean];
}

- (void)splashDidClick:(NSString *)landingPageURL
{
    [self printLandingPageUrlTipMessage:landingPageURL];
    [_splash splashCloseAd];
}

- (void)splashDidPresentScreen:(AdHubSplash *)ad
{

}

- (void)splashClean
{
    [self cleanHUD];
    self.splash.delegate = nil;
    self.splash = nil;
    [self.customSplashView removeFromSuperview];
    self.customSplashView = nil;
}

#pragma mark - CustomView Ad
- (UIViewController *)adCustomViewControllerForPresentingModalView
{
    return self;
}

- (void)adCustomViewDidReceiveAd:(AdHubCustomView *)customView
{
    [self cleanHUD];
    [self adContentShowInBgView];
    [self.showAdBgView addSubview:customView];
    [customView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [customView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.showAdBgView);
        make.width.equalTo(@(customView.frame.size.width));
        make.height.equalTo(@(customView.frame.size.height));
    }];
}

- (void)adCustomViewDidDismissScreen:(AdHubCustomView *)customView
{
    _custom = nil;
}

- (void)adCustomView:(AdHubCustomView *)customView didFailToReceiveAdWithError:(AdHubRequestError *)error
{
    _custom = nil;
    [self cleanHUD];
    if ([HaoBoUtls currentSystemVersion_iOS8]) {
        [self showAlertWithTitle:@"Error" message:[NSString stringWithFormat:@"%@", error]];
    }
}

- (void)showCustom:(NSString *)spaceID
{
    [self showHUD];
    self.custom = [[AdHubCustomView alloc] initWithSpaceID:spaceID spaceParam:[HaoBoSpaceInfo sharedInstall].spacefParam];
    self.custom.frame = CGRectZero;
    self.custom.delegate = self;
    [self.custom loadAd];
}

- (void)customDidClick:(NSString *)landingPageURL
{
    [self printLandingPageUrlTipMessage:landingPageURL];
    if (!landingPageURL.length) {
        [self showAdBgViewCloseBtnClick];
    }
}

#pragma mark - RewardVideo Ad
- (void)showRewardVideo:(NSString *)spaceID
{
    [self showHUD];
    [AdHubRewardBasedVideoAd sharedInstance].delegate = self;
    [[AdHubRewardBasedVideoAd sharedInstance] loadAdWithSpaceID:spaceID spaceParam:[HaoBoSpaceInfo sharedInstall].spacefParam];
}

- (UIViewController *)adRewardViewControllerForPresentingModalView
{
    return self;
}

- (void)rewardBasedVideoAdDidReceiveAd:(AdHubRewardBasedVideoAd *)rewardBasedVideoAd
{
    [self cleanHUD];
    [[AdHubRewardBasedVideoAd sharedInstance] presentFromRootViewController:self];
}

- (void)rewardBasedVideoAd:(AdHubRewardBasedVideoAd *)rewardBasedVideoAd didRewardUserWithReward:(NSObject *)reward
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"得到奖励" message:(NSString *)reward preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:NULL];
}

- (void)rewardBasedVideoAd:(AdHubRewardBasedVideoAd *)rewardBasedVideoAd didFailToLoadWithError:(AdHubRequestError *)error
{
    [self cleanHUD];
    if ([HaoBoUtls currentSystemVersion_iOS8]) {
        [self showAlertWithTitle:@"Error" message:[NSString stringWithFormat:@"%@", error]];
    }
}

#pragma mark - Native ad
- (void)showNative:(NSString *)spaceID
{
    [self showHUD];
    // 原生广告的创建与初始化
    self.native = [[AdHubNative alloc] initWithSpaceID:spaceID spaceParam:[HaoBoSpaceInfo sharedInstall].spacefParam];
    self.native.delegate = self;
    self.native.sdkOpenAdClickUrl = YES;
    // 原生广告请求开始
    [self.native loadAd];
}

- (void)nativeDidLoaded:(AdHubNative *)ad
{
    [self cleanHUD];
    AdHubNativeAdDataModel *dataModel = ad.adDataModels[0];
    
    NSString *text = [self objcIsArray:dataModel.texts] ? [dataModel.texts componentsJoinedByString:@"---"] : @"";
    NSString *image = [self objcIsArray:dataModel.images] ? [dataModel.images componentsJoinedByString:@"---"] : @"";
    NSString *video = [self objcIsArray:dataModel.videos] ? [dataModel.videos componentsJoinedByString:@"---"] : @"";
    
    NSString *message = [NSString stringWithFormat:@"headLine:%@\nimage:%@\nbody:%@\naction:%@\ntexts:%@\nimages:%@\nvideos:%@\nlandingUrl:%@\nlogoUrlString:%@\nadvertiser:%@\nappIconUrlString:%@\nstar:%@\nstore:%@\nprice:%@", dataModel.headLine, dataModel.imageUrlString, dataModel.body, dataModel.action, text, image, video, dataModel.landingUrl, dataModel.logoUrlString, dataModel.advertiser, dataModel.appIconUrlString, dataModel.star, dataModel.store, dataModel.price];
    [self showAlertWithTitle:@"This is Native Ad" message:message withHandler:^{
        [self nativeClickExposeLog:dataModel];
    }];
    
    [self nativeShowExposeLog:dataModel];
}

- (void)nativeDidClick:(NSString *)tipMessage
{
    [self printLandingPageUrlTipMessage:tipMessage];
}

- (void)native:(AdHubNative *)ad didFailToLoadAdWithError:(AdHubRequestError *)error
{
    [self cleanHUD];
    self.native = nil;
    if ([HaoBoUtls currentSystemVersion_iOS8]) {
        [self showAlertWithTitle:@"Error" message:[NSString stringWithFormat:@"%@", error]];
    }
}

- (UIView *)adNativeShowView
{
    return self.view;
}

- (UIViewController *)adNativeViewControllerForPresentingAdDetail
{
    return self;
}

- (void)nativeShowExposeLog:(AdHubNativeAdDataModel *)dataModel
{
    [self.native didShowAdDataModel:0];
}

- (void)nativeClickExposeLog:(AdHubNativeAdDataModel *)dataModel
{
    [self.native didClickAdDataModel:0];
}

- (void)setNativeAdSDKOpenUrl:(BOOL)state
{
    self.native.sdkOpenAdClickUrl = state;
}

- (void)printLandingPageUrlTipMessage:(NSString *)landingPageUrl
{
    if (landingPageUrl.length) {
        NSLog(@"----------------%@----------------", landingPageUrl);
    }
    else{
        NSLog(@"landingPageUrl 返回为空时, 说明广告已经被打开!");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  HaoBoViewController.m
//  AdHubSDK
//
//  Created by songMW on 05/21/2017.
//  Copyright (c) 2017 AdHub. All rights reserved.
//

#import "HaoBoViewController.h"
#import "HaoBoHomeView.h"
#import "HaoBoShowAdBgView.h"

@interface HaoBoViewController ()<HaoBoHomeViewDelegate>

@property (nonatomic,strong)HaoBoHomeView *homeView;

@end

@implementation HaoBoViewController

- (void)dealloc
{
    [self.homeView removeFromSuperview];
    self.homeView = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _analogyopenState = NO;
    [self.view addSubview:self.homeView];
    [self.homeView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11, *)) {
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        }
        else{
            make.top.left.right.equalTo(@(0));
            make.bottom.equalTo(@(-kHaoBo_tabBarHeight));
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - 开始请求
- (void)beginRequstAd:(HaoBoRequestAdType)adType
{
    // 注册 APPID
    [AdHubSDKManager configureWithApplicationID:[HaoBoSpaceInfo sharedInstall].appID];
    switch (adType) {
        case HaoBoRequestAdType_intersitial:
            if (_analogyopenState){
                [self analogyAdMoreClick:[HaoBoSpaceInfo sharedInstall].intersitialSpaceID type:AnalogyRequestType_interstitial];
                return;
            }
            [self showInterstitial:[HaoBoSpaceInfo sharedInstall].intersitialSpaceID];
            break;
            
        case HaoBoRequestAdType_banner:
            if (_analogyopenState){
                [self analogyAdMoreClick:[HaoBoSpaceInfo sharedInstall].bannerSpaceID type:AnalogyRequestType_banner];
                return;
            }
            
            [self showBanner:[HaoBoSpaceInfo sharedInstall].bannerSpaceID];
            break;
            
        case HaoBoRequestAdType_reward_video:
            if (_analogyopenState){
                [self analogyAdMoreClick:[HaoBoSpaceInfo sharedInstall].rewardVideoSpaceID type:AnalogyRequestType_rewardVideo];
                return;
            }
            [self showRewardVideo:[HaoBoSpaceInfo sharedInstall].rewardVideoSpaceID];
            break;
            
        case HaoBoRequestAdType_custom:
            if (_analogyopenState){
                [self analogyAdMoreClick:[HaoBoSpaceInfo sharedInstall].customSpaceID type:AnalogyRequestType_custom];
                return;
            }
            [self showCustom:[HaoBoSpaceInfo sharedInstall].customSpaceID];
            break;
            
        case HaoBoRequestAdType_native:
            if (_analogyopenState){
                [self analogyAdMoreClick:[HaoBoSpaceInfo sharedInstall].nativeSpaceID type:AnalogyRequestType_native];
                return;
            }
            [self showNative:[HaoBoSpaceInfo sharedInstall].nativeSpaceID];
            break;
            
        case HaoBoRequestAdType_splash:
            if (_analogyopenState){
                [self analogyAdMoreClick:[HaoBoSpaceInfo sharedInstall].splashSpaceID type:AnalogyRequestType_splash];
                return;
            }
            [self showSplash:[HaoBoSpaceInfo sharedInstall].splashSpaceID];
            break;
            
        default:
            break;
    }
}

#pragma mark - HaoBoHomeView delegate
- (UIViewController *)presentTextFieldVC
{
    return self;
}

- (void)submitLogEvent
{
    [self showTextInputAlertWithTitle:@"input event id" message:@"custom tag info" textFieldCount:1 placeHolders:@[@"eventid"] confirmBlock:^(NSArray *textArray) {
        NSString *eventId = textArray[0];
        [HaoBoUtls userDefaultSetKey:kHaoBo_logEvent value:eventId];
        if (eventId.length){
            [AdHubSDKManager logEvent:eventId];
            [self showToast:@"submitted"];
        }
    }];
}

- (void)showLog
{
    [iConsole show];
}

#pragma mark - 模拟多次请求
- (void)analogyAdMoreClick:(NSString *)spaceID type:(AnalogyRequestType)type
{

}

#pragma mark - other utls
- (void)showToast:(NSString *)toastString
{
    [self.view makeToast:toastString duration:1.0 position:CSToastPositionCenter];
}

#pragma mark - lazy load
- (HaoBoHomeView *)homeView
{
    if (!_homeView) {
        _homeView = [[HaoBoHomeView alloc]init];
        _homeView.delegate = self;
        [_homeView setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _homeView;
}

- (void)analogyAdMoreClick:(BOOL)openState
{
    _analogyopenState = openState;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  HaoboViewController.m
//  AdHubSDKPod
//
//  Created by songMW on 08/10/2017.
//  Copyright (c) 2017 songMW. All rights reserved.
//

#import "HaoboViewController.h"
#import <AdHubSDK/AdHubSDK.h>

@interface HaoboViewController ()<AdHubBannerViewDelegate>

@property (nonatomic,strong)AdHubBannerView *bannerView;

@end

@implementation HaoboViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [AdHubSDKManager configureWithApplicationID:@"276"];
    [self.bannerView loadAd];
}

- (UIViewController *)adBannerViewControllerForPresentingModalView
{
    return self;
}

- (void)adViewDidReceiveAd:(AdHubBannerView *)bannerView
{
    [self.view addSubview:bannerView];
}

- (void)adViewDidDismissScreen:(AdHubBannerView *)bannerView
{
    self.bannerView = nil;
}

- (void)adView:(AdHubBannerView *)bannerView didFailToReceiveAdWithError:(AdHubRequestError *)error
{
    self.bannerView = nil;
}

- (void)adViewClicked:(NSString *)landingPageURL
{
    NSLog(@"%s-------------------%@-------------------", __FUNCTION__, landingPageURL);
}

- (AdHubBannerView *)bannerView
{
    if (!_bannerView) {
        _bannerView = [[AdHubBannerView alloc]initWithSpaceID:@"910" spaceParam:@""];
        _bannerView.delegate = self;
    }
    return _bannerView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

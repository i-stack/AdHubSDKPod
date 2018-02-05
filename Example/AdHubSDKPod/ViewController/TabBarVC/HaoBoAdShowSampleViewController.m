//
//  HaoBoAdShowSampleViewController.m
//  AdHubSDK
//
//  Created by Mac on 2017/7/1.
//  Copyright © 2017年 AdHub. All rights reserved.
//

#import "HaoBoAdShowSampleViewController.h"
#import "HaoBoAdShowSampleView.h"
#import "HaoBoBannerViewController.h"
#import "HaoBoInterstitialViewController.h"
#import "HaoBoSplashViewController.h"
#import "HaoBoNativeViewController.h"

@interface HaoBoAdShowSampleViewController ()<HaoBoAdShowSampleViewDelegate>

@property (nonatomic,strong)HaoBoAdShowSampleView *sampleView;

@end

@implementation HaoBoAdShowSampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.sampleView];
    [self.sampleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@(0));
        make.bottom.equalTo(@(0)).offset(-kHaoBo_tabBarHeight);
    }];
}

- (void)clickCellToShowAd:(AnalogyRequestType)type
{
    switch (type) {
        case AnalogyRequestType_interstitial:{
            HaoBoInterstitialViewController *vc = [[HaoBoInterstitialViewController alloc]initWithNibName:@"HaoBoInterstitialViewController" bundle:nil];
            vc.title = @"插屏";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case AnalogyRequestType_banner:{
            HaoBoBannerViewController *vc = [[HaoBoBannerViewController alloc]initWithNibName:@"HaoBoBannerViewController" bundle:nil];
            vc.title = @"Banner";
            [self.navigationController pushViewController:vc animated:YES];
        }
            
            break;
        case AnalogyRequestType_custom:{
            [self showCustom:[HaoBoSpaceInfo sharedInstall].customSpaceID];
        }
            
            break;
        case AnalogyRequestType_rewardVideo:{
            [self showRewardVideo:[HaoBoSpaceInfo sharedInstall].rewardVideoSpaceID];
        }
            
            break;
        case AnalogyRequestType_splash:{
            HaoBoSplashViewController *vc = [[HaoBoSplashViewController alloc]initWithNibName:@"HaoBoSplashViewController" bundle:nil];
            vc.title = @"开屏";
            [self.navigationController pushViewController:vc animated:YES];
        }
            
            break;
        case AnalogyRequestType_native:{
            HaoBoNativeViewController *vc = [[HaoBoNativeViewController alloc]initWithNibName:@"HaoBoNativeViewController" bundle:nil];
            vc.title = @"原生";
            [self.navigationController pushViewController:vc animated:YES];
        }
            
            break;
        default:
            break;
    }
}

#pragma mark - lazy load
- (HaoBoAdShowSampleView *)sampleView
{
    if (!_sampleView) {
        _sampleView = [[HaoBoAdShowSampleView alloc]init];
        _sampleView.delegate = self;
        [_sampleView setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _sampleView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

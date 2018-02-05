//
//  HaoBoBannerViewController.m
//  AdHubSDK
//
//  Created by Mac on 2017/7/1.
//  Copyright © 2017年 AdHub. All rights reserved.
//

#import "HaoBoBannerViewController.h"

@interface HaoBoBannerViewController ()

- (IBAction)requestImageAd:(UIButton *)sender;
- (IBAction)requestTextAd:(UIButton *)sender;
- (IBAction)requestLinkerAd:(UIButton *)sender;
- (IBAction)requestHTMLAd:(UIButton *)sender;

@end

@implementation HaoBoBannerViewController

- (void)dealloc
{
    QC_NSLog(@"%@ ----> dealloc", NSStringFromClass(self.class));
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)requestImageAd:(UIButton *)sender
{
    [self showBanner:@"910"];
}

- (IBAction)requestTextAd:(UIButton *)sender
{
    [self showBanner:@"911"];
}

- (IBAction)requestLinkerAd:(UIButton *)sender
{
    [self showBanner:@"912"];
}

- (IBAction)requestHTMLAd:(UIButton *)sender
{
    [self showBanner:@"913"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

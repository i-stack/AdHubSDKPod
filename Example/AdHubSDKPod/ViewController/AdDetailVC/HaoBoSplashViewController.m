//
//  HaoBoSplashViewController.m
//  AdHubSDK
//
//  Created by Mac on 2017/7/1.
//  Copyright © 2017年 AdHub. All rights reserved.
//

#import "HaoBoSplashViewController.h"

@interface HaoBoSplashViewController ()

- (IBAction)requestTextAd:(UIButton *)sender;
- (IBAction)requestLinkerAd:(UIButton *)sender;
- (IBAction)requestHTMLAd:(UIButton *)sender;

@end

@implementation HaoBoSplashViewController

- (void)dealloc
{
    QC_NSLog(@"%@ ----> dealloc", NSStringFromClass(self.class));
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)requestTextAd:(UIButton *)sender
{
    [self showSplash:@"929"];
}

- (IBAction)requestLinkerAd:(UIButton *)sender
{
    [self showSplash:@"930"];
}

- (IBAction)requestHTMLAd:(UIButton *)sender
{
    [self showSplash:@"931"];
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

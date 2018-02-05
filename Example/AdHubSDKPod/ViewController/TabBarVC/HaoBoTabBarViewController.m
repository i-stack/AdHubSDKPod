//
//  HaoBoTabBarViewController.m
//  AdHubSDK
//
//  Created by Mac on 2017/7/1.
//  Copyright © 2017年 AdHub. All rights reserved.
//

#import "HaoBoTabBarViewController.h"
#import "HaoBoViewController.h"
#import "HaoBoAdShowSampleViewController.h"

@interface HaoBoTabBarViewController ()

@end

@implementation HaoBoTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"AdHubDemo";
    [self setViewControllers];
}

- (void)setViewControllers
{
    if (self.viewControllers.count) {
        return;
    }
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"AdHubSDKResources" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    
    HaoBoViewController *viewController = [[HaoBoViewController alloc]init];
    viewController.tabBarItem.title = @"测试广告";
    viewController.tabBarItem.image = [UIImage imageWithContentsOfFile:[bundle pathForResource:@"QC_shuaxin_d" ofType:@"png"]];
    
    HaoBoAdShowSampleViewController *adShowViewController = [[HaoBoAdShowSampleViewController alloc]init];
    adShowViewController.title = @"效果展示";
    adShowViewController.tabBarItem.image = [UIImage imageWithContentsOfFile:[bundle pathForResource:@"QC_shuaxin_d" ofType:@"png"]];
    
    self.viewControllers = @[viewController, adShowViewController];
    self.selectedIndex = 0;
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

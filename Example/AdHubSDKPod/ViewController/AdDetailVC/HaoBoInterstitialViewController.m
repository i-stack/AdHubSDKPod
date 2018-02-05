//
//  HaoBoInterstitialViewController.m
//  AdHubSDK
//
//  Created by Mac on 2017/7/1.
//  Copyright © 2017年 AdHub. All rights reserved.
//

#import "HaoBoInterstitialViewController.h"

typedef NS_ENUM(NSInteger, TopBtnClickType) {
    TopBtnClickType_left = 0,
    TopBtnClickType_middle,
    TopBtnClickType_right
};

@interface HaoBoInterstitialViewController ()<AdHubInterstitialDelegate>

@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *middleBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@property (nonatomic,assign)TopBtnClickType topBtnClickType;

- (IBAction)leftBtnClick:(UIButton *)sender;
- (IBAction)middleBtnClick:(UIButton *)sender;
- (IBAction)rightBtnClick:(UIButton *)sender;
- (IBAction)requestImageAd:(UIButton *)sender;
- (IBAction)requestTextAd:(UIButton *)sender;
- (IBAction)requestLinkerAd:(UIButton *)sender;
- (IBAction)requestHTMLAd:(UIButton *)sender;
- (IBAction)requestVideo:(UIButton *)sender;

@end

@implementation HaoBoInterstitialViewController

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"topBtnClickType"];
    QC_NSLog(@"%@ ----> dealloc", NSStringFromClass(self.class));
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addObserver:self forKeyPath:@"topBtnClickType" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    self.topBtnClickType = TopBtnClickType_left;
}

- (IBAction)leftBtnClick:(UIButton *)sender
{
    self.topBtnClickType = TopBtnClickType_left;
}

- (IBAction)middleBtnClick:(UIButton *)sender
{
    self.topBtnClickType = TopBtnClickType_middle;
}

- (IBAction)rightBtnClick:(UIButton *)sender
{
    self.topBtnClickType = TopBtnClickType_right;
}

- (IBAction)requestImageAd:(UIButton *)sender
{
    switch (self.topBtnClickType) {
        case TopBtnClickType_left:
            [self showInterstitial:@"914"];
            break;
        case TopBtnClickType_middle:
            [self showInterstitial:@"919"];
            break;
        case TopBtnClickType_right:
            [self showInterstitial:@"924"];
            break;
        default:
            break;
    }
}

- (IBAction)requestTextAd:(UIButton *)sender
{
    switch (self.topBtnClickType) {
        case TopBtnClickType_left:
            [self showInterstitial:@"915"];
            break;
        case TopBtnClickType_middle:
            [self showInterstitial:@"920"];
            break;
        case TopBtnClickType_right:
            [self showInterstitial:@"925"];
            break;
        default:
            break;
    }
}

- (IBAction)requestLinkerAd:(UIButton *)sender
{
    switch (self.topBtnClickType) {
        case TopBtnClickType_left:
            [self showInterstitial:@"916"];
            break;
        case TopBtnClickType_middle:
            [self showInterstitial:@"921"];
            break;
        case TopBtnClickType_right:
            [self showInterstitial:@"926"];
            break;
        default:
            break;
    }
}

- (IBAction)requestHTMLAd:(UIButton *)sender
{
    switch (self.topBtnClickType) {
        case TopBtnClickType_left:
            [self showInterstitial:@"917"];
            break;
        case TopBtnClickType_middle:
            [self showInterstitial:@"922"];
            break;
        case TopBtnClickType_right:
            [self showInterstitial:@"927"];
            break;
        default:
            break;
    }
}

- (IBAction)requestVideo:(UIButton *)sender
{
    switch (self.topBtnClickType) {
        case TopBtnClickType_left:
            [self showInterstitial:@"918"];
            break;
        case TopBtnClickType_middle:
            [self showInterstitial:@"923"];
            break;
        case TopBtnClickType_right:
            [self showInterstitial:@"928"];
            break;
        default:
            break;
    }
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"topBtnClickType"]) {
        NSInteger newValue = 0;
        if ([change valueForKey:@"new"] &&
            [[change valueForKey:@"new"] isKindOfClass:[NSNumber class]]) {
            newValue = [[change valueForKey:@"new"]integerValue];
        }
        if (newValue == 0) {
            [self.leftBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [self.middleBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [self.rightBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        }
        else if (newValue == 1) {
            [self.leftBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [self.middleBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [self.rightBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        }
        else if (newValue == 2) {
            [self.leftBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [self.middleBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [self.rightBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        }
    }
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

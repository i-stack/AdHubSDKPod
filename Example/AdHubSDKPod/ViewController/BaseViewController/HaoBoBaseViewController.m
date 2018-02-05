//
//  HaoBoBaseViewController.m
//  AdHubSDK
//
//  Created by Mac on 2017/6/22.
//  Copyright © 2017年 AdHub. All rights reserved.
//

#import "HaoBoBaseViewController.h"

@interface HaoBoBaseViewController ()<HaoBoShowAdBgViewDelegate>

@end

@implementation HaoBoBaseViewController

- (void)dealloc
{
    self.hud = nil;
    [self.showAdBgView removeFromSuperview];
    self.showAdBgView = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.bgViewCloseBlock = ^{};
    self.view.backgroundColor = [UIColor whiteColor];
    [AdHubSDKManager configureWithApplicationID:[HaoBoSpaceInfo sharedInstall].appID];
}

#pragma mark - HUD
- (void)showHUD
{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)cleanHUD
{
    [self.hud hideAnimated:YES];
    self.hud = nil;
}

#pragma mark - Demo Control
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message
{
    [self showAlertWithTitle:title message:message withHandler:nil];
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message withHandler:(void (^ __nullable)(void))handler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (handler) handler();
        });
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}

- (void)showTextInputAlertWithTitle:(NSString *)title message:(NSString *)message textFieldCount:(NSUInteger)count placeHolders:(NSArray *)placeHolders confirmBlock:(void(^)(NSArray *textArray))confirmBlock
{
    if ([HaoBoUtls currentSystemVersion] >= 8.0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        for (NSUInteger i = 0; i < count; i++){
            [alertController addTextFieldWithConfigurationHandler:^(UITextField *_Nonnull textField) {
                textField.keyboardType = UIKeyboardTypeAlphabet;
                textField.placeholder = placeHolders.count > i ? placeHolders[i] : nil;
            }];
        }
        [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
            NSMutableArray *textArray = [NSMutableArray array];
            for (UITextField *t in alertController.textFields){
                [textArray addObject:t.text.length ? t.text : @""];
            }
            if (confirmBlock)
                confirmBlock(textArray);
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark - lazy load 
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

- (void)showAdBgViewCloseBtnClick
{
    self.bgViewCloseBlock();
    [self.showAdBgView removeFromSuperview];
    self.showAdBgView = nil;
}

- (void)adContentShowInBgView
{
    [[UIApplication sharedApplication].keyWindow addSubview:self.showAdBgView];
    [self setShowAdBgViewConstraint];
}

- (void)setShowAdBgViewConstraint
{
    [self.showAdBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(@(0));
    }];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

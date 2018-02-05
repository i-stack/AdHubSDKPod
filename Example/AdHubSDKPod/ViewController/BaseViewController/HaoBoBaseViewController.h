//
//  HaoBoBaseViewController.h
//  AdHubSDK
//
//  Created by Mac on 2017/6/22.
//  Copyright © 2017年 AdHub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HaoBoShowAdBgView.h"

typedef void(^BgViewCloseBlock) (void);

@interface HaoBoBaseViewController : UIViewController
{
    BOOL _analogyopenState;
}

@property (nonatomic,strong)MBProgressHUD * _Nullable hud;
@property (nonatomic,strong)HaoBoShowAdBgView * _Nullable showAdBgView;
@property (nonatomic,strong)BgViewCloseBlock _Nonnull bgViewCloseBlock;

- (void)setShowAdBgViewConstraint;
- (void)adContentShowInBgView;
- (void)showAdBgViewCloseBtnClick;

- (void)showHUD;
- (void)cleanHUD;
- (void)showAlertWithTitle:(NSString *_Nullable)title message:(NSString *_Nullable)message;
- (void)showAlertWithTitle:(NSString *_Nullable)title message:(NSString *_Nullable)message withHandler:(void (^ __nullable)(void))handler;
- (void)showTextInputAlertWithTitle:(NSString *_Nullable)title message:(NSString *_Nullable)message textFieldCount:(NSUInteger)count placeHolders:(NSArray *_Nullable)placeHolders confirmBlock:(void(^_Nullable)(NSArray * _Nullable textArray))confirmBlock;
- (BOOL)objcIsArray:(id _Nullable )objc;

@end

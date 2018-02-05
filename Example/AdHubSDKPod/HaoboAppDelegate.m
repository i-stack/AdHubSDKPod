//
//  HaoBoAppDelegate.m
//  AdHubSDK
//
//  Created by songMW on 05/21/2017.
//  Copyright (c) 2017 AdHub. All rights reserved.
//

#import "HaoboAppDelegate.h"
#import "HaoboViewController.h"
#import "HaoBoTabBarViewController.h"

@interface HaoboAppDelegate ()<AdHubSplashDelegate>

@property (nonatomic,strong)AdHubSplash *splash;
@property (nonatomic,strong)UIView *customSplashView;

@end

@implementation HaoboAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [AdHubSDKManager configureDebugBlock:^(NSString * _Nonnull key, id  _Nonnull info) {
        [iConsole log:@"----- debug log of %@ -----", key];
        [iConsole log:@"%@", info];
        [iConsole log:@"----- debug log end -----"];
    }];
    [AdHubSDKManager configureWithApplicationID:[HaoBoSpaceInfo sharedInstall].appID];
    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[[HaoBoTabBarViewController alloc]init]];
    [self.window makeKeyAndVisible];
    [self showSplash];
    self.window.rootViewController.view.alpha = 0;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    
    return YES;
}

#pragma mark -- Splash Ad
- (void)showSplash
{
    self.customSplashView = [[UIView alloc]init];
    [self.window addSubview:self.customSplashView];
    [self.customSplashView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.customSplashView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.window);
    }];
    
    UIImageView *splashContainer = [[UIImageView alloc]initWithImage:[HaoBoUtls launchImage]];
    [splashContainer setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.customSplashView addSubview:splashContainer];
    [splashContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.customSplashView);
    }];
    
    _splash = [[AdHubSplash alloc] initWithSpaceID:[HaoBoSpaceInfo sharedInstall].splashSpaceID spaceParam:[HaoBoSpaceInfo sharedInstall].spacefParam];
    _splash.delegate = self;
    [_splash loadAndDisplayUsingContainerView:self.customSplashView];
}

- (UIViewController *)adSplashViewControllerForPresentingModalView
{
    return self.window.rootViewController;
}

- (void)splashDidReceiveAd:(AdHubSplash *)ad
{
    for (UIView *subView in self.customSplashView.subviews) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            [subView removeFromSuperview];
            break;
        }
    }
}

- (void)splash:(AdHubSplash *)ad didFailToLoadAdWithError:(AdHubRequestError *)error
{
    [self splashClean];
}

- (void)splashDidDismissScreen:(AdHubSplash *)ad
{
    [self splashClean];
}

- (void)splashDidClick:(NSString *)url
{
    [_splash splashCloseAd];
}

- (void)splashDidPresentScreen:(AdHubSplash *)ad
{
    
}

- (void)splashClean
{
    self.splash = nil;
    self.splash.delegate = nil;
    [self.customSplashView removeFromSuperview];
    self.customSplashView = nil;
    self.window.rootViewController.view.alpha = 1;
}

@end


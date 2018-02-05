//
//  HaoBoUtls.h
//  AdHubSDK
//
//  Created by Mac on 2017/6/23.
//  Copyright © 2017年 AdHub. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HaoBoUtls : NSObject

#ifdef DEBUG
#define QC_NSLog(...) NSLog(__VA_ARGS__)
#else
#define QC_NSLog(...)
#endif

typedef NS_ENUM(NSInteger, PathForDirectories) {
    PathForDirectories_Document = 0,
    PathForDirectories_Library = 1,
    PathForDirectories_Library_Cache = 2,
    PathForDirectories_Temp
};

typedef NS_ENUM(NSInteger, HaoBoCellBtnPosition) {
    HaoBoCellBtnPosition_left = 0,
    HaoBoCellBtnPosition_right,
    HaoBoCellBtnPosition_unknown
};

typedef NS_ENUM(NSInteger, HaoBoRequestAdType) {
    HaoBoRequestAdType_LogEvent = 0,
    HaoBoRequestAdType_intersitial,
    HaoBoRequestAdType_banner,
    HaoBoRequestAdType_reward_video,
    HaoBoRequestAdType_custom,
    HaoBoRequestAdType_native,
    HaoBoRequestAdType_splash,
    HaoBoRequestAdType_unknown
};

/**
 *  对接口字符串处理
 *
 *  @param object 任何对象
 *
 */
+ (NSString *)returnStr:(id)object;

//保存图片到 Cache
+ (void)saveImageToCache:(UIImage *)targetImage ImageName:(NSString *)imageName;
//从Cache 获取图片
+ (UIImage *)obtainImageFromCache:(NSString *)targetPath;
//本地是否存在当前图片
+ (BOOL)searchImageFromCache:(NSString *)searchImagePath;
//本地是否存在当前NSData
+ (NSData *)obtainDataFromCache:(NSString *)targetPath;
//从Cache 获取NSData
+ (void)saveDataToCache:(NSData *)data path:(NSString *)path;

/**
 *  移除特定文件夹
 *
 *  @param pathType 那个文件夹
 *  @param fileName 文件名称
 *
 */
+ (BOOL)removeFileFromPathForDirectories:(PathForDirectories)pathType fileName:(NSString *)fileName;

/**
 *  返回文字大小
 *
 *  @param targetText 要显示的文字
 *  @param size       限定显示文字的 size
 *  @param font       字体大小
 *
 *  @return 计算后文字的高度,宽度
 */
+ (CGSize)computerCurrentTextSize:(NSString *)targetText size:(CGSize)size font:(UIFont *)font;

//获取 Appstore id
+ (NSString *)itunesIdentifier:(NSString *)adUrlStr;

//获取当前系统版本号
+ (CGFloat)currentSystemVersion;
+ (BOOL)currentSystemVersion_iOS6;
+ (BOOL)currentSystemVersion_iOS7;
+ (BOOL)currentSystemVersion_iOS8;
+ (BOOL)currentSystemVersion_iOS9;
+ (BOOL)currentSystemVersion_iOS10;
+ (BOOL)currentSystemVersion_iOS11;
+ (BOOL)currentDeviceiPhoneX;

// 判断当前地址是否需要打开 appstore
+ (BOOL)isOpenAppstore:(NSString *)urlStr;

// UserDefault
+ (void)userDefaultSetKey:(NSString *)key value:(NSString *)value;
+ (NSString *)userDefualtForKey:(NSString *)key;
+ (void)userDefaultRemoveKey:(NSString *)key;

// 获取启动图
+ (UIImage *)launchImage;

@end

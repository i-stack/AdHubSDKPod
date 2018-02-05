//
//  HaoBoUtls.m
//  AdHubSDK
//
//  Created by Mac on 2017/6/23.
//  Copyright © 2017年 AdHub. All rights reserved.
//

#import "HaoBoUtls.h"

static NSString *const appstoredomain = @"itunes.apple.com";

@implementation HaoBoUtls

/**
 *  对接口字符串处理
 *
 *  @param object 任何对象
 *
 *  @return 处理后返回字符串
 */
+ (NSString *)returnStr:(id)object
{
    NSString *cnt = @"";
    if (![object isKindOfClass:[NSNull class]]) {
        if ([object isKindOfClass:[NSNumber class]]) {
            cnt = [NSString stringWithFormat:@"%@", object];
        }
        else if ([object isKindOfClass:[NSString class]]){
            NSString *str = [NSString stringWithFormat:@"%@", object];
            if (str.length) {
                if ([[str lowercaseString] rangeOfString:@"null"].location == NSNotFound) {
                    cnt = str;
                }
            }
        }
    }
    return cnt;
}

//返回文本大小
+ (CGSize)computerCurrentTextSize:(NSString *)targetText size:(CGSize)size font:(UIFont *)font
{
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    
    NSDictionary *attributes = @{ NSFontAttributeName : font, NSParagraphStyleAttributeName : style };
    CGRect rect = [targetText boundingRectWithSize:size
                                           options:opts
                                        attributes:attributes
                                           context:nil];
    return rect.size;
}

//保存图片到本地
+ (void)saveImageToCache:(UIImage *)targetImage ImageName:(NSString *)imageName
{
    NSString *cachePath = NSTemporaryDirectory();
    NSString *saveImagePath = [cachePath stringByAppendingPathComponent:@"Image"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:saveImagePath]) {
        BOOL createFile = [fileManager createDirectoryAtPath:saveImagePath withIntermediateDirectories:YES attributes:nil error:nil];
        if (createFile) {
            NSLog(@"%@ 文件夹创建成功",saveImagePath);
        }
        else{
            NSLog(@"%@ 文件夹创建失败",saveImagePath);
        }
    }
    
    imageName = [self detailImageUrl:imageName];
    saveImagePath = [saveImagePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",imageName]];
    
    //压缩保存
    NSData *imageData;
    NSRange range = [imageName rangeOfString:@".png"];
    if (range.location != NSNotFound) {
        imageData = UIImagePNGRepresentation(targetImage);
    }
    else{
        imageData = UIImageJPEGRepresentation(targetImage, 1.0);
    }
    BOOL flag = [imageData writeToFile:saveImagePath atomically:YES];
    if (flag) {
        NSLog(@"图片写入成功！");
    }
    else {
        NSLog(@"图片写入失败！");
    }
}

//从本地获取图片
+ (UIImage *)obtainImageFromCache:(NSString *)targetPath
{
    NSString *cachePath = NSTemporaryDirectory();
    targetPath = [self detailImageUrl:targetPath];
    NSString *imagePath = [cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"Image/%@",targetPath]];
    NSData *data = [NSData dataWithContentsOfFile:imagePath];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}

//从本地查找是否存在当前图片
+ (BOOL)searchImageFromCache:(NSString *)searchImagePath
{
    NSString *cachePath = NSTemporaryDirectory();
    searchImagePath = [self detailImageUrl:searchImagePath];
    NSString *imagePath = [cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"Image/%@",searchImagePath]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:imagePath]) {
        return YES;
    }
    return NO;
}

//移除指定文件夹
+ (BOOL)removeFileFromPathForDirectories:(PathForDirectories)pathType fileName:(NSString *)fileName;
{
    NSString *directorPath = @"";
    if (pathType == PathForDirectories_Document) {
        directorPath = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES)[0];
    }
    else if (pathType == PathForDirectories_Library){
        directorPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    }
    else if (pathType == PathForDirectories_Library_Cache){
        directorPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    }
    else{
        directorPath = NSTemporaryDirectory();
    }
    directorPath = [directorPath stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL fileExist = [fileManager fileExistsAtPath:directorPath];
    if (fileExist) {
        NSError *error = nil;
        BOOL removeResult = [fileManager removeItemAtPath:directorPath error: &error];
        if (removeResult) {
            NSLog(@"指定文件移除成功.....");
            return YES;
        }
        NSLog(@"指定文件移除失败.....");
        return NO;
    }
    NSLog(@"要移除的文件不存在.....");
    return NO;
}

//处理图片地址 (:/)否则保存时出错
+ (NSString *)detailImageUrl:(NSString *)imageName
{
    NSString *resultStr = [imageName stringByReplacingOccurrencesOfString:@":" withString:@""];
    resultStr = [resultStr stringByReplacingOccurrencesOfString:@"/" withString:@""];
    return resultStr;
}

+ (BOOL)removeFileFromPath:(NSString *)path fileName:(NSString *)fileName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [path stringByAppendingPathComponent:@"Image"];
    if ([fileManager fileExistsAtPath:filePath]) {
        [fileManager removeItemAtPath:filePath error:nil];
        return YES;
    }
    return NO;
}

+ (void)saveDataToCache:(NSData *)data path:(NSString *)path
{
    NSString *cachePath = NSTemporaryDirectory();
    NSString *saveImagePath = [cachePath stringByAppendingPathComponent:@"Image"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:saveImagePath]) {
        BOOL createFile = [fileManager createDirectoryAtPath:saveImagePath withIntermediateDirectories:YES attributes:nil error:nil];
        if (createFile) {
            NSLog(@"%@ 文件夹创建成功",saveImagePath);
        }
        else{
            NSLog(@"%@ 文件夹创建失败",saveImagePath);
        }
    }
    
    path = [self detailImageUrl:path];
    saveImagePath = [saveImagePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",path]];
    
    BOOL flag = [data writeToFile:saveImagePath atomically:YES];
    if (flag) {
        NSLog(@"数据写入成功！");
    }
    else {
        NSLog(@"数据写入失败！");
    }
}

//从本地获取NSData
+ (NSData *)obtainDataFromCache:(NSString *)targetPath
{
    NSString *cachePath = NSTemporaryDirectory();
    targetPath = [self detailImageUrl:targetPath];
    NSString *imagePath = [cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"Image/%@",targetPath]];
    NSData *data = [NSData dataWithContentsOfFile:imagePath];
    return data;
}

//获取 Appstore id
+ (NSString *)itunesIdentifier:(NSString *)adUrlStr
{
    NSArray *params = [adUrlStr componentsSeparatedByString:@"?"];
    NSString *firstStr = [params firstObject];
    NSArray *firstParams = [firstStr componentsSeparatedByString:@"/"];
    NSString *lastStr = [firstParams lastObject];
    NSString *identifer = [lastStr substringFromIndex:2];
    return identifer;
}

+ (CGFloat)currentSystemVersion
{
    return [[UIDevice currentDevice].systemVersion floatValue];
}

+ (BOOL)currentSystemVersion_iOS6
{
    if ([self currentSystemVersion] >= 6.0) {
        return YES;
    }
    return NO;
}

+ (BOOL)currentSystemVersion_iOS7
{
    if ([self currentSystemVersion] >= 7.0) {
        return YES;
    }
    return NO;
}

+ (BOOL)currentSystemVersion_iOS8
{
    if ([self currentSystemVersion] >= 8.0) {
        return YES;
    }
    return NO;
}

+ (BOOL)currentSystemVersion_iOS9
{
    if ([self currentSystemVersion] >= 9.0) {
        return YES;
    }
    return NO;
}

+ (BOOL)currentSystemVersion_iOS10
{
    if ([self currentSystemVersion] >= 10.0) {
        return YES;
    }
    return NO;
}

+ (BOOL)currentSystemVersion_iOS11
{
    if ([self currentSystemVersion] >= 11.0) {
        return YES;
    }
    return NO;
}

+ (BOOL)currentDeviceiPhoneX
{
    if ([UIApplication sharedApplication].keyWindow.bounds.size.height == 812) {
        return YES;
    }
    return NO;
}

/*
 *  @brief 判断当前地址是否需要打开 appstore
 */
+ (BOOL)isOpenAppstore:(NSString *)urlStr
{
    NSRange range = [urlStr rangeOfString:appstoredomain];
    if (range.location != NSNotFound) {
        return YES;
    }
    return NO;
}

#pragma mark - NSUserDefaults
+ (void)userDefaultSetKey:(NSString *)key value:(NSString *)value
{
    [[self userDefaults] setValue:value forKey:key];
}

+ (NSString *)userDefualtForKey:(NSString *)key
{
    return [[self userDefaults]valueForKey:key];
}

+ (void)userDefaultRemoveKey:(NSString *)key
{
    [[self userDefaults]removeObjectForKey:key];
}

+ (NSUserDefaults *)userDefaults
{
    return [NSUserDefaults standardUserDefaults];
}

#pragma mark - 获取启动图
+ (UIImage *)launchImage
{
    UIImage *lauchImage  = nil;
    NSString *viewOrientation = nil;
    CGSize viewSize  = [UIScreen mainScreen].bounds.size;
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationLandscapeLeft ||
        orientation == UIInterfaceOrientationLandscapeRight) {
        viewOrientation = @"Landscape";
    }
    else {
        viewOrientation = @"Portrait";
    }
    NSArray *imagesDictionary = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary *dict in imagesDictionary) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            lauchImage = [UIImage imageNamed:dict[@"UILaunchImageName"]];
        }
    }
    return lauchImage;
}

@end

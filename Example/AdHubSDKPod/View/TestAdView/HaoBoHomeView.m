//
//  HaoBoHomeView.m
//  AdHubSDK
//
//  Created by Mac on 2017/6/23.
//  Copyright © 2017年 AdHub. All rights reserved.
//

#import "HaoBoHomeView.h"
#import "HaoBoInputViewTableViewCell.h"
#import "HaoBoInputView.h"
#import "HaoBoInputModel.h"

static NSString *const openMoreRequestBtn = @"开启模拟多次请求操作";
static NSString *const closeMoreRequestBtn = @"关闭模拟多次请求操作";

@interface HaoBoHomeView ()<UITableViewDelegate, UITableViewDataSource, HaoBoInputViewTableViewCellDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataSources;

@end

@implementation HaoBoHomeView

- (void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    [self.tableView removeFromSuperview];
    self.tableView = nil;
    [self.dataSources removeAllObjects];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(@(0));
        }];
    }
    return self;
}

#pragma mark - TabelView delegate / dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    HaoBoInputViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HaoBoInputViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier indexPath:indexPath];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellEditingStyleNone;
    }
    [cell updateCellData:self.dataSources indexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row <= 6) {
        
    }
    //恢复默认的SpaceID
    else if (indexPath.row == 7){
        [[HaoBoSpaceInfo sharedInstall]resetSpaceInfoToDefatult];
        [self.tableView reloadData];
    }
    //Show Log
    else if (indexPath.row == 8){
        if ([self.delegate respondsToSelector:@selector(showLog)]) {
            [self.delegate showLog];
        }
    }
    //开启模拟多次请求
    else if (indexPath.row == 9){
        BOOL openState = NO;
        NSString *str = self.dataSources[indexPath.row];
        if ([str isEqualToString:openMoreRequestBtn]) {
            str = closeMoreRequestBtn;
            openState = YES;
        }
        else{
            str = openMoreRequestBtn;
        }
        [self.dataSources replaceObjectAtIndex:indexPath.row withObject:str];
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationAutomatic];
        if ([self.delegate respondsToSelector:@selector(analogyAdMoreClick:)]) {
            [self.delegate analogyAdMoreClick:openState];
        }
    }
}

- (void)cellBtnClick:(HaoBoButton *)clickBtn
{
    HaoBoInputModel *model = [[HaoBoInputModel alloc]initAdCellBtn:clickBtn];
    if (clickBtn.btnPosition == HaoBoCellBtnPosition_right) {
        if (clickBtn.row == 0) {
            if ([self.delegate respondsToSelector:@selector(submitLogEvent)]) {
                [self.delegate submitLogEvent];
            }
        }
        else{
            [self presentInputView:model cellBtn:clickBtn];
        }
    }
    else{
        if (clickBtn.row == 0) {
            [self presentInputView:model cellBtn:clickBtn];
        }
        else{
            //开始请求广告
            if ([self.delegate respondsToSelector:@selector(beginRequstAd:)]) {
                [self.delegate beginRequstAd:clickBtn.requestAdType];
            }
        }
    }
}

#pragma mark - dataSources
- (NSMutableArray *)dataSources
{
    if (!_dataSources) {
        _dataSources = [NSMutableArray array];
        if (!_dataSources.count) {
            [_dataSources addObject:[NSString stringWithFormat:@"AppID:"]];
            [_dataSources addObject:[NSString stringWithFormat:@"Show Intersitial Ad"]];
            [_dataSources addObject:[NSString stringWithFormat:@"Show Banner Ad"]];
            [_dataSources addObject:[NSString stringWithFormat:@"Show Reward Video Ad"]];
            [_dataSources addObject:[NSString stringWithFormat:@"Show Custom Ad"]];
            [_dataSources addObject:[NSString stringWithFormat:@"Show Native Ad"]];
            [_dataSources addObject:[NSString stringWithFormat:@"Show Splash Ad"]];
            [_dataSources addObject:[NSString stringWithFormat:@"恢复到默认SpaceID"]];
        }
    }
    return _dataSources;
}

#pragma mark - 弹出输入框
- (void)presentInputView:(HaoBoInputModel *)model cellBtn:(HaoBoButton *)cellBtn
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:model.title message:model.message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = model.placeholder;
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleNone;
        textField.keyboardType = UIKeyboardTypePhonePad;
    }];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray *textfields = alertController.textFields;
        UITextField *textField = textfields[0];
        if (cellBtn.btnPosition == HaoBoCellBtnPosition_left) {
            [HaoBoUtls userDefaultSetKey:kHaoBo_appID value:textField.text];
        }
        else{
            HaoBoRequestAdType adType = cellBtn.requestAdType;
            switch (adType) {
                case HaoBoRequestAdType_LogEvent:
                    break;
                    
                case HaoBoRequestAdType_intersitial:
                    [HaoBoUtls userDefaultSetKey:kHaoBo_intersitialSpaceID value:textField.text];
                    break;
                    
                case HaoBoRequestAdType_banner:
                    [HaoBoUtls userDefaultSetKey:kHaoBo_bannerSpaceID value:textField.text];
                    break;
                case HaoBoRequestAdType_reward_video:
                    [HaoBoUtls userDefaultSetKey:kHaoBo_rewardVideoSpaceID value:textField.text];
                    break;
                case HaoBoRequestAdType_custom:
                    [HaoBoUtls userDefaultSetKey:kHaoBo_customSpaceID value:textField.text];
                    break;
                case HaoBoRequestAdType_native:
                    [HaoBoUtls userDefaultSetKey:kHaoBo_nativeSpaceID value:textField.text];
                    break;
                case HaoBoRequestAdType_splash:
                    [HaoBoUtls userDefaultSetKey:kHaoBo_splashSpaceID value:textField.text];
                    break;
                default:
                    break;
        }
    }
        [self.tableView beginUpdates];
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:cellBtn.row inSection:cellBtn.section]] withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView endUpdates];
    }]];
    [[self presentTextFieldVC] presentViewController:alertController animated:YES completion:nil];
}

- (UIViewController *)presentTextFieldVC
{
    if ([self.delegate respondsToSelector:@selector(presentTextFieldVC)]) {
        return [self.delegate presentTextFieldVC];
    }
    
    UIView *superView = self.superview;
    while (superView) {
        UIResponder *nextResponder = [superView nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]){
            return (UIViewController *)nextResponder;
        }
        superView = superView.superview;
    }
    
    return nil;
}

#pragma mark - Initialization
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        [_tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

@end

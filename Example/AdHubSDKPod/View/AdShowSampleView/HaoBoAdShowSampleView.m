//
//  HaoBoAdShowSampleView.m
//  AdHubSDK
//
//  Created by Mac on 2017/7/1.
//  Copyright © 2017年 AdHub. All rights reserved.
//

#import "HaoBoAdShowSampleView.h"

@interface HaoBoAdShowSampleView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataSources;

@end

@implementation HaoBoAdShowSampleView

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.textLabel.text = self.dataSources[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(clickCellToShowAd:)]) {
        [self.delegate clickCellToShowAd:indexPath.row];
    }
}

#pragma mark - dataSources
- (NSMutableArray *)dataSources
{
    if (!_dataSources) {
        _dataSources = [NSMutableArray array];
        if (!_dataSources.count) {
            [_dataSources addObject:[NSString stringWithFormat:@"Intersitial 广告展示效果"]];
            [_dataSources addObject:[NSString stringWithFormat:@"Banner 广告展示效果"]];
            [_dataSources addObject:[NSString stringWithFormat:@"Reward Video 广告展示效果"]];
            [_dataSources addObject:[NSString stringWithFormat:@"Native 广告展示效果"]];
            [_dataSources addObject:[NSString stringWithFormat:@"Custom 广告展示效果"]];
            [_dataSources addObject:[NSString stringWithFormat:@"Splash 广告展示效果"]];
        }
    }
    return _dataSources;
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
    }
    return _tableView;
}

@end

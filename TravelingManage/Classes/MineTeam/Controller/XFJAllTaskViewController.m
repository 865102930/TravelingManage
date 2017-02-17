//
//  XFJAllTaskViewController.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/15.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJAllTaskViewController.h"
#import "XFJAllTaskTableViewCell.h"

@interface XFJAllTaskViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *allTaskTableView;

@end

@implementation XFJAllTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    [self setUpAllTableView];
}

- (void)setUpAllTableView
{
    [self.view addSubview:self.allTaskTableView];
    [self.allTaskTableView registerClass:[XFJAllTaskTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJAllTaskTableViewCell];
}

- (UITableView *)allTaskTableView
{
    if (_allTaskTableView == nil) {
        _allTaskTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _allTaskTableView.backgroundColor = kColoreeee;
        //去掉分割线
        _allTaskTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _allTaskTableView.delegate = self;
        _allTaskTableView.dataSource = self;
        _allTaskTableView.contentInset = UIEdgeInsetsMake(0, 0, 110, 0);
    }
    return _allTaskTableView;
}

#pragma mark - 组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

#pragma mark - cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XFJAllTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJAllTaskTableViewCell forIndexPath:indexPath];
    return cell;
}

#pragma mark - cell的点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [XFJAllTaskTableViewCell cellHeight];
}

@end

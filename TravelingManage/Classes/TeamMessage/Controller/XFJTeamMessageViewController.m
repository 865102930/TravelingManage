//
//  XFJTeamMessageViewController.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/20.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJTeamMessageViewController.h"
#import "XFJTitleMessageTableViewCell.h"
#import "XFJTitleMessageContentTableViewCell.h"
#import "XFJTeamMessageBottomTableViewCell.h"

@interface XFJTeamMessageViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UILabel *title_label;

@property (nonatomic, strong) UITableView *teamMessageContent_tableView;

@end

@implementation XFJTeamMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self setInitWithNav];
}

- (void)setInitWithNav
{
    self.navigationItem.titleView = self.title_label;
    [self.view addSubview:self.teamMessageContent_tableView];
    [self.teamMessageContent_tableView registerClass:[XFJTitleMessageTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJTitleMessageTableViewCell];
    [self.teamMessageContent_tableView registerClass:[XFJTitleMessageContentTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJTitleMessageContentTableViewCell];
    [self.teamMessageContent_tableView registerClass:[XFJTeamMessageBottomTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJTeamMessageBottomTableViewCell];
}

- (UILabel *)title_label
{
    if (_title_label == nil) {
        _title_label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.XFJ_centerX, 6, 100, 44)];
        _title_label.text = @"团队详情";
        _title_label.textColor = kColor6565;
        _title_label.textAlignment = NSTextAlignmentCenter;
    }
    return _title_label;
}

- (UITableView *)teamMessageContent_tableView
{
    if (_teamMessageContent_tableView == nil) {
        _teamMessageContent_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _teamMessageContent_tableView.delegate = self;
        _teamMessageContent_tableView.dataSource = self;
        //去掉分割线
        _teamMessageContent_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _teamMessageContent_tableView.backgroundColor = kColoreeee;
    }
    return _teamMessageContent_tableView;
}

#pragma mark - 数据源和代理方法
#pragma mark - 组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

#pragma mark - 每组cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = (section == 0 ? 5 :
                     section == 1 ? 3 :
                     section == 2 ? 4 :
                     2);
    return row;
}

#pragma mark - cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {//第一组
        if (indexPath.row == 0) {
            XFJTitleMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJTitleMessageTableViewCell forIndexPath:indexPath];
            [cell setTitle:@"常规信息"];
            return cell;
        }else {
            XFJTitleMessageContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJTitleMessageContentTableViewCell forIndexPath:indexPath];
            (indexPath.row == 1 ? [cell setTitle:@"团队编号" content:@"123455"] :
             indexPath.row == 2 ? [cell setTitle:@"出团日期" content:@"2017-02-20"] :
             indexPath.row == 3 ? [cell setTitle:@"旅行社名称" content:@"名称名称名称名称名称"] :
             [cell setTitle:@"车牌号" content:@"浙APH228"]);
            return cell;
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            XFJTitleMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJTitleMessageTableViewCell forIndexPath:indexPath];
            [cell setTitle:@"客源信息"];
            return cell;
        }else {
            XFJTitleMessageContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJTitleMessageContentTableViewCell forIndexPath:indexPath];
            (indexPath.row == 1 ? [cell setTitle:@"客源地" content:@"123455"] :
             [cell setTitle:@"目的属性" content:@"1.景区风光"]);
            return cell;
        }
    }else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            XFJTitleMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJTitleMessageTableViewCell forIndexPath:indexPath];
            [cell setTitle:@"团队信息"];
            return cell;
        }else {
            XFJTitleMessageContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJTitleMessageContentTableViewCell forIndexPath:indexPath];
            (indexPath.row == 1 ? [cell setTitle:@"团队人数" content:@"123455"] :
             indexPath.row == 2 ? [cell setTitle:@"出团性质" content:@"2017-02-20"] :
             [cell setTitle:@"行程天数" content:@"浙APH228"]);
            return cell;
        }
    }else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            XFJTitleMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJTitleMessageTableViewCell forIndexPath:indexPath];
            [cell setTitle:@"其它信息"];
            return cell;
        }else {
            XFJTitleMessageContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJTitleMessageContentTableViewCell forIndexPath:indexPath];
            [cell setTitle:@"属性" content:@"属性值"];
            return cell;
        }
    }else {
        
    }
    
    return nil;
}

#pragma mark - cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return [XFJTitleMessageTableViewCell cellHeight];
        }else {
            return [XFJTitleMessageContentTableViewCell cellHeight];
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return [XFJTitleMessageTableViewCell cellHeight];
        }else {
            return [XFJTitleMessageContentTableViewCell cellHeight];
        }
    }else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            return [XFJTitleMessageTableViewCell cellHeight];
        }else {
            return [XFJTitleMessageContentTableViewCell cellHeight];
        }
    }else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            return [XFJTitleMessageTableViewCell cellHeight];
        }else {
            return [XFJTitleMessageContentTableViewCell cellHeight];
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 2.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    view.backgroundColor = kColoreeee;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    view.backgroundColor = kColoreeee;
    return view;
}



@end

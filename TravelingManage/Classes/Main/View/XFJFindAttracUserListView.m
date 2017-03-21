//
//  XFJFindAttracUserListView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/21.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJFindAttracUserListView.h"
#import "XFJFindAttracUserListTableViewCell.h"
#import "XFJFindAttracUserListFooterView.h"

@interface XFJFindAttracUserListView() <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *findAttracUserList_tableView;
@property (nonatomic, strong) XFJFindAttracUserListFooterView *findAttracUserListFooterView;

@end

@implementation XFJFindAttracUserListView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor redColor];
        [self addSubview:self.findAttracUserList_tableView];
        [self.findAttracUserList_tableView addSubview:self.findAttracUserListFooterView];
        [self.findAttracUserList_tableView registerClass:[XFJFindAttracUserListTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJFindAttracUserListTableViewCell];
        [self.findAttracUserListFooterView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom);
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.height.mas_equalTo(60.0);
        }];
    }
    return self;
}

- (void)setFindAttracUserListItem:(NSMutableArray<XFJFindAttracUserListItem *> *)findAttracUserListItem
{
    _findAttracUserListItem = findAttracUserListItem;
    
}

- (XFJFindAttracUserListFooterView *)findAttracUserListFooterView
{
    if (_findAttracUserListFooterView == nil) {
        _findAttracUserListFooterView = [[XFJFindAttracUserListFooterView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 60)];
        _findAttracUserListFooterView.backgroundColor = [UIColor whiteColor];
    }
    return _findAttracUserListFooterView;
}

- (UITableView *)findAttracUserList_tableView
{
    if (_findAttracUserList_tableView == nil) {
        _findAttracUserList_tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _findAttracUserList_tableView.delegate = self;
        _findAttracUserList_tableView.dataSource = self;
        _findAttracUserList_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _findAttracUserList_tableView.tableFooterView = self.findAttracUserListFooterView;
    }
    return _findAttracUserList_tableView;
}

#pragma mark - 组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.findAttracUserListItem count];
}


#pragma mark - 每个cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    XFJFindAttracUserListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJFindAttracUserListTableViewCell forIndexPath:indexPath];
    cell.findAttracUserListItem = self.findAttracUserListItem[indexPath.row];
    return cell;
    
}

#pragma mark - cell得到点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end

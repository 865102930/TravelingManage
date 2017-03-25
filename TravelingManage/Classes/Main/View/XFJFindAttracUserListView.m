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
@property (nonatomic, strong) NSMutableArray *contacts;
//定义一个可变数组用来装点击的cell
@property (nonatomic, strong) NSMutableArray *indexPathArray;
@property (nonatomic, strong) NSMutableArray *indexPath_array;
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
        __weak __typeof(self)wself = self;
        self.findAttracUserListFooterView.sureUserButtonBlock = ^() {
            if (wself.sureUserButtonClickBlock) {
                wself.sureUserButtonClickBlock(wself.indexPath_array);
            }
        };
    }
    return self;
}

- (NSMutableArray *)indexPathArray
{
    if (_indexPathArray == nil) {
        _indexPathArray = [NSMutableArray array];
    }
    return _indexPathArray;
}

- (NSMutableArray *)contacts
{
    if (_contacts == nil) {
        _contacts = [NSMutableArray array];
    }
    return _contacts;
}

- (NSMutableArray *)indexPath_array
{
    if (_indexPath_array == nil) {
        _indexPath_array = [NSMutableArray array];
    }
    return _indexPath_array;
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
        _findAttracUserList_tableView.layer.cornerRadius = 8.0;
        _findAttracUserList_tableView.layer.borderWidth = 0.5;
        _findAttracUserList_tableView.contentInset = UIEdgeInsetsMake(0, 0, 60, 0);
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
{
    static NSString * identifier = @"Cell";
    XFJFindAttracUserListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[XFJFindAttracUserListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.findAttracUserListItem = self.findAttracUserListItem[indexPath.row];
    for (int i = 0; i < [self.findAttracUserListItem count]; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:@"NO" forKey:@"checked"];
        [self.contacts addObject:dic];
    }
    NSUInteger row = [indexPath row];
    NSMutableDictionary *dic = [self.contacts objectAtIndex:row];
    if ([[dic objectForKey:@"checked"] isEqualToString:@"NO"]) {
        [dic setObject:@"NO" forKey:@"checked"];
        [cell setChecked:NO];
        
    }else{
        [dic setObject:@"YES" forKey:@"checked"];
        [cell setChecked:YES];
    }
    return cell;
}

#pragma mark - cell得到点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.indexPath_array removeAllObjects];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XFJFindAttracUserListTableViewCell *cell = (XFJFindAttracUserListTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    NSUInteger row = [indexPath row];
    NSMutableDictionary *dic = [self.contacts objectAtIndex:row];
    if ([[dic objectForKey:@"checked"] isEqualToString:@"NO"]) {
        [dic setObject:@"YES" forKey:@"checked"];
        [cell setChecked:YES];
        [self.indexPathArray addObject:self.findAttracUserListItem[indexPath.row]];
    }else{
        [dic setObject:@"NO" forKey:@"checked"];
        [cell setChecked:NO];
        [self.indexPathArray removeObject:self.findAttracUserListItem[indexPath.row]];
    }
    self.indexPath_array = self.indexPathArray;
    NSLog(@"------------------值是 :%zd",self.indexPath_array.count);
}

#pragma mark - cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [XFJFindAttracUserListTableViewCell cellHeight];
}

@end

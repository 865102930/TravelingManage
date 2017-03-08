//
//  XFJCheckBoxView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/8.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJCheckBoxView.h"
#import "XFJCheckBoxTableViewCell.h"
#import "XFJCheckFooterView.h"

@interface XFJCheckBoxView() <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *checkBox_tableView;
@property (nonatomic, strong) XFJCheckFooterView *checkFooterView;

@end

@implementation XFJCheckBoxView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.checkBox_tableView];
        [self.checkBox_tableView registerClass:[XFJCheckBoxTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJCheckBoxTableViewCell];
        
        
    }
    return self;
}

- (void)requestCheckAttribute
{
    NSDictionary *dict = @{
                           @"types":@""
                           };
}

- (XFJCheckFooterView *)checkFooterView
{
    if (_checkFooterView == nil) {
        _checkFooterView = [[XFJCheckFooterView alloc] init];
        _checkFooterView.backgroundColor = [UIColor whiteColor];
    }
    return _checkFooterView;
}

- (UITableView *)checkBox_tableView
{
    if (_checkBox_tableView == nil) {
        _checkBox_tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _checkBox_tableView.delegate = self;
        _checkBox_tableView.dataSource = self;
        _checkBox_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _checkBox_tableView.tableFooterView = self.checkFooterView;
    }
    return _checkBox_tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XFJCheckBoxTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJCheckBoxTableViewCell forIndexPath:indexPath];
    cell.choose_buttonClickBlock = ^(UIButton *button){
        UITableViewCell *cell = (UITableViewCell *)[button superview];
        NSIndexPath *path = [self.checkBox_tableView indexPathForCell:cell];
        //这里可以获取到cell是具体是哪一个,就可以传相应的id
        NSLog(@"-----------------index row%ld", (long)[path row]);
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [XFJCheckBoxTableViewCell cellHeight];
}


@end

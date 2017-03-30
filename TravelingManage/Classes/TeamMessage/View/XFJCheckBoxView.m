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
#import "XFJFindParamsSystemListDoubleItem.h"

@interface XFJCheckBoxView() <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *checkBox_tableView;
@property (nonatomic, strong) XFJCheckFooterView *checkFooterView;
@property (nonatomic, strong) NSMutableArray <XFJFindParamsSystemListDoubleItem *> *findParamsSystemListDoubleItem;
@property (nonatomic, strong) NSMutableArray *arrayStr;
@property (strong, nonatomic) NSMutableArray *selectedRows;//选中的cell
@property (nonatomic, strong) NSString *reasonStr;//所有的原因,"&"隔开

@end

@implementation XFJCheckBoxView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.checkBox_tableView];
        [self addSubview:self.checkFooterView];
        [self.checkFooterView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.height.mas_equalTo(60.0);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
        [self.checkBox_tableView registerClass:[XFJCheckBoxTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJCheckBoxTableViewCell];
        __weak __typeof(self)wself = self;
        self.checkFooterView.presentChoosrNumberBlock = ^() {
            NSLog(@"------------在最终拿到的每行的值是 :%@",wself.reasonStr);
            if (wself.chooseCheckBoxBlock) {
                wself.chooseCheckBoxBlock(wself.reasonStr);
            }
        };
        self.checkFooterView.cancel_buttonClickBlock = ^() {
            if (wself.cancelMaskviewBlock) {
                wself.cancelMaskviewBlock();
            }
        };
    }
    return self;
}

- (XFJCheckFooterView *)checkFooterView
{
    if (_checkFooterView == nil) {
        _checkFooterView = [[XFJCheckFooterView alloc] init];
        _checkFooterView.backgroundColor = [UIColor whiteColor];
    }
    return _checkFooterView;
}

- (NSMutableArray *)selectedRows
{
    if (!_selectedRows) {
        _selectedRows = [NSMutableArray array];
    }
    return _selectedRows;
}

- (NSMutableArray <XFJFindParamsSystemListDoubleItem *> *)findParamsSystemListDoubleItem
{
    if (_findParamsSystemListDoubleItem == nil) {
        _findParamsSystemListDoubleItem = [NSMutableArray array];
    }
    return _findParamsSystemListDoubleItem;
}

- (NSMutableArray *)arrayStr
{
    if (_arrayStr == nil) {
        _arrayStr = [NSMutableArray array];
    }
    return _arrayStr;
}
- (UITableView *)checkBox_tableView
{
    if (_checkBox_tableView == nil) {
        _checkBox_tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _checkBox_tableView.delegate = self;
        _checkBox_tableView.dataSource = self;
        _checkBox_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _checkBox_tableView.layer.borderWidth = 0.5;
        _checkBox_tableView.layer.cornerRadius = 8.0;
        _checkBox_tableView.layer.borderColor = [UIColor whiteColor].CGColor;
//        _checkBox_tableView.tableFooterView = self.checkFooterView;
    }
    return _checkBox_tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.findParamsSystemListDoubleItem count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XFJCheckBoxTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJCheckBoxTableViewCell forIndexPath:indexPath];
    cell.findParamsSystemListDoubleItem = self.findParamsSystemListDoubleItem[indexPath.row];
    if ([self.selectedRows[indexPath.row]boolValue]) {
        [cell.check_button setBackgroundImage:[UIImage imageNamed:@"choice"] forState:UIControlStateNormal];
    }else {
        [cell.check_button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.selectedRows replaceObjectAtIndex:indexPath.row withObject:@(![self.selectedRows[indexPath.row] boolValue])];
    [self.checkBox_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade]; //刷新该cell
    NSString *str = [NSString stringWithFormat:@"%@",self.selectedRows[indexPath.row]];
    if ([str isEqualToString:@"1"]){
        [self.arrayStr addObject:self.findParamsSystemListDoubleItem[indexPath.row].name];
        NSLog(@"-------------arrayStr:%@",self.arrayStr);
    }else{
        [self.arrayStr removeObject:self.findParamsSystemListDoubleItem[indexPath.row].name];
        NSLog(@"-------+++++++------arrayStr:%@",self.arrayStr);
    }
    self.reasonStr = [self.arrayStr componentsJoinedByString:@"&"];
    
    NSLog(@"将所有的数据按照&隔开是:%@",self.reasonStr);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [XFJCheckBoxTableViewCell cellHeight];
}

- (void)setBackStr:(NSString *)backStr
{
    _backStr = backStr;
    NSLog(@"++++++++++在弹窗中获取到的back值是 :%@",backStr);
    [self requestCheckAttribute:backStr];
}

- (void)requestCheckAttribute:(NSString *)backStr
{
    NSDictionary *dictParams = @{
                                 @"types":backStr
                                 };
    __weak __typeof(self)wself = self;
    [GRNetRequestClass POST:FINDPARAMSSYSTEMLISTURL params:dictParams success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject) {
            NSMutableArray *dictArray = [responseObject objectForKey:@"rows"];
            wself.findParamsSystemListDoubleItem = [XFJFindParamsSystemListDoubleItem mj_objectArrayWithKeyValuesArray:dictArray];
            //数据源,用于标记cell是否被点击
            for (int i = 0; i < wself.findParamsSystemListDoubleItem.count; i++) {
                [self.selectedRows addObject:@(NO)];
            }
            [wself.checkBox_tableView reloadData];
            NSLog(@"===========得到的后台返回的弹框中的数据是 :%@",responseObject);
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"------------未获取到的探矿信息是 :%@",error);
        }
    }];
}



@end

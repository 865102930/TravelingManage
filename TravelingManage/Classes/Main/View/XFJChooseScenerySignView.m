//
//  XFJChooseScenerySignView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/11.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJChooseScenerySignView.h"
#import "XFJChooseSceneryTableViewCell.h"
#import "XFJChooseSceneryFooterView.h"
#import "XFJFindAttractionsListItem.h"

@interface XFJChooseScenerySignView() <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *chooseScenerySign_tableView;
@property (nonatomic, strong) XFJChooseSceneryFooterView *chooseSceneryFooterView;
@property (nonatomic, assign) NSIndexPath *selIndex;//单选，当前选中的行
@property (nonatomic, strong) XFJFindAttractionsListItem *findAttractionsListItem;

@end

@implementation XFJChooseScenerySignView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        [self addSubview:self.chooseScenerySign_tableView];
        [self addSubview:self.chooseSceneryFooterView];
        [self.chooseScenerySign_tableView registerClass:[XFJChooseSceneryTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJChooseSceneryTableViewCell];
        [self.chooseSceneryFooterView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.height.mas_equalTo(60.0);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
        __weak __typeof(self)wself = self;
        self.chooseSceneryFooterView.sureChoose_buttonClickBlock = ^() {
            if (wself.findAttractionsListItem == nil) {
                [MBProgressHUD showHudTipStr:@"请选择签到的景区!" contentColor:HidWithColorContentBlack];
                return ;
            }else {
                if (wself.chooseBlockButtonWithSure) {
                    wself.chooseBlockButtonWithSure(wself.findAttractionsListItem);
                }
            }
        };
        self.chooseSceneryFooterView.cancelChoose_buttonClickBlock = ^() {
            if (wself.chooseBlockButtonWithCancel) {
                wself.chooseBlockButtonWithCancel();
            }
        };
    }
    return self;
}

- (void)setScenery_array:(NSMutableArray <XFJFindAttractionsListItem *>*)scenery_array
{
    _scenery_array = scenery_array;
    [self.chooseScenerySign_tableView reloadData];
}


- (XFJChooseSceneryFooterView *)chooseSceneryFooterView
{
    if (_chooseSceneryFooterView == nil) {
        _chooseSceneryFooterView = [[XFJChooseSceneryFooterView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 60)];
        _chooseSceneryFooterView.backgroundColor = [UIColor whiteColor];
    }
    return _chooseSceneryFooterView;
}

- (UITableView *)chooseScenerySign_tableView
{
    if (_chooseScenerySign_tableView == nil) {
        _chooseScenerySign_tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _chooseScenerySign_tableView.delegate = self;
        _chooseScenerySign_tableView.dataSource = self;
        _chooseScenerySign_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _chooseScenerySign_tableView.layer.cornerRadius = 8.0;
        _chooseScenerySign_tableView.layer.borderWidth = 0.5;
        _chooseScenerySign_tableView.layer.borderColor = [UIColor whiteColor].CGColor;
        _chooseScenerySign_tableView.contentInset = UIEdgeInsetsMake(0, 0, 60, 0);
        _chooseScenerySign_tableView.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _chooseScenerySign_tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.scenery_array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const celID = @"cellID";
    XFJChooseSceneryTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[XFJChooseSceneryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celID];
    }
    cell.findAttractionsListItem = self.scenery_array[indexPath.row];
    if (_selIndex == indexPath) {
        [cell.sceneryContent_button setImage:[UIImage originalWithImage:@"choice"] forState:UIControlStateNormal];
    }else {
        [cell.sceneryContent_button setImage:[UIImage originalWithImage:@""] forState:UIControlStateNormal];
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //之前选中的，取消选择
    XFJChooseSceneryTableViewCell *celled = [tableView cellForRowAtIndexPath:_selIndex];
    [celled.sceneryContent_button setImage:[UIImage originalWithImage:@""] forState:UIControlStateNormal];
    //记录当前选中的位置索引
    _selIndex = indexPath;
    //当前选择的打勾
    XFJChooseSceneryTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell.sceneryContent_button setImage:[UIImage originalWithImage:@"choice"] forState:UIControlStateNormal];
    XFJFindAttractionsListItem *findAttractionsListItem = self.scenery_array[indexPath.row];
    self.findAttractionsListItem = findAttractionsListItem;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [XFJChooseSceneryTableViewCell cellHeight];
}

@end

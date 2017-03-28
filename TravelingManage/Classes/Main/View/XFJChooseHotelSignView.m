//
//  XFJChooseHotelSignView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/22.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJChooseHotelSignView.h"
#import "XFJChooseSceneryTableViewCell.h"
#import "XFJFindAttractionsListItem.h"
#import "XFJChooseHotelFooterView.h"

@interface XFJChooseHotelSignView() <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *chooseHotelSign_tableView;
@property (nonatomic, assign) NSIndexPath *selIndex;//单选，当前选中的行
@property (nonatomic, strong) XFJFindAttractionsListItem *findAttractionsListItem;
@property (nonatomic, strong) XFJChooseHotelFooterView *chooseHotelFooterView;

@end

@implementation XFJChooseHotelSignView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        [self addSubview:self.chooseHotelSign_tableView];
        [self addSubview:self.chooseHotelFooterView];
        [self.chooseHotelSign_tableView registerClass:[XFJChooseSceneryTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJChooseSceneryTableViewCell];
        [self.chooseHotelFooterView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.height.mas_equalTo(60.0);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
        __weak __typeof(self)wself = self;
        self.chooseHotelFooterView.sureChoose_buttonClickBlock = ^() {
            if (wself.chooseBlockButtonWithSure) {
                wself.chooseBlockButtonWithSure(wself.findAttractionsListItem);
            }
        };
        self.chooseHotelFooterView.cancelChoose_buttonClickBlock = ^() {
            if (wself.chooseBlockButtonWithCancel) {
                wself.chooseBlockButtonWithCancel();
            }
        };
    }
    return self;
}

- (void)setHotel_array:(NSMutableArray *)hotel_array
{
    _hotel_array = hotel_array;
    
    [self.chooseHotelSign_tableView reloadData];
}

- (XFJChooseHotelFooterView *)chooseHotelFooterView
{
    if (_chooseHotelFooterView == nil) {
        _chooseHotelFooterView = [[XFJChooseHotelFooterView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 60)];
        _chooseHotelFooterView.layer.cornerRadius = 8.0;
        _chooseHotelFooterView.backgroundColor = [UIColor whiteColor];
    }
    return _chooseHotelFooterView;
}

- (UITableView *)chooseHotelSign_tableView
{
    if (_chooseHotelSign_tableView == nil) {
        _chooseHotelSign_tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _chooseHotelSign_tableView.delegate = self;
        _chooseHotelSign_tableView.dataSource = self;
        _chooseHotelSign_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _chooseHotelSign_tableView.layer.cornerRadius = 8.0;
        _chooseHotelSign_tableView.layer.borderWidth = 0.5;
        _chooseHotelSign_tableView.contentInset = UIEdgeInsetsMake(0, 0, 60, 0);
        _chooseHotelSign_tableView.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _chooseHotelSign_tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.hotel_array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    XFJChooseSceneryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJChooseSceneryTableViewCell forIndexPath:indexPath];
    static NSString *const celID = @"cellID";
    XFJChooseSceneryTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[XFJChooseSceneryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celID];
    }
    NSLog(@"-----------这里获取到的值是 :%@",self.hotel_array[indexPath.row]);
    cell.findAttractionsListItem = self.hotel_array[indexPath.row];
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
    NSLog(@"-------------选择的是第%@个内容",self.hotel_array[indexPath.row]);
    XFJFindAttractionsListItem *findAttractionsListItem = self.hotel_array[indexPath.row];
    self.findAttractionsListItem = findAttractionsListItem;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [XFJChooseSceneryTableViewCell cellHeight];
}

@end

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
#import "XFJChooseScreneryTitleTableViewCell.h"

@interface XFJChooseHotelSignView() <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *chooseHotelSign_tableView;
@property (nonatomic, assign) NSIndexPath *selIndex;//单选，当前选中的行
@property (nonatomic, strong) XFJFindAttractionsListItem *findAttractionsListItem;
@property (nonatomic, strong) XFJChooseHotelFooterView *chooseHotelFooterView;
@property (nonatomic, strong) XFJChooseScreneryTitleTableViewCell *chooseScreneryTitleTableViewCell;


@end

@implementation XFJChooseHotelSignView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        [self addSubview:self.chooseHotelSign_tableView];
        [self.chooseHotelSign_tableView registerClass:[XFJChooseSceneryTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJChooseSceneryTableViewCell];
        __weak __typeof(self)wself = self;
        self.chooseHotelFooterView.sureChoose_buttonClickBlock = ^() {
            if (wself.findAttractionsListItem == nil) {
                [MBProgressHUD showHudTipStr:@"请选择签到的酒店" contentColor:HidWithColorContentBlack];
                return ;
            }else {
                if (wself.chooseBlockButtonWithSure) {
                    wself.chooseBlockButtonWithSure(wself.findAttractionsListItem);
                }
            }
        };
        self.chooseHotelFooterView.cancelChoose_buttonClickBlock = ^() {
            if (wself.chooseBlockButtonWithCancel) {
                wself.chooseBlockButtonWithCancel();
            }
        };
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reHotelSelecIndex) name:@"INDEXPATHNOTICE" object:nil];
    }
    return self;
}

- (void)reHotelSelecIndex
{
    self.selIndex = NULL;
}

- (void)setHotel_array:(NSMutableArray <XFJFindAttractionsListItem *> *)hotel_array
{
    _hotel_array = hotel_array;
    [self.chooseHotelSign_tableView reloadData];
}

- (void)setTaskRowsItemArray:(NSMutableArray<XFJTaskRowsItem *> *)taskRowsItemArray
{
    _taskRowsItemArray = taskRowsItemArray;
    [self.chooseHotelSign_tableView reloadData];
    self.selIndex = NULL;
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

- (XFJChooseScreneryTitleTableViewCell *)chooseScreneryTitleTableViewCell
{
    if (_chooseScreneryTitleTableViewCell == nil) {
        _chooseScreneryTitleTableViewCell = [[XFJChooseScreneryTitleTableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 60)];
        [_chooseScreneryTitleTableViewCell screneryTitle:@"请选择您所在酒店"];
    }
    return _chooseScreneryTitleTableViewCell;
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
        _chooseHotelSign_tableView.tableFooterView = self.chooseHotelFooterView;
        _chooseHotelSign_tableView.tableHeaderView = self.chooseScreneryTitleTableViewCell;
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
    static NSString *const celID = @"cellID";
    XFJChooseSceneryTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[XFJChooseSceneryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celID];
    }
    if (_selIndex == indexPath) {
        [cell.sceneryContent_button setImage:[UIImage originalWithImage:@"choice"] forState:UIControlStateNormal];
    }else {
        [cell.sceneryContent_button setImage:[UIImage originalWithImage:@""] forState:UIControlStateNormal];
    }
    NSLog(@"-----------这里获取到的值是 :%@",self.hotel_array[indexPath.row]);
    for (NSInteger i = 0; i < self.hotel_array.count; i++) {
        //取出景点id
        NSInteger findAttractions_id = self.hotel_array[i].findAttractions_id;
        for (NSInteger j = 0; j < self.taskRowsItemArray.count; j++) {
            //取出已经签到过了的景点id
            NSInteger alreadyFindAttractions_id = self.taskRowsItemArray[j].attractionsId;
            //判断景点id是否相等
            if (findAttractions_id == alreadyFindAttractions_id) {
                NSLog(@">>>>>>><<<<<<<<<<<<<<这里打印出相同的id的i的值是 :%zd",i);
                if (indexPath.row == i) {
                    [cell.sceneryContent_button setImage:[UIImage originalWithImage:@"selected-g"] forState:UIControlStateNormal];
                    cell.sceneryContent_button.layer.borderColor = [UIColor clearColor].CGColor;
                    cell.sceneryContent_button.enabled = NO;
                    cell.userInteractionEnabled = NO;
                }
            }
        }
    }
    cell.findAttractionsListItem = self.hotel_array[indexPath.row];
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
    XFJFindAttractionsListItem *findAttractionsListItem = self.hotel_array[indexPath.row];
    self.findAttractionsListItem = findAttractionsListItem;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [XFJChooseSceneryTableViewCell cellHeight];
}

@end

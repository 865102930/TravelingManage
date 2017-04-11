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
#import "XFJChooseScreneryTitleTableViewCell.h"

@interface XFJChooseScenerySignView() <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *chooseScenerySign_tableView;
@property (nonatomic, strong) XFJChooseSceneryFooterView *chooseSceneryFooterView;
@property (nonatomic, strong) XFJChooseScreneryTitleTableViewCell *chooseScreneryTitleTableViewCell;
@property (nonatomic, assign) NSIndexPath *selIndex;//单选，当前选中的行
@property (nonatomic, strong) XFJFindAttractionsListItem *findAttractionsListItem;

@end

@implementation XFJChooseScenerySignView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor redColor];
        [self addSubview:self.chooseScenerySign_tableView];
//        [self addSubview:self.chooseSceneryFooterView];
        [self.chooseScenerySign_tableView registerClass:[XFJChooseSceneryTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJChooseSceneryTableViewCell];
//        [self.chooseSceneryFooterView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self.mas_left);
//            make.right.mas_equalTo(self.mas_right);
//            make.height.mas_equalTo(60.0);
//            make.bottom.mas_equalTo(self.mas_bottom);
//        }];
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
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reIndexPath) name:@"INDEXPATHNOTICE" object:nil];
    }
    return self;
}

- (void)reIndexPath
{
    self.selIndex = NULL;
}

- (void)setScenery_array:(NSMutableArray <XFJFindAttractionsListItem *>*)scenery_array
{
    _scenery_array = scenery_array;
    [self.chooseScenerySign_tableView reloadData];
}

- (void)setTaskRowsItemArray:(NSMutableArray<XFJTaskRowsItem *> *)taskRowsItemArray
{
    _taskRowsItemArray = taskRowsItemArray;
}


- (XFJChooseSceneryFooterView *)chooseSceneryFooterView
{
    if (_chooseSceneryFooterView == nil) {
        _chooseSceneryFooterView = [[XFJChooseSceneryFooterView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 60)];
        _chooseSceneryFooterView.backgroundColor = [UIColor whiteColor];
    }
    return _chooseSceneryFooterView;
}

- (XFJChooseScreneryTitleTableViewCell *)chooseScreneryTitleTableViewCell
{
    if (_chooseScreneryTitleTableViewCell == nil) {
        _chooseScreneryTitleTableViewCell = [[XFJChooseScreneryTitleTableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 60)];
        [_chooseScreneryTitleTableViewCell screneryTitle:@"请选择您所在的景区"];
    }
    return _chooseScreneryTitleTableViewCell;
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
        _chooseScenerySign_tableView.tableHeaderView = self.chooseScreneryTitleTableViewCell;
        _chooseScenerySign_tableView.tableFooterView = self.chooseSceneryFooterView;
//        _chooseScenerySign_tableView.showsVerticalScrollIndicator = NO;
//        _chooseScenerySign_tableView.showsHorizontalScrollIndicator = NO;
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
    if (_selIndex == indexPath) {
        [cell.sceneryContent_button setImage:[UIImage originalWithImage:@"choice"] forState:UIControlStateNormal];
    }else {
        [cell.sceneryContent_button setImage:[UIImage originalWithImage:@""] forState:UIControlStateNormal];
    }
    //用景点和传过来的29个接口中的签到的景点来判断cell置灰状态
    //遍历
    for (NSInteger i = 0; i < self.scenery_array.count; i++) {
        //取出景点id
        NSInteger findAttractions_id = self.scenery_array[i].findAttractions_id;
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
    cell.findAttractionsListItem = self.scenery_array[indexPath.row];
    NSLog(@">>>>>>>>>>>>>>>选择的是第%zd行----------%zd",self.selIndex,indexPath);
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

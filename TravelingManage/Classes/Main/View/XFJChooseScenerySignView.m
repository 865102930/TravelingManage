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
@property (assign, nonatomic) NSIndexPath *selIndex;//单选，当前选中的行
@property (nonatomic, strong) XFJFindAttractionsListItem *findAttractionsListItem;
@end

@implementation XFJChooseScenerySignView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        [self addSubview:self.chooseScenerySign_tableView];
        [self.chooseScenerySign_tableView registerClass:[XFJChooseSceneryTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJChooseSceneryTableViewCell];
        __weak __typeof(self)wself = self;
        self.chooseSceneryFooterView.sureChoose_buttonClickBlock = ^() {
            if (wself.chooseBlockButtonWithSure) {
                wself.chooseBlockButtonWithSure(wself.findAttractionsListItem);
            }
        };
    }
    return self;
}

- (void)setScenery_array:(NSMutableArray *)scenery_array
{
    _scenery_array = scenery_array;
    [self.chooseScenerySign_tableView reloadData];
}

- (XFJChooseSceneryFooterView *)chooseSceneryFooterView
{
    if (_chooseSceneryFooterView == nil) {
        _chooseSceneryFooterView = [[XFJChooseSceneryFooterView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 100)];
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
        _chooseScenerySign_tableView.tableFooterView = self.chooseSceneryFooterView;
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
    XFJChooseSceneryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJChooseSceneryTableViewCell forIndexPath:indexPath];
    NSLog(@"-----------这里获取到的值是 :%@",self.scenery_array[indexPath.row]);
    cell.findAttractionsListItem = self.scenery_array[indexPath.row];
    __weak __typeof(self)wself = self;
//    cell.chichButtonChooseBlock = ^(UIButton *button) {
//        UITableViewCell *cell = (UITableViewCell *)[[button superview] superview];
//        NSIndexPath *path = [self.chooseScenerySign_tableView indexPathForCell:cell];
//        //这里可以获取到cell是具体是哪一个,就可以传相应的id
//        NSLog(@"-----------------index row%zd", [path row]);
//        
//    };
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
    NSLog(@"-------------选择的是第%@个内容",self.scenery_array[indexPath.row]);
    //-------------选择的是第<XFJFindAttractionsListItem: 0x170496490>个内容
    //-------------选择的是第<XFJFindAttractionsListItem: 0x170496440>个内容
    XFJFindAttractionsListItem *findAttractionsListItem = self.scenery_array[indexPath.row];
    self.findAttractionsListItem = findAttractionsListItem;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [XFJChooseSceneryTableViewCell cellHeight];
}

@end

//
//  XFJLeftView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/8.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJLeftView.h"
#import <Masonry.h>
#import "XFJLeftTableHeaderView.h"
#import "XFJLeftViewTableViewCell.h"
#import "XFJLeftTableFooterView.h"
#import <MJRefresh.h>
#import "XFJLeftFindTeamInfoItem.h"

@interface XFJLeftView()<UITableViewDelegate,UITableViewDataSource,XFJLeftTableFooterViewDelegate,XFJLeftTableHeaderViewDelegate>

@property (nonatomic, strong) UIView *backGroundView;

@property (nonatomic, strong) UITableView *leftTableView;

@property (nonatomic, strong) XFJLeftTableHeaderView *leftTableHeaderView;

@property (nonatomic, strong) XFJLeftTableFooterView *leftTableFooterView;

@property (nonatomic, assign) NSInteger newPage;

@property (nonatomic, strong) NSMutableArray <XFJLeftFindTeamInfoItem *> *leftFindTeamInfoItem_array;

@end


@implementation XFJLeftView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.newPage = 1;
        [self addSubview:self.backGroundView];
        [self addSubview:self.leftTableHeaderView];
        [self addSubview:self.leftTableView];
        [self addSubview:self.leftTableFooterView];
        [self.leftTableView registerClass:[XFJLeftViewTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJLeftViewTableViewCell];
        __weak __typeof(self)wself = self;
        self.leftTableHeaderView.changeUserInformationBlock = ^(){
            NSLog(@"您点击了修改资料按钮~~");
            if ([wself.delegate respondsToSelector:@selector(pushPersonalDataController)]) {
                [wself.delegate pushPersonalDataController];
            }
        };
        self.leftTableFooterView.addFooterViewHeightBlock = ^(){
            NSLog(@"增加了footerView的高度");
        };
        self.leftTableFooterView.reduceFooterViewHeightBlock = ^(){
            NSLog(@"减少了footerView的高度");
//            wself.leftTableFooterView.frame = CGRectMake(0, SCREEN_HEIGHT - 100, wself.XFJ_Width, 100);
//            wself.leftTableFooterView = [[XFJLeftTableFooterView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 100, wself.XFJ_Width, 100)];
        };
        //请求数据
        [self requestViewContent];
        self.leftTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestLeftView)];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestSecondLeftContent) name:@"FRESHENLEFTREQUEST" object:nil];
    }
    return self;
}

- (void)requestSecondLeftContent
{
    [self.leftTableView reloadData];
}

- (void)requestViewContent
{
    [self requestLeftView];
}

- (NSMutableArray <XFJLeftFindTeamInfoItem *> *)leftFindTeamInfoItem_array
{
    if (_leftFindTeamInfoItem_array == nil) {
        _leftFindTeamInfoItem_array = [NSMutableArray array];
    }
    return _leftFindTeamInfoItem_array;
}

- (void)requestLeftView
{
    NSInteger newPage = self.newPage ++;
    NSDictionary *dictParaments = @{
                                    @"userId":[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"],
                                    @"rows":@5,
                                    @"page":[NSString stringWithFormat:@"%ld",(long)newPage],
                                    @"teamState":@0
                                    };
    __weak __typeof(self)wself = self;
    [[NetWorkManager shareManager] requestWithType:HttpRequestTypeGet withUrlString:LEFTFINDTEAMINFOLISTURL withParaments:dictParaments withSuccessBlock:^(id object) {
        if (object) {
            NSLog(@"+++++++++侧滑栏的数据是:%@",object);
            NSString *strArray = [object objectForKey:@"rows"];
            [wself.leftFindTeamInfoItem_array addObjectsFromArray:[XFJLeftFindTeamInfoItem mj_objectArrayWithKeyValuesArray:strArray]];
            [wself.leftTableView reloadData];
            [wself.leftTableView.mj_footer endRefreshing];
        }
    } withFailureBlock:^(NSError *error) {
        if (error) {
            NSLog(@"_______未请求到侧滑栏的数据是:%@",error);
            [wself.leftTableView.mj_footer endRefreshing];
        }
    } progress:^(float progress) {
    }];
}

- (UIView *)backGroundView
{
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.XFJ_Width, self.XFJ_Height)];
        _backGroundView.backgroundColor = [UIColor whiteColor];
    }
    return _backGroundView;
}

- (UITableView *)leftTableView
{
    if (_leftTableView == nil) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 85, self.XFJ_Width, self.XFJ_Height - 185 - 85) style:UITableViewStylePlain];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _leftTableView;
}

- (XFJLeftTableHeaderView *)leftTableHeaderView
{
    if (_leftTableHeaderView == nil) {
        _leftTableHeaderView = [[XFJLeftTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.XFJ_Width, 85)];
        _leftTableHeaderView.delegate = self;
    }
    return _leftTableHeaderView;
}

- (XFJLeftTableFooterView *)leftTableFooterView
{
    if (_leftTableFooterView == nil) {

//        if (iphone5) {
            _leftTableFooterView = [[XFJLeftTableFooterView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 185, self.XFJ_Width, 185)];
        _leftTableFooterView.delegate = self;
//        }
        _leftTableFooterView.backgroundColor = [UIColor whiteColor];
    }
    return _leftTableFooterView;
}

#pragma mark - 跳转到通知控制器
- (void)pushToNoticeOfController
{
    if (self.pushNoticeWithHeaderBlock) {
        self.pushNoticeWithHeaderBlock();
    }
}

#pragma mark - 一根或者多根手指开始触摸view的时候,系统会自动调用view下面的方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"主人开始接触我");
    NSArray * touchesArr = [touches allObjects];
    if (touchesArr.count == 1) {
        UITouch * touch = [touchesArr objectAtIndex:0];
        self.touchWidth = [touch locationInView:nil].x;
    }
}
- (void)pushMineTeamController:(NSInteger)strNumber
{
    if (self.pushMineTeamBlock) {
        self.pushMineTeamBlock(strNumber);
    }
}
#pragma mark - 退出登录
- (void)exitButtonClick:(XFJLeftTableFooterView *)leftTableFooterView
{
    if (self.logoutUserBlock) {
        self.logoutUserBlock();
    }
}
#pragma mark - 跳转到全部任务控制器
- (void)pushToAllTaskingTeamController
{
    if (self.pushAllTeamTaskBlock) {
        self.pushAllTeamTaskBlock();
    }
}
#pragma mark - 待审核
- (void)pushToPleaseCheckTeamController
{
    if (self.pushCheckTeamBlock) {
        self.pushCheckTeamBlock();
    }
}

#pragma makr - 待评价
- (void)pushToPleaseAskingTeamController
{
    if (self.pushPleaseAskingBlock) {
        self.pushPleaseAskingBlock();
    }
}

#pragma mark - 一根或者多根手指开始在view上移动的时候,系统会自动调用view下面的方法
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"主人开始移动");
    NSArray * touchesArr = [touches allObjects];
    UITouch * touch = [touchesArr objectAtIndex:0];
    if (touchesArr.count == 1 && self.touchWidth > [touch previousLocationInView:nil].x) {
        if ([self.delegate respondsToSelector:@selector(touchViewWithWidth:)]) {
            [self.delegate touchViewWithWidth:self.touchWidth - [touch locationInView:nil].x];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(touchViewWithWidth:)]) {
            [self.delegate touchViewWithWidth:0];
        }
    }
}

#pragma mark - 一根或者多根手指离开view，系统会自动调用view下面的方法
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"主人已经离开我");
    NSArray * touchesArr = [touches allObjects];
    if (touchesArr.count == 1) {
        UITouch * touch = [touchesArr objectAtIndex:0];
        if (self.touchWidth - [touch locationInView:nil].x > 20) {
            if ([self.delegate respondsToSelector:@selector(backLeftVeiw)]) {
                [self.delegate backLeftVeiw];
            }
        }else{
            if ([self.delegate respondsToSelector:@selector(touchViewWithWidth:)]) {
                [self.delegate touchViewWithWidth:0];
            }
        }
    }
}

#pragma mark - 触摸结束前,某个系统事件（例如电话呼入）会打断触摸过程，系统会自动调用view下面的方法
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"有东西打扰主人触摸我");
    NSArray * touchesArr = [touches allObjects];
    if (touchesArr.count == 1) {
        UITouch * touch = [touchesArr objectAtIndex:0];
        if (self.touchWidth - [touch locationInView:nil].x > 20) {
            if ([self.delegate respondsToSelector:@selector(backLeftVeiw)]) {
                [self.delegate backLeftVeiw];
            }
        }else{
            if ([self.delegate respondsToSelector:@selector(touchViewWithWidth:)]) {
                [self.delegate touchViewWithWidth:0];
            }
        }
    }
}

#pragma mark - 组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.leftFindTeamInfoItem_array count];
}

#pragma mark - cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XFJLeftViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJLeftViewTableViewCell forIndexPath:indexPath];
    cell.leftFindTeamInfoItem = self.leftFindTeamInfoItem_array[indexPath.row];
    return cell;
}

#pragma mark - cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell点击了我~~");
    __weak __typeof(self)wself = self;
    if (self.presentToHomeController) {
        self.isTeamId = YES;
        self.isEnter = NO;
        self.presentToHomeController(wself.leftFindTeamInfoItem_array[indexPath.row],self.isTeamId,self.isEnter);
    }
}

#pragma mark - cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [XFJLeftViewTableViewCell cellHeight];
}



- (void)dealloc
{
    NSLog(@"侧滑view销毁了...");
}




@end

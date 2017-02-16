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

@interface XFJLeftView()<UITableViewDelegate,UITableViewDataSource,XFJLeftTableFooterViewDelegate>

@property (nonatomic, strong) UIView *backGroundView;

@property (nonatomic, strong) UITableView *leftTableView;

@property (nonatomic, strong) XFJLeftTableHeaderView *leftTableHeaderView;

@property (nonatomic, strong) XFJLeftTableFooterView *leftTableFooterView;

@end

@implementation XFJLeftView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self addSubview:self.backGroundView];
        [self addSubview:self.leftTableHeaderView];
        [self addSubview:self.leftTableView];
        [self addSubview:self.leftTableFooterView];
        [self.leftTableView registerClass:[XFJLeftViewTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJLeftViewTableViewCell];
        __weak __typeof(self)wself = self;
        self.leftTableHeaderView.changeUserInformationBlock = ^(){
            NSLog(@"您点击了修改资料按钮~~");
        };
        self.leftTableFooterView.addFooterViewHeightBlock = ^(){
            NSLog(@"增加了footerView的高度");
        };
        self.leftTableFooterView.reduceFooterViewHeightBlock = ^(){
            NSLog(@"减少了footerView的高度");
//            wself.leftTableFooterView.frame = CGRectMake(0, SCREEN_HEIGHT - 100, wself.XFJ_Width, 100);
//            wself.leftTableFooterView = [[XFJLeftTableFooterView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 100, wself.XFJ_Width, 100)];
        };
    }
    return self;
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
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 85, self.XFJ_Width, self.XFJ_Height) style:UITableViewStylePlain];
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
//        _leftTableFooterView.backgroundColor = [UIColor redColor];
    }
    return _leftTableFooterView;
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

- (void)pushMineTeamController
{
    if (self.pushMineTeamBlock) {
        self.pushMineTeamBlock();
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
    return 3;
}

#pragma mark - cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XFJLeftViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJLeftViewTableViewCell forIndexPath:indexPath];
    return cell;
}

#pragma mark - cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell点击了我~~");
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

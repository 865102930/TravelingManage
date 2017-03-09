//
//  XFJLeftTableFooterView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/9.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJLeftTableFooterView.h"
#import "XFJMineTeamViewController.h"
#import <Masonry.h>

@interface XFJLeftTableFooterView()

//装所有控件的view
@property (nonatomic, strong) UIView *backGroundView;
//改变菜单的按钮
@property (nonatomic, strong) UIButton *change_menu;
//第一行菜单的view
@property (nonatomic, strong) UIView *firestBackGroundView;
//菜单一
@property (nonatomic, strong) UIButton *firestMenuButton;
//菜单二
@property (nonatomic, strong) UIButton *secondMenuButton;
//菜单三
@property (nonatomic, strong) UIButton *thirdMenuButton;
@property (nonatomic, assign) BOOL isclickMenuButton;
@property (nonatomic, strong) UIView *bottomMenuView;
//全部任务
@property (nonatomic, strong) UIButton *allAssignment;
//退出按钮
@property (nonatomic, strong) UIButton *exit_button;

@end

@implementation XFJLeftTableFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initWithControl];
        [self setUpMasControl];
    }
    return self;
}

#pragma mark - 初始化控件
- (void)initWithControl
{
    [self addSubview:self.backGroundView];
    [self addSubview:self.change_menu];
    [self addSubview:self.firestBackGroundView];
    [self.firestBackGroundView addSubview:self.firestMenuButton];
    [self.firestBackGroundView addSubview:self.secondMenuButton];
    [self.firestBackGroundView addSubview:self.thirdMenuButton];
}

#pragma mark - 布局控件
- (void)setUpMasControl
{
    [self.backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).mas_offset(100.0);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(100.0);
    }];
    [self.change_menu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backGroundView.mas_top).mas_offset(0);
        make.centerX.mas_equalTo(self.backGroundView.mas_centerX);
        make.height.mas_equalTo(17.0);
        make.width.mas_equalTo(20.0);
    }];
    [self.firestBackGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.change_menu.mas_bottom).mas_offset(5.0);
        make.height.mas_equalTo(65.0);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
    }];
    [self.firestMenuButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.firestBackGroundView.mas_top).mas_offset(5.0);
        make.height.width.mas_equalTo((202 - 4 * 12) / 3);
        make.left.mas_equalTo(self.firestBackGroundView.mas_left).mas_offset(12.0);
    }];
    [self.secondMenuButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.firestBackGroundView.mas_top).mas_offset(5.0);
        make.height.width.mas_equalTo((202 - 4 * 12) / 3);
        make.left.mas_equalTo(self.firestMenuButton.mas_right).mas_offset(12.0);
    }];
    [self.thirdMenuButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.firestBackGroundView.mas_top).mas_offset(5.0);
        make.height.width.mas_equalTo((202 - 4 * 12) / 3);
        make.left.mas_equalTo(self.secondMenuButton.mas_right).mas_offset(12.0);
    }];
}

- (UIView *)backGroundView
{
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] init];
    }
    return _backGroundView;
}

- (UIButton *)change_menu
{
    if (_change_menu == nil) {
        _change_menu = [UIButton buttonWithType:UIButtonTypeCustom];
        [_change_menu setImage:[UIImage originalWithImage:@"triangle"] forState:UIControlStateNormal];
        [_change_menu addTarget:self action:@selector(changeMenu) forControlEvents:UIControlEventTouchUpInside];
    }
    return _change_menu;
}

- (UIView *)firestBackGroundView
{
    if (_firestBackGroundView == nil) {
        _firestBackGroundView = [[UIView alloc] init];
    }
    return _firestBackGroundView;
}

- (UIButton *)firestMenuButton
{
    if (_firestMenuButton == nil) {
        _firestMenuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_firestMenuButton setImage:[UIImage originalWithImage:@"wanshan"] forState:UIControlStateNormal];
        [_firestMenuButton setTitle:[NSString stringWithFormat:@"%@",@"待完善(0)"] forState:UIControlStateNormal];
        [_firestMenuButton setTitleColor:kColor5858 forState:UIControlStateNormal];
        _firestMenuButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        _firestMenuButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        _firestMenuButton.tag = 2;
        [_firestMenuButton addTarget:self action:@selector(pleasePerfected) forControlEvents:UIControlEventTouchUpInside];
    }
    return _firestMenuButton;
}

- (UIButton *)secondMenuButton
{
    if (_secondMenuButton == nil) {
        _secondMenuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_secondMenuButton setImage:[UIImage originalWithImage:@"shenhe"] forState:UIControlStateNormal];
        [_secondMenuButton setTitle:[NSString stringWithFormat:@"%@",@"待审核(0)"] forState:UIControlStateNormal];
        [_secondMenuButton setTitleColor:kColor5858 forState:UIControlStateNormal];
        _secondMenuButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        _secondMenuButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_secondMenuButton addTarget:self action:@selector(checkPending) forControlEvents:UIControlEventTouchUpInside];
    }
    return _secondMenuButton;
}

- (UIButton *)thirdMenuButton
{
    if (_thirdMenuButton == nil) {
        _thirdMenuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_thirdMenuButton setImage:[UIImage originalWithImage:@"pingjia"] forState:UIControlStateNormal];
        [_thirdMenuButton setTitle:[NSString stringWithFormat:@"%@",@"待评价(0)"] forState:UIControlStateNormal];
        [_thirdMenuButton setTitleColor:kColor5858 forState:UIControlStateNormal];
        _thirdMenuButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        _thirdMenuButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_thirdMenuButton addTarget:self action:@selector(pleaseAppraise) forControlEvents:UIControlEventTouchUpInside];
    }
    return _thirdMenuButton;
}

- (UIView *)bottomMenuView
{
    if (_bottomMenuView == nil) {
        _bottomMenuView = [[UIView alloc] init];
    }
    return _bottomMenuView;
}
- (UIButton *)allAssignment
{
    if (_allAssignment == nil) {
        _allAssignment = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allAssignment setImage:[UIImage originalWithImage:@"quanbu"] forState:UIControlStateNormal];
        [_allAssignment setTitle:[NSString stringWithFormat:@"%@",@"全部任务"] forState:UIControlStateNormal];
        [_allAssignment setTitleColor:kColor5858 forState:UIControlStateNormal];
        _allAssignment.titleLabel.font = [UIFont systemFontOfSize:12.0];
        _allAssignment.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_allAssignment addTarget:self action:@selector(allAssignmentClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _allAssignment;
}

- (UIButton *)exit_button
{
    if (_exit_button == nil) {
        _exit_button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_exit_button setTitle:@"退出" forState:UIControlStateNormal];
        [_exit_button setTitleColor:kColorFFFF forState:UIControlStateNormal];
        _exit_button.backgroundColor = kColorff47;
        _exit_button.layer.cornerRadius = 8;
        [_exit_button addTarget:self action:@selector(exitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exit_button;
}

- (void)changeMenu
{
    NSLog(@"主人,您点击了切换菜单按钮~~");
    if (!self.isclickMenuButton) {
        [self setUpStartMenuButtonClick];
    }else {
        [self setUpSecondClickMenuButton];
    }
}

#pragma mark - 开始点击切换菜单的按钮
- (void)setUpStartMenuButtonClick
{
    [self.change_menu setImage:[UIImage originalWithImage:@"changemenubutton"] forState:UIControlStateNormal];
    [self.backGroundView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).mas_offset(0.0);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(85.0);
    }];
    self.isclickMenuButton = YES;
    [self initWithBottomMenuView];
    if (self.addFooterViewHeightBlock) {
        self.addFooterViewHeightBlock();
    }
}

#pragma mark - 二次点击切换菜单按钮的时候进来
- (void)setUpSecondClickMenuButton
{
    [self.change_menu setImage:[UIImage originalWithImage:@"triangle"] forState:UIControlStateNormal];
    [self.backGroundView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).mas_offset(100.0);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(100.0);
    }];
    self.isclickMenuButton = NO;
    if (self.reduceFooterViewHeightBlock) {
        self.reduceFooterViewHeightBlock();
    }
}

#pragma mark - 开始点击切换菜单的时候,底部添加的控件
- (void)initWithBottomMenuView
{
    [self addSubview:self.bottomMenuView];
    [self.bottomMenuView addSubview:self.allAssignment];
    [self.bottomMenuView addSubview:self.exit_button];
    [self.bottomMenuView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backGroundView.mas_bottom);
        make.left.mas_equalTo(self.backGroundView.mas_left);
        make.right.mas_equalTo(self.backGroundView.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    [self.allAssignment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backGroundView.mas_bottom).mas_offset(0);
        make.left.mas_equalTo(self.firestMenuButton.mas_left);
        make.width.mas_equalTo(self.firestMenuButton.mas_width);
        make.height.mas_equalTo(self.firestMenuButton.mas_height);
    }];
    [self.exit_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.allAssignment.mas_bottom).mas_offset(10.0);
        make.left.mas_equalTo(self.bottomMenuView.mas_left).mas_offset(45.0);
        make.height.mas_equalTo(33.0);
        make.width.mas_equalTo(111.0);
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.firestMenuButton setTitleEdgeInsets:UIEdgeInsetsMake(10, -60, -20, -30)];
    [self.firestMenuButton setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 20, 10)];
    [self.secondMenuButton setTitleEdgeInsets:UIEdgeInsetsMake(10, -60, -20, -30)];
    [self.secondMenuButton setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 20, 10)];
    [self.thirdMenuButton setTitleEdgeInsets:UIEdgeInsetsMake(10, -60, -20, -30)];
    [self.thirdMenuButton setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 20, 10)];
    [self.allAssignment setTitleEdgeInsets:UIEdgeInsetsMake(10, -60, -20, -30)];
    [self.allAssignment setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 20, 10)];
}

- (void)pleasePerfected
{
    NSLog(@"主人,您点击了待完善按钮~~");
    NSInteger strNumber = 2;
    if ([self.delegate respondsToSelector:@selector(pushMineTeamController:)]) {
        [self.delegate pushMineTeamController:strNumber];
    }
}

- (void)checkPending
{
    NSLog(@"主人,您点击了待审核按钮~~");
}

- (void)pleaseAppraise
{
    NSLog(@"主人,您点击了待评价按钮~~");
}

- (void)allAssignmentClick
{
    NSLog(@"主人,您点击了全部任务按钮~~");
}

- (void)exitButtonClick
{
    NSLog(@"主人,您点击了退出按钮~~");
    if (self.delegate && [self.delegate respondsToSelector:@selector(exitButtonClick:)]) {
        [self.delegate exitButtonClick:self];
    }
}

@end

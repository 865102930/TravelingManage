//
//  XFJTaskView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/10.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJTaskView.h"
#import "HyperlinksButton.h"
#import <Masonry.h>

@interface XFJTaskView()

@property (nonatomic, strong) UIImageView *taskBackGroundImageView;

@property (nonatomic, strong) UILabel *noTask_label;

@property (nonatomic, strong) HyperlinksButton *links_button;

@end

@implementation XFJTaskView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self addSubview:self.taskBackGroundImageView];
        [self.taskBackGroundImageView addSubview:self.noTask_label];
        [self.taskBackGroundImageView addSubview:self.links_button];
        [self initControlWithMasonry];
    }
    return self;
}

- (UIImageView *)taskBackGroundImageView
{
    if (_taskBackGroundImageView == nil) {
        _taskBackGroundImageView = [[UIImageView alloc] init];
        _taskBackGroundImageView.image = [UIImage originalWithImage:@"xinjianrenwukuang"];
        _taskBackGroundImageView.userInteractionEnabled = YES;
    }
    return _taskBackGroundImageView;
}

- (UILabel *)noTask_label
{
    if (_noTask_label == nil) {
        _noTask_label = [[UILabel alloc] init];
        _noTask_label.textColor = kColorC2C2;
        _noTask_label.text = @"当前没有进行中的任务,";
        [_noTask_label setFont:[UIFont systemFontOfSize:14.0]];
    }
    return _noTask_label;
}

- (HyperlinksButton *)links_button
{
    if (_links_button == nil) {
        _links_button = [HyperlinksButton buttonWithType:UIButtonTypeCustom];
        [_links_button setTitle:[NSString stringWithFormat:@"%@",@"点击新建任务"] forState:UIControlStateNormal];
        [_links_button addTarget:self action:@selector(pressNewProjectButton) forControlEvents:UIControlEventTouchUpInside];
        [_links_button setColor:kColorff47];
        [_links_button setTitleColor:kColorff47 forState:UIControlStateNormal];
        [_links_button.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    }
    return _links_button;
}

- (void)initControlWithMasonry
{
    [self.taskBackGroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(self.mas_height);
    }];
    [self.noTask_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.taskBackGroundImageView.mas_top).mas_offset(38.0);
        if (iphone6P) {
            make.left.mas_equalTo(self.taskBackGroundImageView.mas_left).mas_offset(70.0);
        }else if (iphone5){
            make.left.mas_equalTo(self.taskBackGroundImageView.mas_left).mas_offset(30.0);
        }else if (iphone6) {
            make.left.mas_equalTo(self.taskBackGroundImageView.mas_left).mas_offset(55.0);
        }
    }];
    [self.links_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.noTask_label.mas_top);
        make.left.mas_equalTo(self.noTask_label.mas_right).mas_offset(10.0);
        make.centerY.mas_equalTo(self.noTask_label.mas_centerY);
    }];
}

- (void)pressNewProjectButton
{
    NSLog(@"主人,您点击了new任务~~");
    if (self.openGroupBlock) {
        self.openGroupBlock();
    }
}


@end

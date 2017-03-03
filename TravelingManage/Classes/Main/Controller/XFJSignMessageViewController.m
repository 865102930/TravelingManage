//
//  XFJSignMessageViewController.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/2.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJSignMessageViewController.h"
#import "XFJSignMessageTopVeiw.h"
#import "XFJSignMessageTimeView.h"
#import "XFJSignTeamPhotosView.h"

@interface XFJSignMessageViewController ()

@property (nonatomic, strong) XFJSignMessageTopVeiw *signMessageTopVeiw;
@property (nonatomic, strong) XFJSignMessageTimeView *signMessageTimeView;
@property (nonatomic, strong) XFJSignTeamPhotosView *signTeamPhotosView;

@end

@implementation XFJSignMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kColoreeee;
    [self.view addSubview:self.signMessageTopVeiw];
    [self.view addSubview:self.signMessageTimeView];
    [self.view addSubview:self.signTeamPhotosView];
}

- (XFJSignMessageTopVeiw *)signMessageTopVeiw
{
    if (_signMessageTopVeiw == nil) {
        _signMessageTopVeiw = [[XFJSignMessageTopVeiw alloc] initWithFrame:CGRectMake(0, 72, SCREEN_WIDTH, 38.0)];
    }
    return _signMessageTopVeiw;
}

- (XFJSignMessageTimeView *)signMessageTimeView
{
    if (_signMessageTimeView == nil) {
        _signMessageTimeView = [[XFJSignMessageTimeView alloc] initWithFrame:CGRectMake(0, 110, SCREEN_WIDTH, 97.0)];
    }
    return _signMessageTimeView;
}

- (XFJSignTeamPhotosView *)signTeamPhotosView
{
    if (_signTeamPhotosView == nil) {
        _signTeamPhotosView = [[XFJSignTeamPhotosView alloc] initWithFrame:CGRectMake(0, 207, SCREEN_WIDTH, 200)];
    }
    return _signTeamPhotosView;
}


@end

//
//  LoginViewController.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/6.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
#import "JTNavigationController.h"
#import "PersonalDataViewController.h"
#import "HomeViewController.h"
@interface LoginViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UIImageView *backgroundImage;//背景图片
@property(nonatomic,strong)UIImageView *titleImage;//团队管理
@property(nonatomic,strong)UITextField *phoneTextF;//手机号
@property(nonatomic,strong)UITextField *idCodeTextF;//验证码
@property(nonatomic,strong)UIButton    *idCodeButton;//验证码按钮
@property(nonatomic,strong)UIButton    *loginButton;//登录
@property(nonatomic,strong)UILabel     *registLabel;//注册
@property(nonatomic,strong)UIButton    *registButton;//注册按钮
@end

@implementation LoginViewController
#pragma  mark ----- lazy
- (UIImageView *)backgroundImage{
    if (!_backgroundImage){
        _backgroundImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BackgroundImage"]];
        _backgroundImage.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self.view addSubview:_backgroundImage];
    }
    return _backgroundImage;
}

- (UIImageView *)titleImage{
    if (!_titleImage) {
        _titleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TeamTitle"]];
        [self.view addSubview:_titleImage];
    }
    return _titleImage;
}

- (UITextField *)phoneTextF{
    if(!_phoneTextF){
        _phoneTextF = [UITextField textLeftImage:@"phoneNum" placeholder:@"请输入手机号" imageWidth:14 imageHeight:19 lineWidth:SCREEN_WIDTH - 48];
         [_phoneTextF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self.view addSubview:_phoneTextF];
    }
    return _phoneTextF;
}

- (UITextField *)idCodeTextF{
    if (!_idCodeTextF) {
        _idCodeTextF =[UITextField textLeftImage:@"idCodeImage" placeholder:@"请输入验证码" imageWidth:17 imageHeight:15 lineWidth:(SCREEN_WIDTH - 111 - 17 - 48)];
         [_idCodeTextF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self.view addSubview:_idCodeTextF];
    }
    return _idCodeTextF;
}

- (UIButton *)idCodeButton{
    if (!_idCodeButton) {
        _idCodeButton = [UIButton buttonWithTitle:@"获取验证码" fontOfSize:15 target:self action:@selector(idCodeButtonClick)];
        [self.view addSubview:_idCodeButton];
    }
    return _idCodeButton;
}

- (UIButton *)loginButton{
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] init];
        _loginButton.titleLabel.font = [UIFont fontWithName:PingFang size:15];
        [_loginButton setTintColor:[UIColor colorWithHexString:@"FFFFFF"]];
        [_loginButton addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _loginButton.userInteractionEnabled = NO;
        [self.view addSubview:_loginButton];
    }
    return _loginButton;
}

- (UIButton *)registButton{
    if (!_registButton) {
        _registButton = [[UIButton alloc] init];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"< 还没有账号? 立即注册"];
        [str addAttribute:NSForegroundColorAttributeName value:RedColor range:NSMakeRange(0, [str length])];
        [_registButton setTitleColor:RedColor forState:UIControlStateNormal];
        NSRange strRange = {9, 4};
        [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
        [_registButton setAttributedTitle:str forState:UIControlStateNormal];
        _registButton.titleLabel.font = [UIFont fontWithName:PingFang size:14];
        [_registButton addTarget:self action:@selector(registButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_registButton];
    }
    return _registButton;

}

#pragma  mark ----- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma  mark ----- creatUI
- (void)creatUI{
    self.backgroundImage.userInteractionEnabled = YES;
    //团队管理
    [self.titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset((SCREEN_WIDTH - 132)/2);
        make.right.equalTo(self.view).offset(-(SCREEN_WIDTH - 132)/2);
        make.top.equalTo(self.view).offset(134);
        make.height.mas_equalTo(33);
    }];
    
    //输入手机号
    [self.phoneTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(24);
        make.right.equalTo(self.view).offset(-24);
        make.top.equalTo(_titleImage.mas_bottom).offset(69);
        make.height.mas_equalTo(42);
    }];

    //验证码
    [self.idCodeTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(24);
        make.right.equalTo(self.view).offset(-(111+17+24));
        make.top.equalTo(_phoneTextF.mas_bottom).offset(10);
        make.height.mas_equalTo(42);
    }];
    
    //获取验证码按钮
    [self.idCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.idCodeTextF.mas_right).offset(17);
        make.right.equalTo(self.view).offset(-(24));
        make.top.equalTo(_phoneTextF.mas_bottom).offset(10);
        make.height.mas_equalTo(42);
    }];
    
    //登录按钮
    [self.loginButton setBackgroundImage: [UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(17);
        make.right.equalTo(self.view).offset(-17);
        make.top.equalTo(_idCodeTextF.mas_bottom).offset(30);
        make.height.mas_equalTo(42);
    }];
    
    [self.registButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-32);
    }];
    
    self.phoneTextF.delegate = self;
    self.idCodeTextF.delegate = self;
}
//登录
- (void)loginBtnClick{
    HomeViewController * PersonalDataVC = [[HomeViewController alloc] init];
    [self.navigationController pushViewController:PersonalDataVC animated:YES];
//    [UIApplication sharedApplication].keyWindow.rootViewController = PersonalDataVC;
//    [self presentViewController:PersonalDataVC animated:YES completion:nil];
}
//获取验证码
- (void)idCodeButtonClick{
    
}
//注册
- (void)registButtonClick{
    PersonalDataViewController *registVC = [[PersonalDataViewController alloc] init];
    JTNavigationController *navVC = [[JTNavigationController alloc] initWithRootViewController:registVC];
    [self presentViewController:navVC animated:YES completion:nil];
}

#pragma mark ----- textFieldDelegate
- (void)textFieldDidChange:(UITextField *)sender {
    if (self.phoneTextF.text.length == 11 && self.idCodeTextF.text.length > 0) {
        [self.loginButton setBackgroundImage: [UIImage imageNamed:@"red"] forState:UIControlStateNormal];
        [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
        _loginButton.userInteractionEnabled = YES;
    }
    else {
        [self.loginButton setBackgroundImage: [UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
        [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
        _loginButton.userInteractionEnabled = NO;
    }

}
@end

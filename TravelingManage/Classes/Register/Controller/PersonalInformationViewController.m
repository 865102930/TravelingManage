//
//  PersonalInformationViewController.m
//  TravelingManage
//
//  Created by 戎翠林 on 17/2/9.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "PersonalInformationViewController.h"
#import "PersonalDataViewController.h"
#import "HomeViewController.h"
#import "LoginViewController.h"
@interface PersonalInformationViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UIImageView *backgroundImage;//背景图片
@property(nonatomic,strong)UIImageView *backImage;//返回
@property(nonatomic,strong)UITextField *nameTextF;//姓名
@property(nonatomic,strong)UITextField *idTextF;//身份证
@property(nonatomic,strong)UIButton    *backButton;//返回按钮
@property(nonatomic,strong)UILabel     *titleL;//标题
@property(nonatomic,strong)UILabel     *idCodeL;
@property(nonatomic,strong)UILabel     *promptL;//提示文字
@property(nonatomic,strong)UIButton    *nextButton;//下一步

@end

@implementation PersonalInformationViewController
#pragma  mark ----- lazy
- (UIButton *)backButton{
    if (!_backButton) {
        _backButton = [[UIButton alloc] init];
        [_backButton addTarget: self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_backButton];
        
    }
    return _backButton;
}

- (UIImageView *)backImage{
    if (!_backImage){
        _backImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-2"]];
        [self.view addSubview:_backImage];
    }
    return _backImage;
}

- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc] init];
        _titleL.text = @"设置个人信息";
        _titleL.textColor = RedColor;
        _titleL.font = [UIFont fontWithName:PingFang size:16];
        [self.view addSubview:_titleL];
    }
    return _titleL;
}

- (UIImageView *)backgroundImage{
    if (!_backgroundImage){
        _backgroundImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BackgroundImage"]];
        _backgroundImage.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self.view addSubview:_backgroundImage];
    }
    return _backgroundImage;
}

- (UITextField *)phoneTextF{
    if(!_nameTextF){
        _nameTextF = [UITextField textLeftImage:@"name" placeholder:@"请输入姓名" imageWidth:14 imageHeight:19 lineWidth: SCREEN_WIDTH - 48];
        [_nameTextF addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
        [self.view addSubview:_nameTextF];
    }
    return _nameTextF;
}
- (UITextField *)idTextF{
    if(!_idTextF){
        _idTextF = [UITextField textLeftImage:@"idNumber" placeholder:@"请输入身份证验证码" imageWidth:14 imageHeight:19 lineWidth: SCREEN_WIDTH - 48];
        [_idTextF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [_idTextF addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
        [self.view addSubview:_idTextF];
    }
    return _idTextF;
}

- (UILabel *)promptL{
    if (!_promptL){
        _promptL = [[UILabel alloc] init];
        _promptL.textColor = RedColor;
        _promptL.font = [UIFont fontWithName:PingFang size:13];
        [self.view addSubview:_promptL];
    }
    return _promptL;
}

- (UIButton *)nextButton{
    if (!_nextButton) {
        _nextButton = [[UIButton alloc] init];
        _nextButton.titleLabel.font = [UIFont fontWithName:PingFang size:15];
        [_nextButton setTintColor:kColorFFFF];
        [_nextButton addTarget:self action:@selector(getIntoButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _nextButton.userInteractionEnabled = NO;
        [self.view addSubview:_nextButton];
    }
    return _nextButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    _user = [NSUserDefaults standardUserDefaults];
    [self creatUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma  mark ----- creatUI
- (void)creatUI{
    self.backgroundImage.userInteractionEnabled = YES;
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(0);
        make.size.mas_equalTo(CGSizeMake(64, 64));
    }];
    
    [self.backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.top.equalTo(self.view).offset(29);
        make.size.mas_equalTo(CGSizeMake(9, 17));
    }];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.backImage);
        make.centerX.mas_equalTo(self.view);
    }];
    
    [self.phoneTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-24);
        make.top.equalTo(self.backImage.mas_bottom).offset(41);
        make.height.mas_equalTo(42);
    }];
    
    [self.idTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(24);
        make.right.equalTo(self.view).offset(-24);
        make.top.equalTo(self.phoneTextF.mas_bottom).offset(24);
        make.height.mas_equalTo(42);
    }];
    
    [self.nextButton setBackgroundImage: [UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
    [self.nextButton setTitle:@"马上进入" forState:UIControlStateNormal];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(17);
        make.right.equalTo(self.view).offset(-17);
        make.top.equalTo(_idTextF.mas_bottom).offset(50);
        make.height.mas_equalTo(42);
    }];
    self.idTextF.delegate = self;
    self.nameTextF.delegate = self;
}

#pragma mark ----- textFieldDidChange
- (void) textFieldDidChange:(UITextField *)sender {
    if (_idTextF.text.length == 0){
        [self.promptL setHidden:NO];
        self.promptL.text = @"身份证号为空";
        [self.promptL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(24);
            make.top.equalTo(_idTextF.mas_bottom).offset(17);
        }];
    }
    if (_idTextF.text.length != 18){
        [self.promptL setHidden:NO];
        self.promptL.text = @"身份证号输入错误,请重新输入";
        [self.promptL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(24);
            make.top.equalTo(_idTextF.mas_bottom).offset(17);
        }];
    }else {
        [self.promptL setHidden:YES];
    }
}

#pragma mark ----- buttonClick
//已阅读
- (void)agreeClick: (UIButton *)button{

}
//马上进入
- (void)getIntoButtonClick{
//    [_user setObject:self.nameTextF.text forKey:@"name"];
//    [_user setObject:self.idTextF.text forKey:@"IDCardNum"];
//    [_user synchronize];
//    HomeViewController *homeVc = [[HomeViewController alloc] init];
    LoginViewController *LoginVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:LoginVC animated:YES];
}
//返回
- (void)backButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ----- textFieldDelegate
- (void)textFieldChange:(UITextField *)sender {
    if (self.nameTextF.text.length > 0 && self.idTextF.text.length == 18) {
        [self.nextButton setBackgroundImage: [UIImage imageNamed:@"red"] forState:UIControlStateNormal];
        [self.nextButton setTitle:@"马上进入" forState:UIControlStateNormal];
        _nextButton.userInteractionEnabled = YES;
    }
    else {
        [self.nextButton setBackgroundImage: [UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
        [self.nextButton setTitle:@"马上进入" forState:UIControlStateNormal];
        _nextButton.userInteractionEnabled = NO;
    }
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end

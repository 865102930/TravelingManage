//
//  NewVerificationCodeViewController.m
//  TravelingManage
//
//  Created by 戎翠林 on 17/3/3.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "NewVerificationCodeViewController.h"
#import "NewPhoneNueViewController.h"

@interface NewVerificationCodeViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UIImageView *backgroundImage;//背景图片
@property(nonatomic,strong)UITextField *idCodeTextF;//验证码
@property(nonatomic,strong)UIImageView *backImage;//返回
@property(nonatomic,strong)UIButton    *backButton;//返回按钮
@property(nonatomic,strong)UIButton    *idCodeButton;//验证码按钮
@property(nonatomic,strong)UILabel     *titleL;//标题
@property(nonatomic,strong)UILabel     *idCodeL;
@property(nonatomic,strong)UILabel     *phoneNum;//手机号
@property(nonatomic,strong)UIButton    *nextButton;//下一步
//短信倒计时
@property (nonatomic, assign) NSTimeInterval durationToValidity;
//定时器
@property (nonatomic, strong, readwrite) NSTimer *timer;

@end

@implementation NewVerificationCodeViewController

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
        _titleL.text = @"输入验证码";
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

- (UILabel *)idCodeL{
    if (!_idCodeL){
        _idCodeL = [[UILabel alloc] init];
        _idCodeL.text = @"验证码已发送至";
        _idCodeL.textColor = [UIColor colorWithHexString:@"656565"];
        _idCodeL.font = [UIFont fontWithName:PingFang size:13];
        [self.view addSubview:_idCodeL];
    }
    return _idCodeL;
}

- (UILabel *)phoneNum{
    if (!_phoneNum){
        _phoneNum = [[UILabel alloc] init];
        _phoneNum.textColor = RedColor;
        _phoneNum.font = [UIFont fontWithName:PingFang size:13];
        [self.view addSubview:_phoneNum];
    }
    return _phoneNum;
}

- (UIButton *)nextButton{
    if (!_nextButton) {
        _nextButton = [[UIButton alloc] init];
        _nextButton.titleLabel.font = [UIFont fontWithName:PingFang size:15];
        [_nextButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _nextButton.userInteractionEnabled = NO;
        [self.view addSubview:_nextButton];
    }
    return _nextButton;
}


#pragma  mark ----- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    _user = [NSUserDefaults standardUserDefaults];
    [_user synchronize];
}

#pragma  mark ----- viewWillAppear
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
    
    [self.idCodeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(27);
        make.top.equalTo(_backImage.mas_bottom).offset(21);
    }];
    
    self.phoneNum.text = [NSString stringWithFormat:@"%@",self.oldPhone_text];
    [self.phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_idCodeL.mas_right).offset(5);
        make.top.equalTo(_backImage.mas_bottom).offset(21);
    }];
    
    //验证码
    [self.idCodeTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(24);
        make.right.equalTo(self.view).offset(-(111+17+24));
        make.top.equalTo(_idCodeL.mas_bottom).offset(10);
        make.height.mas_equalTo(42);
    }];
    
    //获取验证码按钮
    [self.idCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.idCodeTextF.mas_right).offset(17);
        make.right.equalTo(self.view).offset(-(24));
        make.top.equalTo(_idCodeL.mas_bottom).offset(10);
        make.height.mas_equalTo(42);
    }];
    
    [self.nextButton setBackgroundImage: [UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
    [self.nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(17);
        make.right.equalTo(self.view).offset(-17);
        make.top.equalTo(_idCodeTextF.mas_bottom).offset(20);
        make.height.mas_equalTo(42);
    }];
    self.idCodeTextF.delegate = self;
}

#pragma mark ----- 网络请求
//获取验证码
- (void)getVerificationCode{
    __weak __typeof(self)wself = self;
    NSDictionary *dictParament = @{
                                   @"mobile" : self.oldPhone_text
                                   };
    [GRNetRequestClass POST:REQUESTREGISTVERIFICATIONURL params:dictParament success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"获取验证码:%@",responseObject);
          NSLog(@"获取验证码dictParament:%@",responseObject);
        if (responseObject) {
            if ([responseObject[@"msg"] isEqualToString:@"success"]){
                [wself startUpTimer];
                [MBProgressHUD showHUDMsg:@"验证码发送成功"];
            }else{
                [wself invalidateTimer];
                [MBProgressHUD showHUDMsg:@"获取验证码失败"];
            }
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [wself invalidateTimer];
        if (error.code == NSURLErrorCancelled) return;
        [MBProgressHUD showHUDMsg:@"网络连接错误"];
    }];
}

//修改手机号
- (void)modifyPhoneNumber{
    __weak __typeof(self)wself = self;
    NSDictionary *dictParament = @{
                                   @"type" : @1,
                                   @"userId" : [_user objectForKey:@"userId"],
                                   @"randomcode" : self.idCodeTextF.text,
                                   @"phone" : self.oldPhone_text,
                                   };
       NSLog(@"修改手机号dictParament:%@",dictParament);
    [GRNetRequestClass POST:CODECHECK params:dictParament success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"修改手机号:%@",responseObject);
        if (responseObject) {
            if ([responseObject[@"msg"] isEqualToString:@"success"]){
                NewPhoneNueViewController *newPhoneNumVC = [[NewPhoneNueViewController alloc] init];
                newPhoneNumVC.oldPhone_text = self.oldPhone_text;
                [wself.navigationController pushViewController:newPhoneNumVC animated:YES];
            }else if ([responseObject[@"msg"] isEqualToString:@"fail"]){
                [MBProgressHUD showHUDMsg:@"验证码错误"];
            }
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [wself invalidateTimer];
        if (error.code == NSURLErrorCancelled) return;
        [MBProgressHUD showHUDMsg:@"网络连接错误"];
    }];
}




#pragma mark ----- buttonClick
//获取验证码
- (void)idCodeButtonClick{
    [self getVerificationCode];
}

//下一步
- (void)nextButtonClick{
    NSLog(@"%@",self.navigationController.childViewControllers);
    [self modifyPhoneNumber];
}

//返回
- (void)backButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ----- textFieldDelegate
- (void)textFieldDidChange:(UITextField *)sender {
    if (sender.text.length > 0) {
        [self.nextButton setBackgroundImage: [UIImage imageNamed:@"red"] forState:UIControlStateNormal];
        [self.nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        _nextButton.userInteractionEnabled = YES;
    }else {
        [self.nextButton setBackgroundImage: [UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
        [self.nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        _nextButton.userInteractionEnabled = NO;
    }
}

#pragma mark ----- 定时器 -----
//定时器
- (void)startUpTimer{
    _durationToValidity = 60;
    [self.idCodeButton setTitle:[NSString stringWithFormat:@"%.0f 秒", _durationToValidity] forState:UIControlStateNormal];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(redrawTimer:)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)invalidateTimer{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)redrawTimer:(NSTimer *)timer {
    _durationToValidity--;
    if (_durationToValidity > 0) {
        self.idCodeButton.titleLabel.text = [NSString stringWithFormat:@"%.0f 秒", _durationToValidity];//防止 button_title 闪烁
        [self.idCodeButton setTitle:[NSString stringWithFormat:@"%.0f 秒", _durationToValidity] forState:UIControlStateNormal];
        self.idCodeButton.userInteractionEnabled = NO;
    }else{
        [self invalidateTimer];
        [self.idCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.idCodeButton.userInteractionEnabled = YES;
    }
}
@end

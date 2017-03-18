//
//  NewPhoneNueViewController.m
//  TravelingManage
//
//  Created by 戎翠林 on 17/3/3.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "NewPhoneNueViewController.h"
#import "NewPhoneVerificationViewController.h"
@interface NewPhoneNueViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UIImageView *backgroundImage;//背景图片
@property(nonatomic,strong)UIImageView *backImage;//返回
@property(nonatomic,strong)UITextField *phoneTextF;//手机号
@property(nonatomic,strong)UILabel     *titleL;//标题
//@property(nonatomic,strong)UIButton    *agreeButton;//已阅读
@property(nonatomic,strong)UIButton    *backButton;//返回按钮
@property(nonatomic,strong)UIButton    *nextButton;//下一步

@end

@implementation NewPhoneNueViewController

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
        _titleL.text = @"输入新手机号";
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
    if(!_phoneTextF){
        _phoneTextF = [UITextField textLeftImage:@"phoneNum" placeholder:@"请输入手机号" imageWidth:14 imageHeight:19 lineWidth: SCREEN_WIDTH - 48];
        [_phoneTextF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _phoneTextF.keyboardType = UIKeyboardTypeNumberPad;
        [self.view addSubview:_phoneTextF];
    }
    return _phoneTextF;
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
        make.left.equalTo(self.view).offset(24);
        make.right.equalTo(self.view).offset(-24);
        make.top.equalTo(self.backImage.mas_bottom).offset(31);
        make.height.mas_equalTo(42);
    }];
    
    [self.nextButton setBackgroundImage: [UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
    [self.nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(17);
        make.right.equalTo(self.view).offset(-17);
        make.top.equalTo(_phoneTextF.mas_bottom).offset(35);
        make.height.mas_equalTo(42);
    }];
    
    self.phoneTextF.delegate = self;
}

#pragma mark ----- buttonClick
//下一步
- (void)nextButtonClick{
    if ([self.phoneTextF.text isEqualToString: self.oldPhone_text]) {
        [MBProgressHUD showHUDMsg:@"新旧手机号重复"];
        return;
    }
    [self queryInformation];
}
//返回
- (void)backButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark ----- 网络请求
//获取验证码
- (void)getVerificationCode{
    NSDictionary *dictParament = @{
                                   @"mobile":self.phoneTextF.text,
                                   };
    [GRNetRequestClass POST:REQUESTREGISTVERIFICATIONURL params:dictParament success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"获取验证码:%@",responseObject);
        if (responseObject) {
            if ([responseObject[@"msg"] isEqualToString:@"success"]){
                [MBProgressHUD showHUDMsg:@"验证码已发送至手机"];
                NewPhoneVerificationViewController *newPhoneVVC = [[NewPhoneVerificationViewController alloc] init];
                newPhoneVVC.oldPhoneNum = self.oldPhone_text;
                newPhoneVVC.NewPhoneNum = self.phoneTextF.text;
                [self.navigationController pushViewController:newPhoneVVC animated:YES];
            }else{
                [MBProgressHUD showHUDMsg:@"获取验证码失败"];
            }
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error.code == NSURLErrorCancelled) return;
        [MBProgressHUD showHUDMsg:@"网络连接错误"];
    }];
}

//根据手机号查询用户信息
- (void)queryInformation {
    NSDictionary *dictParament = @{
                                   @"userMobile":self.phoneTextF.text,
                                   };
    [GRNetRequestClass POST:QUERYUSER params:dictParament success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"获取验证码:%@",responseObject);
        if (responseObject) {
            if ([responseObject[@"msg"] isEqualToString:@"success"]){
                [self getVerificationCode];
            }else if ([responseObject[@"msg"] isEqualToString:@"exist"]){
                [MBProgressHUD showHUDMsg:@"该手机号已存在"];
            }
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error.code == NSURLErrorCancelled) return;
        [MBProgressHUD showHUDMsg:@"网络连接错误"];
    }];
}



#pragma mark ----- textFieldDelegate
- (void)textFieldDidChange:(UITextField *)sender {
    if (sender.text.length == 11) {
        [self.nextButton setBackgroundImage: [UIImage imageNamed:@"red"] forState:UIControlStateNormal];
        [self.nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        _nextButton.userInteractionEnabled = YES;
        //        NSLog(@"------------sender的内容是 :%@",sender.text);
        //        self.phoneNumber = sender.text;
    }else {
        [self.nextButton setBackgroundImage: [UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
        [self.nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        _nextButton.userInteractionEnabled = NO;
        
    }
}


@end

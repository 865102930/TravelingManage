//
//  PersonalInformationViewController.m
//  TravelingManage
//
//  Created by 戎翠林 on 17/2/9.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "PersonalInformationViewController.h"
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
        _idTextF.keyboardType = UIKeyboardTypeNumberPad;
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
    _user = [NSUserDefaults standardUserDefaults];
    [_user synchronize];
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
}

#pragma mark ----- buttonClick
//已阅读
- (void)agreeClick: (UIButton *)button{

}
//马上进入
- (void)getIntoButtonClick{
    if (_idTextF.text.length != 18){
        [self.promptL setHidden:NO];
        self.promptL.text = @"身份证号输入错误,请重新输入";
        [self.promptL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(24);
            make.top.equalTo(_idTextF.mas_bottom).offset(17);
        }];
    }else {
        [self.promptL setHidden:YES];
        [self userRegister];
    }
}

//注册
- (void)userRegister {
    if ([self isCorrect:self.idTextF.text] == NO) {//如果为YES就是正确的
        [MBProgressHUD showHudTipStr:@"请输入正确的身份证号码!" contentColor:HidWithColorContentBlack];
        return;
    }else {
        [self requestIdCardIsRegister];
    }
//    NSDictionary *dictParaments = @{
//                                    @"userMobile": self.phoneNum_text,
//                                    @"idCard"    : self.idTextF.text,
//                                    @"userName"  : self.nameTextF.text,
//                                    };
//    [GRNetRequestClass POST:REGISTURL params:dictParaments success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"注册responseObject:%@",responseObject);
//        NSLog(@"注册dictParaments:%@",dictParaments);
//        if ([responseObject[@"msg"] isEqualToString:@"success"]) {
//            [MBProgressHUD showHUDMsg:@"注册成功"];
////            LoginViewController *LoginVC = [[LoginViewController alloc] init];
////            [self.navigationController pushViewController:LoginVC animated:YES];
//            //登录
//            [self requestLogin];
//        }else{
//            [MBProgressHUD showHUDMsg:@"该手机号已注册"];
//        }
//    } fail:^(NSURLSessionDataTask *task, NSError *error) {
//        if (error.code == NSURLErrorCancelled) return;
//        [MBProgressHUD showHUDMsg:@"网络连接错误"];
//    }];
}

#pragma mark - 判断身份证是否注册过
- (void)requestIdCardIsRegister
{
    NSDictionary *dictParams = @{
                                 @"idCard":self.idTextF.text
                                 };
    NSLog(@"--------参数是 :%@",dictParams);
    __weak __typeof(self)wself = self;
    [GRNetRequestClass POST:USERREGISTERIDCARDURL params:dictParams success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"msg"] isEqualToString:@"repeat"]) {
            [MBProgressHUD showHudTipStr:@"该身份证已注册" contentColor:HidWithColorContentBlack];
        }else if ([[responseObject objectForKey:@"msg"] isEqualToString:@"success"]) {
            [wself requestWithIdCardRegister];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"--------error : %@",error);
            [MBProgressHUD showHudTipStr:@"可能是网络错误" contentColor:HidWithColorContentBlack];
        }
    }];
}

#pragma Mark- 注册接口
- (void)requestWithIdCardRegister
{
    NSDictionary *dictParaments = @{
                                    @"userMobile": self.phoneNum_text,
                                    @"idCard"    : self.idTextF.text,
                                    @"userName"  : self.nameTextF.text,
                                    };
    [GRNetRequestClass POST:REGISTURL params:dictParaments success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"注册responseObject:%@",responseObject);
        NSLog(@"注册dictParaments:%@",dictParaments);
        if ([responseObject[@"msg"] isEqualToString:@"success"]) {
            [MBProgressHUD showHUDMsg:@"注册成功"];
    //            LoginViewController *LoginVC = [[LoginViewController alloc] init];
    //            [self.navigationController pushViewController:LoginVC animated:YES];
            //登录
            [self requestLogin];
        }else{
            [MBProgressHUD showHUDMsg:@"该手机号已注册"];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error.code == NSURLErrorCancelled) return;
        [MBProgressHUD showHUDMsg:@"网络连接错误"];
    }];
}

//登录请求
- (void)requestLogin
{
    __weak typeof(self) weakself = self;
    NSDictionary *dictParaments = @{
                                    @"userMobile" : self.phoneTextF.text,
                                    //  @"registrationId":@"10"
                                    @"code" : self.idCode_text,
                                    };
    [GRNetRequestClass POST:LOGINURL params:dictParaments success:^(NSURLSessionDataTask *task, id responseObject) {
        [MBProgressHUD hidenHud];
        if (responseObject) {
            if ([responseObject[@"msg"] isEqualToString:@"success"]) {
                NSDictionary *dict = responseObject[@"object"];
                [_user setObject:dict[@"id"]forKey:@"userId"];
                [_user setObject:dict[@"userMobile"]forKey:@"phone"];
                [_user setObject:dict[@"userName"]forKey:@"userName"];
                [_user setObject:dict[@"idCard"]forKey:@"idCard"];
                [_user synchronize];
                NSLog(@"----------------------------登录后得到的返回值------------------------------:%@",responseObject);
                NSLog(@"phone:%@",[_user objectForKey:@"phone"]);
                NSLog(@"userId:%@",[_user objectForKey:@"userId"]);
                NSLog(@"userName:%@",[_user objectForKey:@"userName"]);
                NSLog(@"idCard:%@",[_user objectForKey:@"idCard"]);
                HomeViewController *homeVC = [[HomeViewController alloc] init];
                [weakself.navigationController pushViewController:homeVC animated:YES];
            }
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD hidenHud];
        if (error.code == NSURLErrorCancelled) return;
    }];
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

/**
 *  验证身份证号码是否正确的方法
 *
 *  @param IDNumber 传进身份证号码字符串
 *
 *  @return 返回YES或NO表示该身份证号码是否符合国家标准
 */
- (BOOL)isCorrect:(NSString *)IDNumber
{
    NSMutableArray *IDArray = [NSMutableArray array];
    // 遍历身份证字符串,存入数组中
    for (int i = 0; i < 18; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [IDNumber substringWithRange:range];
        [IDArray addObject:subString];
    }
    // 系数数组
    NSArray *coefficientArray = [NSArray arrayWithObjects:@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2", nil];
    // 余数数组
    NSArray *remainderArray = [NSArray arrayWithObjects:@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2", nil];
    // 每一位身份证号码和对应系数相乘之后相加所得的和
    int sum = 0;
    for (int i = 0; i < 17; i++) {
        int coefficient = [coefficientArray[i] intValue];
        int ID = [IDArray[i] intValue];
        sum += coefficient * ID;
    }
    // 这个和除以11的余数对应的数
    NSString *str = remainderArray[(sum % 11)];
    // 身份证号码最后一位
    NSString *string = [IDNumber substringFromIndex:17];
    // 如果这个数字和身份证最后一位相同,则符合国家标准,返回YES
    if ([str isEqualToString:string]) {
        return YES;
    } else {
        return NO;
    }
}


@end

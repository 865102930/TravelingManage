//
//  PersonalDataViewController.m
//  TravelingManage
//
//  Created by 戎翠林 on 17/2/9.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "PersonalDataViewController.h"
#import "PersonalDetailCell.h"
#import "PersonDetail2Cell.h"
#import "NewVerificationCodeViewController.h"
#import "HomeViewController.h"
#import "UIBarButtonItem+Item.h"
@interface PersonalDataViewController ()
@property (nonatomic, strong) UILabel *title_label;
@property(nonatomic,strong)UIImageView *backImage;//返回
@property(nonatomic,strong)UIButton    *backButton;//返回按钮
@property(nonatomic,strong)UILabel     *titleL;//标题
@property(nonatomic,strong)UIView      *headerView;
@property(nonatomic,strong)UIView      *lineView;
@end

@implementation PersonalDataViewController
#pragma  mark ----- lazy
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        _headerView.backgroundColor = [UIColor whiteColor];
        self.tableView.tableHeaderView = _headerView;
        [self.view addSubview:_headerView];
    }
    return _headerView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 0.6);
        [self.view addSubview:_lineView];
    }
    return _lineView;
}

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
        _backImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back"]];
        [self.view addSubview:_backImage];
    }
    return _backImage;
}

- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc] init];
        _titleL.text = @"我的账户";
        _titleL.textColor = kColor8383;
        _titleL.font = [UIFont fontWithName:PingFang size:16];
        [self.view addSubview:_titleL];
    }
    return _titleL;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [[UITableView alloc] init];
    self.tableView.tableHeaderView = self.headerView;
    _user = [NSUserDefaults standardUserDefaults];
    [self creatUI];
    self.tableView.scrollEnabled = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma  mark ----- creatUI
- (void)creatUI{
     self.lineView.backgroundColor = kColor8383;
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
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        PersonalDetailCell *personDetailCell = [PersonalDetailCell initWithTableView:tableView];
        personDetailCell.title.text = @"姓名";
        personDetailCell.content.text = [_user objectForKey:@"userName"];
        personDetailCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return personDetailCell;
    }else if (indexPath.row == 1){
        PersonalDetailCell *personDetailCell = [PersonalDetailCell initWithTableView:tableView];
        personDetailCell.title.text = @"身份证号";
        personDetailCell.content.text = [_user objectForKey:@"idCard"];
        personDetailCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return personDetailCell;
    }else{
        PersonDetail2Cell *personDetailCell = [PersonDetail2Cell initWithTableView:tableView];
        personDetailCell.title.text = @"电话";
        personDetailCell.content.text = [_user objectForKey:@"phone"];
        return personDetailCell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        [self getVerificationCode];//获取验证码
        NewVerificationCodeViewController * VerificationCodeVC = [[NewVerificationCodeViewController alloc] init];
        VerificationCodeVC.oldPhone_text = [_user objectForKey:@"phone"];
        [self.navigationController pushViewController:VerificationCodeVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

#pragma mark ----- 按钮点击事件 -----
- (void)backButtonClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ----- 网络请求
//获取验证码
- (void)getVerificationCode{
    NSDictionary *dictParament = @{
                                   @"mobile":[_user objectForKey:@"phone"]
                                   };
    [GRNetRequestClass POST:REQUESTREGISTVERIFICATIONURL params:dictParament success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"获取验证码:%@",responseObject);
        if (responseObject) {
            if ([responseObject[@"msg"] isEqualToString:@"success"]){
                [MBProgressHUD showHUDMsg:@"验证码已发送至手机"];
            }else{
                [MBProgressHUD showHUDMsg:@"获取验证码失败"];
            }
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error.code == NSURLErrorCancelled) return;
        [MBProgressHUD showHUDMsg:@"网络连接错误"];
    }];
}

@end

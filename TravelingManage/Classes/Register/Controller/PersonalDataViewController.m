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
#import "VerificationCodeViewController.h"
#import "HomeViewController.h"
#import "UIBarButtonItem+Item.h"
@interface PersonalDataViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UILabel *title_label;
@end

@implementation PersonalDataViewController

- (UILabel *)title_label {
    if (_title_label == nil) {
        _title_label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.XFJ_centerX, 6, 100, 44)];
        _title_label.text = @"我的账户";
        _title_label.textColor = kColor6565;
        _title_label.textAlignment = NSTextAlignmentCenter;
    }
    return _title_label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = self.title_label;
    self.tableView.tableFooterView = [[UITableView alloc] init];
    _user = [NSUserDefaults standardUserDefaults];
    if (self.isVerificationCodeVC) {
        [self setupNavBar];
    }
    NSInteger num = self.navigationController.viewControllers.count;
    if (num >= 1) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleNavigationTransition:)];
        [self.view addGestureRecognizer:pan];
        pan.delegate = self;
        
    }
}

- (void)handleNavigationTransition:(UIPanGestureRecognizer *)pan
{
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
    VerificationCodeViewController * VerificationCodeVC = [[VerificationCodeViewController alloc] init];
    VerificationCodeVC.registTextField_text = [_user objectForKey:@"phone"];
    [self.navigationController pushViewController:VerificationCodeVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}


// 设置导航条内容
- (void)setupNavBar
{
    // 左边
    UIBarButtonItem *left = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"back"] highImage:[UIImage imageNamed:@"back"] title:nil target:self action:@selector(onClickBack)];
    self.navigationItem.leftBarButtonItem = left;
}

- (void)onClickBack {
    NSInteger num = self.navigationController.viewControllers.count;
    NSLog(@"%ld",(long)num);
//    if (num >= 1) {
//        UIViewController *popVC = self.navigationController.viewControllers[num - 1];
//        [self.navigationController popToViewController:popVC animated:YES];
//        HomeViewController *homeVC = [[HomeViewController alloc] init];
//        [self.navigationController popToViewController:homeVC animated:YES];
//    }else{
//        [self.navigationController popViewControllerAnimated:YES];
//    }

//    HomeViewController *homeVC = [[HomeViewController alloc] init];
//    [self.navigationController popToViewController:homeVC animated:NO];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}


@end

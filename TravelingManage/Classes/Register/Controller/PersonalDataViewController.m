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
@interface PersonalDataViewController ()
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
        personDetailCell.content.text = @"张三";
        personDetailCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return personDetailCell;
    }else if (indexPath.row == 1){
        PersonalDetailCell *personDetailCell = [PersonalDetailCell initWithTableView:tableView];
        personDetailCell.title.text = @"身份证号";
        personDetailCell.content.text = @"123123123231231233";
        personDetailCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return personDetailCell;
    }else{
        PersonDetail2Cell *personDetailCell = [PersonDetail2Cell initWithTableView:tableView];
        personDetailCell.title.text = @"电话";
        personDetailCell.content.text = @"12312312312";
        return personDetailCell;
    }
    return nil;
}
// git rm files

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}


@end

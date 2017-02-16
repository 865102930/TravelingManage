//
//  MessageViewController.m
//  TravelingManage
//
//  Created by 戎翠林 on 17/2/10.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageCell.h"
#import "MessageModel.h"
@interface MessageViewController ()
@property (nonatomic, strong) NSMutableArray<MessageModel *> *messageModel;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = BackgroudColor;
    self.tableView.contentInset = UIEdgeInsetsMake(67, 0, 48, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}


#pragma mark   ----------tableViewDelegate datasource----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCell *cell = [MessageCell initWithTableView:tableView];
    cell.indexPath = indexPath;
    cell.titleLabel.text = @"签退通知";
    cell.contentLabel.text = @"您有一条签退通知";
    cell.timeLabel.text = @"2017-01-07";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 78;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 删除模型
    [self.messageModel removeObjectAtIndex:indexPath.row];
    //刷新
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}

@end

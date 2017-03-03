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
@property (nonatomic, strong) NSMutableArray<MessageModel *> *messageModelArr;
@end

@implementation MessageViewController
- (NSMutableArray<MessageModel *> *)messageModelArr{
    if (!_messageModelArr){
        _messageModelArr = [NSMutableArray array];
    }
    return _messageModelArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = BackgroudColor;
    self.tableView.contentInset = UIEdgeInsetsMake(67, 0, 48, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.tableFooterView = [[UITableView alloc] init];
    [self loadData];
    [MBProgressHUD showLoadHUD];
}

- (void)loadData
{
    NSDictionary *dictParaments = @{
                                    @"userId":@7,
                                    };
    __weak __typeof(self)wself = self;
    [GRNetRequestClass POST:MESSAGELIST params:dictParaments success:^(NSURLSessionDataTask *task, id responseObject) {
        [MBProgressHUD hidenHud];
        if (responseObject) {
            NSMutableArray *messageArray = [responseObject objectForKey:@"rows"];
            _messageModelArr = [MessageModel mj_objectArrayWithKeyValuesArray:messageArray];
            NSLog(@"responseObject:%@",responseObject);
            [wself.tableView reloadData];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD hidenHud];
        if (error.code == NSURLErrorCancelled) return;
    }];
}

- (void)messageRead{
    NSString *Id = [NSString stringWithFormat:@"%ld",(long)self.messageModel.message_id];
    NSDictionary *dictParaments = @{
                                    @"id":Id,
                                    };
    __weak __typeof(self)wself = self;
    [GRNetRequestClass POST:MESSAGEREAD params:dictParaments success:^(NSURLSessionDataTask *task, id responseObject) {
        [MBProgressHUD hidenHud];
        if (responseObject) {
            NSLog(@"messageArray:%@",responseObject);
            [wself.tableView reloadData];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD hidenHud];
        if (error.code == NSURLErrorCancelled) return;
    }];
}

#pragma mark   ----------tableViewDelegate datasource----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _messageModelArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCell *cell = [MessageCell initWithTableView:tableView];
    cell.indexPath = indexPath;
    cell.messageM = self.messageModelArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self messageRead];
//    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 78;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *Id = [NSString stringWithFormat:@"%ld",(long)self.messageModel.message_id];
    NSDictionary *dictParaments = @{
                                    @"id":Id,
                                    };
    __weak __typeof(self)wself = self;
    [GRNetRequestClass POST:DELMESSAGE params:dictParaments success:^(NSURLSessionDataTask *task, id responseObject) {
        [MBProgressHUD hidenHud];
        if (responseObject) {
            NSLog(@"messageArray:%@",responseObject);
            // 删除模型
            if([responseObject[@"msg"] isEqualToString:@"success"]){
                [self.messageModelArr removeObjectAtIndex:indexPath.row];
                //刷新
                [wself.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            }
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD hidenHud];
        if (error.code == NSURLErrorCancelled) return;
    }];
}

@end

//
//  XFJAnnouncementViewController.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/10.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJAnnouncementViewController.h"
#import "AnnouncementDetailViewController.h"
#import "PageButton.h"
#import "AnnouncementModel.h"
#import "AnnouncementCell.h"

@interface XFJAnnouncementViewController ()
@property (nonatomic, strong) NSMutableArray<AnnouncementModel *> *announcementModels;
@property (nonatomic, assign) NSInteger announcementModel_id;//编号
@end

@implementation XFJAnnouncementViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = BackgroudColor;
    self.tableView.contentInset = UIEdgeInsetsMake(67, 0, 40, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = NO;
    [self loadData];
    [MBProgressHUD showLoadHUD];
}

//加载数据
//- (void)loadData{
//    [[NetWorkManager shareManager] requestWithType:HttpRequestTypePost withUrlString:ANNOUNCEMENTLIST withParaments:nil withSuccessBlock:^(id object) {
//        NSMutableArray *dictArr = object[@"rows"];
//        NSLog(@"%@",dictArr);
////        _announcementModel = [AnnouncementModel mj_objectArrayWithKeyValuesArray:dictArr];
//        
//    } withFailureBlock:^(NSError *error) {
//        
//    } progress:^(float progress) {
//        
//    }];
//}

- (void)loadData{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSDictionary *dictParameters = @{
                                     @"userId":[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"],//用户Id
                                     @"Page":@1,//页数
                                     @"rows":@10//行数
                                     };
    [mgr POST:ANNOUNCEMENTLIST parameters:dictParameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        [MBProgressHUD hidenHud];
        NSArray *dictArr = responseObject[@"rows"];
        _announcementModels = [AnnouncementModel mj_objectArrayWithKeyValuesArray:dictArr];
        [self.tableView reloadData];
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hidenHud];
        if (error.code == NSURLErrorCancelled) return;
    }];
}


#pragma mark   ----------tableViewDelegate datasource----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"-----------公告模型的数量是 :%zd",self.announcementModels.count);
    return self.announcementModels.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AnnouncementCell *cell = [AnnouncementCell initWithTableView:tableView];
    cell.announcementM = self.announcementModels[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AnnouncementModel * model = self.announcementModels[indexPath.row];
    AnnouncementDetailViewController *detailVC = [[AnnouncementDetailViewController alloc] init];
    detailVC.Id = model.AnnouncementModel_id;
//    self.announcementModel_id = model.AnnouncementModel_id;
//    [self loadAnnouncementRead];
    [self.navigationController pushViewController:detailVC animated:YES];
}

//公告已读
- (void)loadAnnouncementRead{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSString *Id = [NSString stringWithFormat:@"%ld", (long)self.announcementModel_id];
    NSDictionary *parameters = @{
                                 @"id" : Id
                                 };
    [mgr POST:ANNOUNCEMENTREAD parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
      
        NSLog(@"%@",responseObject);
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code == NSURLErrorCancelled) return;
        
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 165 + 8;
}

@end

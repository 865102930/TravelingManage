//
//  XFJAllTaskViewController.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/15.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJAllTaskViewController.h"
#import "XFJAllTaskTableViewCell.h"
#import "XFJFindTeamInfoByStateItem.h"
#import "XFJTeamMessageViewController.h"
#import "XFJOpenGroupViewController.h"
#import "XFJMeDetailsViewController.h"

@interface XFJAllTaskViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *allTaskTableView;
@property (nonatomic, strong) NSMutableArray <XFJFindTeamInfoByStateItem *> *findTeamInfoByStateItem_array;

@end

@implementation XFJAllTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    [self setUpAllTableView];
    
    //请求接口
    [self requestAllStates];
    
}

- (NSMutableArray <XFJFindTeamInfoByStateItem *> *)findTeamInfoByStateItem_array
{
    if (_findTeamInfoByStateItem_array == nil) {
        _findTeamInfoByStateItem_array = [NSMutableArray array];
    }
    return _findTeamInfoByStateItem_array;
}

#pragma mark - 对服务器的请求类型
- (XFJStateType)type
{
    return -1;
}

- (void)requestAllStates
{
    //取消任务后删除之前所有的数组,然后添加
    [self.findTeamInfoByStateItem_array removeAllObjects];
    [MBProgressHUD showLoadHUD];
    NSDictionary *dictParaments = @{
                                    @"userId":[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"],
                                    @"teamState":(self.type == -1) ? @"" : @(self.type)
                                    };
    __weak __typeof(self)wself = self;
    NSLog(@"-------(((((((()))))))0传递的参数是:%@",dictParaments);
    [[NetWorkManager shareManager] requestWithType:HttpRequestTypeGet withUrlString:FINDTEAMINFOBYSTATEUEL withParaments:dictParaments withSuccessBlock:^(id object) {
        if (object) {
            NSLog(@"--------======++++---返回的请求信息是:%@",object);
            [MBProgressHUD hidenHud];
            NSMutableArray *find_array = [object objectForKey:@"rows"];
            [wself.findTeamInfoByStateItem_array addObjectsFromArray:[XFJFindTeamInfoByStateItem mj_objectArrayWithKeyValuesArray:find_array]];
            [wself.allTaskTableView reloadData];
        }
    } withFailureBlock:^(NSError *error) {
        if (error) {
            NSLog(@"----+++++++返回的请求错误信息是:%@",error);
            [MBProgressHUD hidenHud];
        }
    } progress:^(float progress) {
        
    }];
}

- (void)setUpAllTableView
{
    [self.view addSubview:self.allTaskTableView];
    [self.allTaskTableView registerClass:[XFJAllTaskTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJAllTaskTableViewCell];
}

- (UITableView *)allTaskTableView
{
    if (_allTaskTableView == nil) {
        _allTaskTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _allTaskTableView.backgroundColor = kColoreeee;
        //去掉分割线
        _allTaskTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _allTaskTableView.delegate = self;
        _allTaskTableView.dataSource = self;
        _allTaskTableView.contentInset = UIEdgeInsetsMake(0, 0, 110, 0);
    }
    return _allTaskTableView;
}

#pragma mark - 组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.findTeamInfoByStateItem_array count];
}

#pragma mark - cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const cellID = @"cellID";
    XFJAllTaskTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[XFJAllTaskTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    __weak __typeof(self)wself = self;
    cell.alreadyTeamBlock = ^(UIButton *button) {
        UITableViewCell *cell = (UITableViewCell *)[button superview];
        NSIndexPath *path = [self.allTaskTableView indexPathForCell:cell];
        //这里可以获取到cell是具体是哪一个,就可以传相应的id
        NSLog(@"----------+++++++-------index row%zd", [path row]);
        //点击重新开始后,跳转到开团界面
        XFJOpenGroupViewController *openGroupViewController = [[XFJOpenGroupViewController alloc] init];
        openGroupViewController.findTeamInfoByStateItem = wself.findTeamInfoByStateItem_array[path.row];
//        openGroupViewController.locationWithUser = self.currentCity;
        [wself.navigationController pushViewController:openGroupViewController animated:YES];
    };
    cell.pleasePerfectDataBlock = ^(UIButton *button) {
        UITableViewCell *cell = (UITableViewCell *)[button superview];
        NSIndexPath *path = [self.allTaskTableView indexPathForCell:cell];
        //这里可以获取到cell是具体是哪一个,就可以传相应的id
        NSLog(@"-----------------index row%zd", [path row]);
        XFJTeamMessageViewController *teamMessageController = [[XFJTeamMessageViewController alloc] init];
        teamMessageController.findTeamInfoByState_Id = wself.findTeamInfoByStateItem_array[path.row].findTeamInfoByState_Id;
        [wself.navigationController pushViewController:teamMessageController animated:YES];
    };
    cell.cancelTeamBlock= ^(UIButton *button) {
        UITableViewCell *cell = (UITableViewCell *)[button superview];
        NSIndexPath *path = [self.allTaskTableView indexPathForCell:cell];
        //这里可以获取到cell是具体是哪一个,就可以传相应的id
        NSLog(@"---------=========--------index row%zd", [path row]);
        //弹出提示框
        UIAlertController *alertVc =[UIAlertController alertControllerWithTitle:@"提示" message:@"是否取消任务?" preferredStyle:UIAlertControllerStyleAlert];
        [alertVc addAction:[UIAlertAction actionWithTitle:@"取消" style: UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
        }]];
        [alertVc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [wself requestCancelTeamTask:wself.findTeamInfoByStateItem_array[path.row].findTeamInfoByState_Id];
        }]];
        [wself presentViewController:alertVc animated:NO completion:nil];
    };
    cell.findTeamInfoByStateItem = self.findTeamInfoByStateItem_array[indexPath.row];
    return cell;
}

#pragma mark - cell的点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"------点击了第%zd个cell",indexPath.row);
    XFJMeDetailsViewController *meDetailsViewController = [[XFJMeDetailsViewController alloc] init];
    [self.navigationController pushViewController:meDetailsViewController animated:YES];
}

#pragma mark - cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [XFJAllTaskTableViewCell cellHeight];
}

#pragma mark - 调用取消团队的接口
- (void)requestCancelTeamTask:(NSInteger)findTeamInfoByState_Id
{
    __weak __typeof(self)wself = self;
    [GRNetRequestClass POST:DELETETEAMINFOURL params:@{@"id":[NSString stringWithFormat:@"%zd",findTeamInfoByState_Id]} success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject) {
            if ([[responseObject objectForKey:@"msg"] isEqualToString:@"success"]) {
                [wself requestAllStates];
                if (wself.requestTitleBolock) {
                    wself.requestTitleBolock();
                }
            }
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            [MBProgressHUD showHudTipStr:@"您取消团队失败了,可能是网络问题" contentColor:HidWithColorContentBlack];
        }
    }];
}

@end

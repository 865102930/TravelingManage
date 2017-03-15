//
//  XFJPleaseAppraiseViewController.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/6.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

//跳转到评价控制器

#import "XFJPleaseAppraiseViewController.h"
#import "XFJAssessmentTeamTopView.h"
#import "XFJOpinionAndSuggestView.h"
#import "XFJSignAppraiseTableViewCell.h"
#import "XFJCommitView.h"
#import "XFJFindTeamTasksItem.h"
#import "XFJTaskRowsItem.h"
#import "HomeViewController.h"
#import "JTNavigationController.h"

@interface XFJPleaseAppraiseViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UILabel *title_label;
@property (nonatomic, strong) UIScrollView *assessmentScroll_view;
@property (nonatomic, strong) XFJAssessmentTeamTopView *assessmentTeamTopView;
@property (nonatomic, strong) XFJOpinionAndSuggestView *opinionAndSuggestView;
@property (nonatomic, strong) XFJCommitView *commitView;
@property (nonatomic, strong) UITableView *signAppraise_tableView;
@property (nonatomic, strong) NSMutableArray <XFJFindTeamTasksItem *> *findTeamTasksItem;
@property (nonatomic, strong) NSMutableArray <XFJTaskRowsItem *> *TaskRowsItemArray;
//接收传递过来的分数值
@property (nonatomic, assign) NSInteger teamScore;
//接收传递过来的输入框参数值
@property (nonatomic, strong) NSString *commit_text;
//分数1
@property (nonatomic, assign) NSInteger teamScore1;
//分数2
@property (nonatomic, assign) NSInteger teamScore2;
//分数3
@property (nonatomic, assign) NSInteger teamScore3;
//景区id
@property (nonatomic, assign) NSInteger attractionsId;
@property (nonatomic, strong) NSMutableArray *totalStarArray;
@end

@implementation XFJPleaseAppraiseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //获取景区名字的接口调用
    [self requestWithTeamForNname];
    
    [self setInitWithNav];
    
}

- (void)requestWithTeamForNname
{
    NSDictionary *dictParams = @{
                                 @"id":[NSString stringWithFormat:@"%zd",self.teamId]
                                 };
    __weak __typeof(self)wself = self;
    [GRNetRequestClass POST:FINDTEAMINFOTASKSURL params:dictParams success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject) {
            NSMutableArray *findArray = [responseObject objectForKey:@"rows"];
            wself.findTeamTasksItem = [XFJFindTeamTasksItem mj_objectArrayWithKeyValuesArray:findArray];
            for (NSInteger i = 0;i < findArray.count ; i++) {
                NSDictionary *dict = [findArray[0] objectForKey:@"tasks"];
                wself.TaskRowsItemArray = [XFJTaskRowsItem mj_objectArrayWithKeyValuesArray:dict];
                NSLog(@"wself.TaskRowsItemArray-------%@",wself.TaskRowsItemArray);
            }
            [wself.signAppraise_tableView reloadData];
            NSLog(@"------------++++++++++++获取到的值是 :%@",wself.findTeamTasksItem);
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"---------+++++++++没得到后台返回的值,打印错误信息是 :%@",error);
        }
    }];
}

- (NSMutableArray <XFJFindTeamTasksItem *> *)findTeamTasksItem
{
    if (_findTeamTasksItem == nil) {
        _findTeamTasksItem = [NSMutableArray array];
    }
    return _findTeamTasksItem;
}

- (NSMutableArray *)totalStarArray
{
    if (_totalStarArray == nil) {
        _totalStarArray = [NSMutableArray array];
    }
    return _totalStarArray;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.assessmentScroll_view addSubview:self.commitView];
    [self.commitView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.signAppraise_tableView.mas_bottom);
        make.height.mas_equalTo(100.0);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
    }];
}

- (void)setInitWithNav
{
    self.navigationItem.titleView = self.title_label;
    [self.view addSubview:self.assessmentScroll_view];
    [self.assessmentScroll_view addSubview:self.assessmentTeamTopView];
    [self.assessmentScroll_view addSubview:self.opinionAndSuggestView];
    [self.assessmentScroll_view addSubview:self.signAppraise_tableView];
    __weak __typeof(self)wself = self;
    self.commitView.teamEvaluateBlock = ^() {
        [wself commitEvaluate_buttonClick];
    };
    self.assessmentTeamTopView.commitStarBlock = ^(NSString *startScore){
        NSLog(@" -------+++++++++=获取到的团队评分是:%zd",[startScore intValue]);
        wself.teamScore = [startScore intValue];
    };
    self.opinionAndSuggestView.textViewTextBlock = ^(NSString *textView_text) {
        NSLog(@"+++++++++++++++++获取到的结束编辑的内容是 :%@",textView_text);
        wself.commit_text = textView_text;
    };
}
#pragma mark - 提交评论
- (void)commitEvaluate_buttonClick
{
    //转成json格式给服务器发送
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.totalStarArray options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary *dictParams = @{
                                 @"teamId":[NSString stringWithFormat:@"%zd",self.teamId],
                                 @"teamScore":[NSString stringWithFormat:@"%zd",self.teamScore],//团队评分
                                 @"teamComment":[NSString stringWithFormat:@"%@",self.commit_text],//团队评论
                                 @"attrJson":jsonString//设施设备
                                 };
        NSLog(@"+++++++++打印的提交评论时候的参数值是 :%@",dictParams);
    __weak __typeof(self)wself = self;
    [GRNetRequestClass POST:EVALUATEURL params:dictParams success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject) {
            NSLog(@"--------评价成功返回的结果是 :%@",responseObject);
            [MBProgressHUD showHudTipStr:@"亲~~评论成功哦!" contentColor:HidWithColorContentBlack];
            HomeViewController *home = [[HomeViewController alloc] init];
            JTNavigationController *navVC = [[JTNavigationController alloc] initWithRootViewController:home];
            [wself presentViewController:navVC animated:YES completion:nil];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"+++++++++返回失败的结果是 :%@",error);
            [MBProgressHUD showHudTipStr:@"亲~~评论失败,可能是网络问题!!" contentColor:HidWithColorContentBlack];
        }
    }];
}

- (UILabel *)title_label
{
    if (_title_label == nil) {
        _title_label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.XFJ_centerX, 6, 100, 44)];
        _title_label.text = @"对此次带团的评价";
        _title_label.textColor = kColor6565;
        _title_label.textAlignment = NSTextAlignmentCenter;
    }
    return _title_label;
}

- (UIScrollView *)assessmentScroll_view
{
    if (_assessmentScroll_view == nil) {
        _assessmentScroll_view = [[UIScrollView alloc] init];
        _assessmentScroll_view.frame = CGRectMake(0, 0, self.view.bounds.size.width, 1.2 * self.view.XFJ_Height);
        _assessmentScroll_view.contentSize = CGSizeMake(0, self.view.XFJ_Height * 1.5);
        _assessmentScroll_view.backgroundColor = kColoreeee;
        _assessmentScroll_view.showsHorizontalScrollIndicator = NO;
        _assessmentScroll_view.scrollEnabled = YES;
    }
    return _assessmentScroll_view;
}

- (XFJAssessmentTeamTopView *)assessmentTeamTopView
{
    if (_assessmentTeamTopView == nil) {
        _assessmentTeamTopView = [[XFJAssessmentTeamTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45.0)];
        _assessmentTeamTopView.backgroundColor = [UIColor whiteColor];
    }
    return _assessmentTeamTopView;
}

- (XFJOpinionAndSuggestView *)opinionAndSuggestView
{
    if (_opinionAndSuggestView == nil) {
        _opinionAndSuggestView = [[XFJOpinionAndSuggestView alloc] initWithFrame:CGRectMake(0, 45.0, SCREEN_WIDTH, 180.0)];
        _opinionAndSuggestView.backgroundColor = [UIColor whiteColor];
    }
    return _opinionAndSuggestView;
}

- (UITableView *)signAppraise_tableView
{
    if (_signAppraise_tableView == nil) {
        _signAppraise_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 225.0, SCREEN_WIDTH, 0) style:UITableViewStylePlain];
        _signAppraise_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _signAppraise_tableView.delegate = self;
        _signAppraise_tableView.dataSource = self;
    }
    return _signAppraise_tableView;
}

- (XFJCommitView *)commitView
{
    if (_commitView == nil) {
        _commitView = [[XFJCommitView alloc] init];
        _commitView.backgroundColor = [UIColor whiteColor];
    }
    return _commitView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"---------------总共有多少条评价:%zd",[self.TaskRowsItemArray count]);
    return [self.TaskRowsItemArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const cellID = @"cellID";
    XFJSignAppraiseTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[XFJSignAppraiseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.teamScoreBlock1 = ^(NSString *scoreText1,NSInteger attractionsId1) {
        NSLog(@"获得到的scoreText1和attractionsId1是:%zd-----%zd",[scoreText1 intValue],attractionsId1);
        self.teamScore1 = [scoreText1 intValue];
        self.attractionsId = attractionsId1;
    };
    cell.teamScoreBlock2 = ^(NSString *scoreText2,NSInteger attractionsId2) {
        NSLog(@"获得到的scoreText2和attractionsId2是:%zd-----%zd",[scoreText2 intValue],attractionsId2);
        self.teamScore2 = [scoreText2 intValue];
        self.attractionsId = attractionsId2;
    };
    cell.teamScoreBlock3 = ^(NSString *scoreText3,NSInteger attractionsId3) {
        NSLog(@"获得到的scoreText3和attractionsId3是:%zd-----%zd",[scoreText3 intValue],attractionsId3);
        self.teamScore3 = [scoreText3 intValue];
        self.attractionsId = attractionsId3;
    };
    NSDictionary *dict = @{@"teamId":[NSString stringWithFormat:@"%zd",self.teamId],//团队id
                           @"attractionsId":[NSString stringWithFormat:@"%zd",self.attractionsId],//景区id
                           @"ssScore":[NSString stringWithFormat:@"%zd",self.teamScore1],//景区服务
                           @"ehScore":[NSString stringWithFormat:@"%zd",self.teamScore2],//环境卫生
                           @"feScore":[NSString stringWithFormat:@"%zd",self.teamScore3]
                           };
    [self.totalStarArray addObject:dict];
    cell.findTeamTasksItemArray = self.TaskRowsItemArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.signAppraise_tableView.frame = CGRectMake(0, 225.0, SCREEN_WIDTH, [self.TaskRowsItemArray count] * 180);
    return 180.0;
}






@end

//
//  HomeViewController.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/6.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "XFJMaskView.h"
#import "XFJLeftView.h"
#import "XFJAnnouncementView.h"
#import "MessageListViewController.h"
#import "XFJOpenGroupViewController.h"
#import "XFJMineTeamViewController.h"
#import "XFJTaskView.h"
#import <Masonry.h>
#import "XFJHomeTopTaskMessageVeiw.h"
#import "XFJTeamMessageViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "XFJFindAttractionsListItem.h"
#import "XFJSignView.h"
#import <IQKeyboardManager.h>
#import "XFJSceneryAnnotation.h"
#import "XFJSceneryAnnotationView.h"
#import <MapKit/MapKit.h>
#import "XFJSignNoPeopleView.h"
#import "XFJHotelView.h"
#import "XFJTeamSignListItem.h"
#import "XFJSignNoHotelView.h"
#import "XFJSingNoPeopleItem.h"
#import "CoverView.h"
#import "AlertView.h"
#import "AlertView1.h"
#import "XFJAllTaskViewController.h"
#import "JTNavigationController.h"
#import "XFJSignMessageViewController.h"
#import "XFJLaterTeamControlItem.h"
#import "PersonalDataViewController.h"

@interface HomeViewController ()<MAMapViewDelegate,XFJLeftViewDelegate,CLLocationManagerDelegate,XFJOpenGroupViewControllerDelegate,XFJSignViewDelegate,AlertViewDelegate,AlertView1Delegate>
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) UILabel *title_label;
@property (nonatomic, strong) UIBarButtonItem *user_SttingButtonItem;
@property (nonatomic, strong) UIBarButtonItem *projectButtonItem;
@property (nonatomic, strong) XFJMaskView *maskView1;
@property (nonatomic, assign) BOOL isOpenLeftView;
@property (nonatomic, strong) XFJLeftView *leftView;
@property (nonatomic, assign) CGFloat beginX;
@property (nonatomic, strong) XFJAnnouncementView *announcementView;
@property (nonatomic, strong) XFJTaskView *task_view;
@property (nonatomic, strong) XFJHomeTopTaskMessageVeiw *homeTopTaskMessageVeiw;
@property (nonatomic, strong) CLLocationManager *manager;
//当前的城市
@property (nonatomic, strong) NSString *currentCity;
//定位到当前的省
@property (nonatomic, strong) NSString *currentProvince;
@property (nonatomic, strong) NSMutableArray <XFJFindAttractionsListItem *> *findAttractionsListArray;
//定位按钮
@property (nonatomic, strong) UIButton *location_button;
@property (nonatomic, strong) XFJSignView *sign_view;
//创建的数组用来装景点的大头针
@property (nonatomic, strong) NSMutableArray *annotationArray;
@property (nonatomic, strong) MKPolyline *myPolyline;
@property (nonatomic, assign) CGFloat str1;
@property (nonatomic, assign) CGFloat str2;
@property (nonatomic, strong) NSString *latitude;
//经度
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) XFJSignNoPeopleView *signNoPeople_view;
@property (nonatomic, assign) NSInteger stateType;//景区类型
@property (nonatomic, assign) NSInteger attractions_id;//景区id;
//接收到的开团人数
@property (nonatomic, strong) NSString *teamNumber;
//接收传过来的teamId
@property (nonatomic, strong) NSString *teamId;
//修改的签到人数
@property (nonatomic, strong) NSString *signModifyCount;
//是否修改了
@property (nonatomic, assign) BOOL isSignModify;
@property (nonatomic, strong) XFJHotelView *hotel_view;
//签到的时候查询是否在指定的范围内
@property (nonatomic, assign) BOOL isContains;
@property (nonatomic, strong) NSMutableArray <XFJTeamSignListItem *> *teamSignListArray;
@property (nonatomic, assign) BOOL isTime;
@property (nonatomic, strong) XFJSignNoHotelView *signNoHotel_view;
@property (nonatomic, strong) NSString *nowDateTime;//这是时时获取的当前时间
@property (nonatomic, strong) NSString *DateStartTime;//这是点击签到的时候获取的时间;
@property (nonatomic, assign) BOOL isTaskTime;//判断是否点击了景区的按钮
@property (nonatomic, assign) BOOL isHotelSignTime;//判断是否点击了酒店的签到按钮
@property (nonatomic, strong) NSMutableArray <XFJSingNoPeopleItem *> *signNoPeople_array;
@property (nonatomic, strong) NSString *hotelSignPeople;//接收酒店的签到人数
@property (nonatomic, assign) BOOL isHotelSign;//接收用户是否修改了酒店人数的状态
@property (nonatomic, strong) NSString *signRoomCount;//用户修改的恩房间数量
@property (nonatomic, assign) NSInteger dayTime;//将在酒店待的时间传出来
@property (nonatomic, assign) BOOL isSignButtonClick;//是否点击了酒店签退的按钮

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.mapView];
    
    [self setUpNavigation];
}

- (void)setUpNavigation
{
    [self initWithTitle];
}

#pragma mark - 设置标题
- (void)initWithTitle
{
    self.navigationItem.titleView = self.title_label;
    self.navigationItem.leftBarButtonItem = self.user_SttingButtonItem;
    self.navigationItem.rightBarButtonItem = self.projectButtonItem;
    
    //这里调用最近操作的团队信息
    [self requestLatelyControl];
    
    //这是添加的公告(如果开始进来的时候没有任务,就显示公告,后面则显示新建任务的标题栏)
    self.isProjectItem == NO ? [self.view addSubview:self.announcementView] : [self.view addSubview:self.homeTopTaskMessageVeiw];
    
#warning 当用户一开始进入app的时候,由于不存在任务,那么就显示这个新建任务,如果有任务了,那么此界面就不存在

    [self.maskView1 addSubview:self.leftView];
    //获取当前用户的位置信息
    [self getUserLocation];
#warning 一开始是公告栏(此个页面是在后面添加的)
    //这是添加的home顶部的任务
//    [self.view addSubview:self.homeTopTaskMessageVeiw];
    
    [self setUpPanGes];
    
//    [self.view addSubview:self.location_button];
#warning 此处的试图需要判断是否是第一次进来的时候运用(或者任务已经做完了)
    [self.view addSubview:self.location_button];
    
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    keyboardManager.shouldResignOnTouchOutside = YES;
    keyboardManager.keyboardDistanceFromTextField = 50;
}

#pragma mark - 最近操作的团队
- (void)requestLatelyControl
{
    NSDictionary *dictParams = @{
                                 @"userId":@7//这个数据暂时写死
                                 };
    __weak __typeof(self)wself = self;
    [GRNetRequestClass POST:FINDNEWTEAMINFOURL params:dictParams success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject) {
            NSLog(@"+++++++++++获取到的最近的操作的团队是:%@",responseObject);
            [wself.view addSubview:wself.homeTopTaskMessageVeiw];
            NSDictionary *dict = [responseObject objectForKey:@"object"];
            XFJLaterTeamControlItem *laterTeamControlItem = [XFJLaterTeamControlItem mj_objectWithKeyValues:dict];
            wself.homeTopTaskMessageVeiw.laterTeamControlItem = laterTeamControlItem;
            //如果状态值显示的是0就显示签到按钮
            //如果状态值显示的是1就是签退按钮
            NSLog(@"========打印出来的最近团队的参数模型是:%@",laterTeamControlItem);
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"+++++++++++++获取不到的最近的操作的团队打印的错误信息是:%@",error);
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    __weak __typeof(self)wself = self;
    self.sign_view.signButtonClickBlock = ^() {
        //先判断是否在范围内(如果不在就直接返回,否则就直接进行下面的步骤)
        [wself signButtonClick1:wself.teamNumber teamId:wself.teamId];
        [wself.sign_view removeFromSuperview];
        [wself setUpSignNoWithPeople];
    };
}

#pragma mark - 给按钮添加一个滑动手势
- (void)setUpPanGes
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandle:)];
    [self.maskView1 addGestureRecognizer:pan];
    __weak __typeof(self)wself = self;
    self.announcementView.clickAnnouncementBlock = ^(){
        NSLog(@"点击了图片block~~");
        MessageListViewController *announcementController = [[MessageListViewController alloc] init];
        [wself.navigationController pushViewController:announcementController animated:YES];
    };
    self.leftView.pushMineTeamBlock = ^(NSInteger strNumber) {
        [wself remoSubViews];
        XFJMineTeamViewController *mineTeamController = [[XFJMineTeamViewController alloc] init];
        [wself.navigationController pushViewController:mineTeamController animated:YES];
    };
    self.homeTopTaskMessageVeiw.jumpWithTeamMessageBlock = ^() {
        //这是点击顶部右侧的箭头按钮跳转的控制器
//        XFJTeamMessageViewController *teamMessageViewController = [[XFJTeamMessageViewController alloc] init];
//        [wself.navigationController pushViewController:teamMessageViewController animated:YES];
        //跳转到签到点信息
        XFJSignMessageViewController *signMessageController = [[XFJSignMessageViewController alloc] init];
        [wself.navigationController pushViewController:signMessageController animated:YES];
    };
    //传递景点签到的内容
    self.sign_view.signModifyCount = ^(NSString *signNum, BOOL isSign) {
        wself.signModifyCount = signNum;
        wself.isSignModify = isSign;
    };
    //传递酒店的内容
    self.hotel_view.hotelPopelSignBlock = ^(NSString *signNumber, BOOL isSign) {
        wself.hotelSignPeople = signNumber;
        wself.isHotelSign =  isSign;
    };
    //将用户输入的房间数量传出来
    self.hotel_view.HotelSignRoomCountBlock = ^(NSString *hotelSignRoomCount) {
        wself.signRoomCount = hotelSignRoomCount;
    };
    self.task_view.openGroupBlock = ^(){
        [wself jumpNewProjectController];
    };
    //点击酒店签到按钮执行的是酒店签到任务
    self.hotel_view.hotelSignButtonClickBlock = ^() {
        [wself hotelSignButtonWithPeople];
    };
    //景区签退
    self.signNoPeople_view.signNoButtonClickBlock = ^() {
        [wself signNoPeopleButtonClick1];
    };
    //酒店签退
    self.signNoHotel_view.hotelSignNoButtonClickBlock = ^() {
        wself.isSignButtonClick = YES;
        [wself signNoPeopleButtonClick1];
    };
    //任务按钮的状态改变
    self.homeTopTaskMessageVeiw.ExitStatusButtonClickBlock = ^() {
        [wself statusHomeTopButtonClickRequest];
    };
}

#pragma mark - 改变按钮的状态
- (void)statusHomeTopButtonClickRequest
{
    //参数
    NSDictionary *dictParaments = @{
                                    @"id":[[NSUserDefaults standardUserDefaults] objectForKey:@"TEAMID"],
                                    @"teamState":@1
                                    };
    __weak __typeof(self)wself = self;
    [[NetWorkManager shareManager] requestWithType:HttpRequestTypeGet withUrlString:STATUSTEAMINFOURL withParaments:dictParaments withSuccessBlock:^(id object) {
        if (object) {
            NSLog(@"-------+++++++++点击完成后的后台返回的结果是:%@",object);
            //移除任务栏
            [wself.homeTopTaskMessageVeiw removeFromSuperview];
            [wself.view addSubview:self.announcementView];
            [MBProgressHUD showHudTipStr:@"主人~~该团队已经结束,进入待完善状态" contentColor:HidWithColorContentBlack];
        }
    } withFailureBlock:^(NSError *error) {
        if (error) {
            NSLog(@"=========+++++++=主人~~点击任务状态按钮的点击事件失败,可能是网络问题%@",error);
        }
    } progress:^(float progress) {
    }];
}


#pragma mark - 签退
- (void)signNoPeopleButtonClick1
{
    NSLog(@"-----------------++++++=是否在签退的范围内:%d",self.isContains);
    //签到的时候判断是否在景区内
    if (self.isContains) {//在景区范围内,可以签退
        //时间是达到规定的时间(YES)
        //遍历取出每个景点需要带的时间
        //时间没有达到规定的时间(NO)
        NSDictionary *dictParaments = @{
                                        @"teamId":[[NSUserDefaults standardUserDefaults] objectForKey:@"TEAMID"],
                                        @"taskState":[NSString stringWithFormat:@"%@",@"0"]
                                        };
        NSLog(@"签退需要传递的参数是:%@",dictParaments);
        __weak __typeof(self)wself = self;
        [[NetWorkManager shareManager] requestWithType:HttpRequestTypeGet withUrlString:TEAMSIGNLISTURL withParaments:dictParaments withSuccessBlock:^(id object) {
            if (object) {
                NSLog(@"签退成功获取到后台返回的内容是:%@",object);
                NSDictionary *dict = [object objectForKey:@"rows"];
                //判断是否可以签退(此处一定是可以签退的,只是显示的签退的状态是否异常?)
                wself.signNoPeople_array = [XFJSingNoPeopleItem mj_objectArrayWithKeyValuesArray:dict];
                CGFloat restult = 0.0;
                if (wself.isSignButtonClick) {//如果点击了酒店签退按钮
                    restult = wself.dayTime;
                }else {//没有点击酒店的签到按钮
                    restult = [wself.signNoPeople_view.hourTeamTime intValue] + (CGFloat)[wself.signNoPeople_view.minteTeamTime integerValue] / 60;
                }
                NSLog(@"-----计算的时间是------ : %.2f",restult);
                for (NSInteger i = 0; i < wself.signNoPeople_array.count; i++) {
                    NSString *signNoPeopleItem = wself.signNoPeople_array[i].attractionsTime;
                    NSLog(@"显示每个景点的必须的签退时间:%@",signNoPeopleItem);
                    if ((restult > [signNoPeopleItem floatValue]) || signNoPeopleItem.length == 0) {//如果时间大于景点的时间显示正确的签退框
                        NSLog(@"如果时间大于景点的时间显示正确的签退框");
                        [wself signNoPeopleVeiwButtonClick];
                        //只要有一个达到要求,就直接退出
                        return;
                    }else {
                        //这里表示时间小于景点签退的时间显示错误的签退框
                        NSLog(@"这里表示时间小于景点签退的时间显示错误的签退框");
                        [wself showErrorHidView];
                    }
                }
            }
        } withFailureBlock:^(NSError *error) {
            if (error) {
                NSLog(@"签退失败,获取后台给的团队列表信息失败:%@",error);
            }
        } progress:^(float progress) {
        }];
    }else {
        NSLog(@"主人~~此时的签退为异常签退,是否还要执行签退??");
    }
    //判断是否到达了景区规定的时间
    NSLog(@"主人~~您点击了签退按钮~~~~~~~~~~~~");
}
#warning 时间小于景点签退的时间显示错误的签退框(错误的提示框)
#pragma mark - showErrorHidView
- (void)showErrorHidView
{
    [CoverView show];
    //显示popView
    AlertView1 *popV =  [AlertView1 showInPoint:self.view.center];
    popV.delegate = self;
}

//点击弹框上面的确认按钮
- (void)presentViewClickBtn1:(AlertView1 *)alertView3
{
    //决定隐藏到哪个位置
    [alertView3 hiddenInPoint:CGPointMake(187.5, 210) completion:^{
        //移除遮盖
        for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
            //判断当前View是否是遮盖
            if([view isKindOfClass:[CoverView class]]) {
                [view removeFromSuperview];
            }
        }
    }];
    [self signOutButtonClick];
}

//点击弹框上面的取消按钮
- (void)popViewClickBtn1:(AlertView1 *)alertView3
{
    //决定隐藏到哪个位置
    [alertView3 hiddenInPoint:CGPointMake(187.5, 210) completion:^{
        //移除遮盖
        for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
            //判断当前View是否是遮盖
            if([view isKindOfClass:[CoverView class]]) {
                [view removeFromSuperview];
            }
        }
    }];
}


#warning 时间大于景点的时间显示正确的签退框(这是正确的提示框)
#pragma mark - 签退接口调用
- (void)signNoPeopleVeiwButtonClick
{
    [CoverView show];
    //显示popView
    AlertView *popV =  [AlertView showInPoint:self.view.center];
    popV.delegate = self;
}
//点击弹框上面的确认按钮
- (void)presentViewClickBtn:(AlertView *)alertView3
{
    //决定隐藏到哪个位置
    [alertView3 hiddenInPoint:CGPointMake(187.5, 210) completion:^{
        //移除遮盖
        for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
            //判断当前View是否是遮盖
            if([view isKindOfClass:[CoverView class]]) {
                [view removeFromSuperview];
            }
        }
    }];
    [self signOutButtonClick];
}

//点击弹框上面的取消按钮
- (void)popViewClickBtn:(AlertView *)alertView3
{
    //决定隐藏到哪个位置
    __weak __typeof(self)wself = self;
    [alertView3 hiddenInPoint:CGPointMake(187.5, 210) completion:^{
        //移除遮盖
        for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
            //判断当前View是否是遮盖
            if([view isKindOfClass:[CoverView class]]) {
                [view removeFromSuperview];
            }
        }
    }];
}

#pragma mark - 调用签退的接口(景点和酒店签退)
- (void)signOutButtonClick
{
    NSDictionary *dictParaments = @{
                                    @"teamId":[[NSUserDefaults standardUserDefaults] objectForKey:@"TEAMID"],
                                    @"attractionsId":[NSString stringWithFormat:@"%zd",self.attractions_id]
                                    };
    __weak __typeof(self)wself = self;
    [[NetWorkManager shareManager] requestWithType:HttpRequestTypeGet withUrlString:TEAMSIGNOUTURL withParaments:dictParaments withSuccessBlock:^(id object) {
        if ([[object objectForKey:@"success"] isEqual:@1]) {
            NSLog(@"主人,您签退成功~~~~打印后台返回的消息是:%@",object);
            //如果返回的是1,则成功,在这创建新建任务的view
            [wself.signNoHotel_view removeFromSuperview];
            [wself.signNoPeople_view removeFromSuperview];
            wself.location_button.frame = CGRectMake(11, SCREEN_HEIGHT - 200, 42, 41);
            [wself.view addSubview:self.task_view];
        }
    } withFailureBlock:^(NSError *error) {
        if (error) {
            NSLog(@"主人,您签退异常---打印后台返回的错误消息是 :%@",error);
            [MBProgressHUD showHudTipStr:@"签退失败,可能是网络问题" contentColor:HidWithColorContentBlack];
        }
    } progress:^(float progress) {
    }];
}


- (NSMutableArray <XFJSingNoPeopleItem *> *)signNoPeople_array
{
    if (_signNoPeople_array == nil) {
        _signNoPeople_array = [NSMutableArray array];
    }
    return _signNoPeople_array;
}

#pragma mark - 酒店签到任务
- (void)hotelSignButtonWithPeople
{
    [self.hotel_view removeFromSuperview];
    self.location_button.frame = CGRectMake(11, SCREEN_HEIGHT - 250, 42, 41);
    [self.view addSubview:self.signNoHotel_view];
    self.signNoHotel_view.hotelSignPeopleCount = self.isHotelSign ? self.hotelSignPeople : [[NSUserDefaults standardUserDefaults] objectForKey:@"TEAMPEOPLENUMBER"];
    self.signNoHotel_view.hotelSignRoomCount = self.signRoomCount;
    //在这里调用酒店签到的接口
    [self hotelSignRequest];
}

#pragma mark - 酒店签到接口
- (void)hotelSignRequest
{
    self.isHotelSignTime = YES;
    NSDictionary *dictParaments = @{
                                    @"teamId":[[NSUserDefaults standardUserDefaults] objectForKey:@"TEAMID"],//团队
                                    @"attractionsId":[NSString stringWithFormat:@"%zd",self.attractions_id],//景区id
                                    @"userIdList":@2,//管理员id(可能是多个)
                                    @"checkinNumber":self.isHotelSign ? self.hotelSignPeople : [[NSUserDefaults standardUserDefaults] objectForKey:@"TEAMPEOPLENUMBER"],//签到人数
                                    @"rooms":@0//房间数(可以不传)
                                    };
    NSLog(@"self.isHotelSign的值是:%zd-----self.hotelSignPeople的值是:%@------self.teamNumber的值是:%@",self.isHotelSign,self.hotelSignPeople,[[NSUserDefaults standardUserDefaults] objectForKey:@"TEAMPEOPLENUMBER"]);
    NSLog(@"团队%@-----景区%@-----管理员%@-----签到人数%@-----房间数%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"TEAMID"],[NSString stringWithFormat:@"%zd",self.attractions_id],@2,self.isHotelSign ? self.hotelSignPeople : [[NSUserDefaults standardUserDefaults] objectForKey:@"TEAMPEOPLENUMBER"],@0);
    __weak __typeof(self)wself = self;
    [[NetWorkManager shareManager] requestWithType:HttpRequestTypeGet withUrlString:TEAMSIGNURL withParaments:dictParaments withSuccessBlock:^(id object) {
        if (object) {
            NSLog(@"-----------打印出来的签到成功信息是:%@",object);
            [wself setUpUserTimeWithUseApp:NO];
            [MBProgressHUD showHudTipStr:@"亲~~您已经签到成功!" contentColor:HidWithColorContentBlack];
        }
    } withFailureBlock:^(NSError *error) {
        if (error) {
            NSLog(@"-----------签到失败的错误信息是:%@",error);
            [MBProgressHUD showHudTipStr:@"网络问题,签到失败" contentColor:HidWithColorContentBlack];
        }
    } progress:^(float progress) {
        
    }];
}

- (XFJSignNoHotelView *)signNoHotel_view
{
    if (_signNoHotel_view == nil) {
        _signNoHotel_view = [[XFJSignNoHotelView alloc] initWithFrame:CGRectMake(6, SCREEN_HEIGHT - 200, SCREEN_WIDTH - 12, 125)];
        _signNoHotel_view.backgroundColor = [UIColor whiteColor];
    }
    return _signNoHotel_view;
}

#pragma mark - 签到按钮的代理方法
- (void)signButtonClick
{
    [self.sign_view removeFromSuperview];
    [self setUpSignNoWithPeople];
}

- (void)signButtonClick1:(NSString *)teamNumber teamId:(NSString *)teamId
{
        self.isTaskTime = YES;
        NSDictionary *dictParaments = @{
                                        @"teamId":[[NSUserDefaults standardUserDefaults] objectForKey:@"TEAMID"],//团队
                                        @"attractionsId":[NSString stringWithFormat:@"%zd",self.attractions_id],//景区id
                                        @"userIdList":@2,//管理员id(可能是多个)
                                        @"checkinNumber":self.isSignModify ? self.signModifyCount : [[NSUserDefaults standardUserDefaults] objectForKey:@"TEAMPEOPLENUMBER"],//签到人数
                                        @"rooms":@0//房间数
                                        };
    //    NSLog(@"接入的签到参数是:%@",dictParaments);
    NSLog(@"self.isSignModify的值是:%zd-----self.signModifyCount的值是:%@------self.teamNumber的值是:%@",self.isSignModify,self.signModifyCount,[[NSUserDefaults standardUserDefaults] objectForKey:@"TEAMPEOPLENUMBER"]);
    NSLog(@"团队%@-----景区%@-----管理员%@-----签到人数%@-----房间数%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"TEAMID"],[NSString stringWithFormat:@"%zd",self.attractions_id],@2,self.isSignModify ? self.signModifyCount : [[NSUserDefaults standardUserDefaults] objectForKey:@"TEAMPEOPLENUMBER"],@0);
        __weak __typeof(self)wself = self;
        [[NetWorkManager shareManager] requestWithType:HttpRequestTypeGet withUrlString:TEAMSIGNURL withParaments:dictParaments withSuccessBlock:^(id object) {
            if (object) {
                NSLog(@"-----------打印出来的签到成功信息是:%@",object);
                [wself requestTeamSignList];
                //这里调用获取创建任务的当前时间
                [wself setUpUserTimeWithUseApp:NO];
                [MBProgressHUD showHudTipStr:@"亲~您已经签到成功!" contentColor:HidWithColorContentBlack];
            }
        } withFailureBlock:^(NSError *error) {
            if (error) {
                NSLog(@"-----------签到失败的错误信息是:%@",error);
                [MBProgressHUD showHudTipStr:@"网络问题,签到失败" contentColor:HidWithColorContentBlack];
            }
        } progress:^(float progress) {
            
        }];
}

#pragma mark - 获取团队任务列表
- (void)requestTeamSignList
{
    NSDictionary *dictParaments = @{
                                    @"teamId":[[NSUserDefaults standardUserDefaults] objectForKey:@"TEAMID"],
                                    @"taskState":@0
                                    };
    __weak __typeof(self)wself = self;
    [[NetWorkManager shareManager] requestWithType:HttpRequestTypeGet withUrlString:TEAMSIGNLISTURL withParaments:dictParaments withSuccessBlock:^(id object) {
        if (object) {
            NSDictionary *dictObject = [object objectForKey:@"rows"];
            wself.teamSignListArray = [XFJTeamSignListItem mj_objectArrayWithKeyValuesArray:dictObject];
            NSLog(@"++++++++++++获取到的团队任务列表是:%@",object);
            wself.signNoPeople_view.signNoPeopleArray = wself.teamSignListArray;
        }
    } withFailureBlock:^(NSError *error) {
        if (error) {
            NSLog(@"获取到的团队任务列表失败的是:%@",error);
        }
    } progress:^(float progress) {
    }];
}


- (XFJSignNoPeopleView *)signNoPeople_view
{
    if (_signNoPeople_view == nil) {
        _signNoPeople_view = [[XFJSignNoPeopleView alloc] initWithFrame:CGRectMake(6, SCREEN_HEIGHT - 150, SCREEN_WIDTH - 12, 78.0)];
    }
    return _signNoPeople_view;
}

- (NSMutableArray <XFJTeamSignListItem *> *)teamSignListArray
{
    if (_teamSignListArray == nil) {
        _teamSignListArray = [NSMutableArray array];
    }
    return _teamSignListArray;
}


#pragma mark - 添加签退页面
- (void)setUpSignNoWithPeople
{
    [self.view addSubview:self.signNoPeople_view];
}

- (void)panHandle:(UIPanGestureRecognizer *)panGesture
{
    NSLog(@"主人在按钮上滑动~~");
    CGPoint touchPoint = [panGesture locationInView:self.view];
    //大于0为向右滑动，小于0位向左滑动
    CGFloat translationX = [panGesture translationInView:self.view].x;
    if (panGesture.state == UIGestureRecognizerStateBegan){
        self.beginX = touchPoint.x;
        if (self.leftView.center.x > 0) {
            self.isOpenLeftView = YES;
        }else{
            self.isOpenLeftView = NO;
        }
    } else if(panGesture.state == UIGestureRecognizerStateChanged){
        if (translationX > 0 && self.leftView.center.x < self.leftView.bounds.size.width * 0.5 && !self.isOpenLeftView) {
            if (translationX < self.leftView.bounds.size.width){
                float loat = translationX / self.leftView.bounds.size.width;
                [self.leftView setCenter:CGPointMake(-self.leftView.bounds.size.width * 0.5 + self.leftView.bounds.size.width * loat, SCREEN_HEIGHT * 0.5)];
            }
        }else if (translationX < 0 && self.leftView.center.x > -self.leftView.bounds.size.width * 0.5 && self.isOpenLeftView){
            float loat = translationX / self.leftView.bounds.size.width;
            [self.leftView setCenter:CGPointMake(self.leftView.bounds.size.width * 0.5 + self.leftView.bounds.size.width *loat, SCREEN_HEIGHT * 0.5)];
        }
    }else if(panGesture.state == UIGestureRecognizerStateFailed || panGesture.state == UIGestureRecognizerStateEnded){
        if(translationX < 0){
            [self openLeftView:NO];
        }else{
            [self openLeftView:YES];
        }
    }
}


- (UIBarButtonItem *)user_SttingButtonItem
{
    if (_user_SttingButtonItem == nil) {
        _user_SttingButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"yonghu"] hightImage:nil target:self action:@selector(jumpToUserController)];
    }
    return _user_SttingButtonItem;
}

- (NSMutableArray *)annotationArray
{
    if (_annotationArray == nil) {
        _annotationArray = [NSMutableArray array];
    }
    return _annotationArray;
}

- (UIBarButtonItem *)projectButtonItem
{
    if (_projectButtonItem == nil) {
        _projectButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"xinjian"] hightImage:nil target:self action:@selector(jumpNewProjectController)];
    }
    return _projectButtonItem;
}

- (XFJMaskView *)maskView1
{
    if (_maskView1 == nil) {
        _maskView1 = [[XFJMaskView alloc] initWithFrame:CGRectZero];
    }
    return _maskView1;
}

- (XFJLeftView *)leftView
{
    if (_leftView == nil) {
        _leftView = [[XFJLeftView alloc] initWithFrame:CGRectMake(-SCREEN_WIDTH, 0, 202, self.view.XFJ_Height)];
        _leftView.delegate = self;
    }
    return _leftView;
}

- (void)pushPersonalDataController
{
    [self remoSubViews];
    PersonalDataViewController *person = [[PersonalDataViewController alloc] init];
    [self.navigationController pushViewController:person animated:YES];
}

- (void)remoSubViews
{
    [self openLeftView:NO];
    [self.maskView1 removeFromSuperview];
}

- (XFJAnnouncementView *)announcementView
{
    if (_announcementView == nil) {
        _announcementView = [[XFJAnnouncementView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 53)];
    }
    return _announcementView;
}

- (NSMutableArray <XFJFindAttractionsListItem *> *)findAttractionsListArray
{
    if (_findAttractionsListArray == nil) {
        _findAttractionsListArray = [NSMutableArray array];
    }
    return _findAttractionsListArray;
}

#pragma mark - 定位的按钮
- (UIButton *)location_button
{
    if (_location_button == nil) {
        _location_button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_location_button setFrame:CGRectMake(11, SCREEN_HEIGHT - 200, 42, 41)];
        [_location_button setBackgroundImage:[UIImage imageNamed:@"wodeweizhi"] forState:UIControlStateNormal];
        [_location_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_location_button addTarget:self action:@selector(userButtonLocation) forControlEvents:UIControlEventTouchUpInside];
    }
    return _location_button;
}

#pragma mark - 酒店签到的view
- (XFJHotelView *)hotel_view
{
    if (_hotel_view == nil) {
        _hotel_view = [[XFJHotelView alloc] init];
        _hotel_view.backgroundColor = [UIColor whiteColor];
        _hotel_view.frame = CGRectMake(6, SCREEN_HEIGHT - 240, SCREEN_WIDTH - 12, 164);
    }
    return _hotel_view;
}

#pragma mark - 更新定位
- (void)userButtonLocation
{
    self.mapView.centerCoordinate = self.mapView.userLocation.location.coordinate;
}

#warning 当用户一开始进入app的时候,由于不存在任务,那么就显示这个新建任务,如果有任务了,那么此界面就不存在
- (XFJTaskView *)task_view
{
    if (_task_view == nil) {
        _task_view = [[XFJTaskView alloc] initWithFrame:CGRectMake(9, SCREEN_HEIGHT - 160, SCREEN_WIDTH - 15, 98.0)];
    }
    return _task_view;
}

- (XFJHomeTopTaskMessageVeiw *)homeTopTaskMessageVeiw
{
    if (_homeTopTaskMessageVeiw == nil) {
        _homeTopTaskMessageVeiw = [[XFJHomeTopTaskMessageVeiw alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 98.0)];
    }
    return _homeTopTaskMessageVeiw;
}

- (void)jumpToUserController
{
    NSLog(@"点击了用户按钮");
    __weak __typeof(self)wself = self;
    self.maskView1.maskBlock = ^(){
        NSLog(@"移除了遮盖");
        [wself openLeftView:NO];
    };
    if (self.isOpenLeftView) {
        [self openLeftView:NO];
    }else{
        [[UIApplication sharedApplication].keyWindow addSubview:self.maskView1];
        [self openLeftView:YES];
    }
}

#pragma mark - 点击蒙版对侧滑栏的响应事件
- (void)backLeftVeiw
{
    if (self.isOpenLeftView) {
        __weak __typeof(self)wself = self;
        float timefloat = self.leftView.center.x / (self.view.bounds.size.width * 0.5);
        [UIView animateWithDuration:0.5 * timefloat delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.4 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [wself openLeftView:NO];
        }completion:^(BOOL finished){
            [wself.maskView1 removeFromSuperview];
        }];
    }
}

- (void)touchViewWithWidth:(NSInteger)width
{
    if (width < self.leftView.bounds.size.width) {
        [self.leftView setCenter:CGPointMake(self.leftView.bounds.size.width * 0.5 - width, SCREEN_HEIGHT * 0.5)];
    }
}

#pragma mark - 显示或者隐藏侧滑栏
- (void)openLeftView:(BOOL)open
{
    if (!open) {
        __weak __typeof(self)wself = self;
        float timeFloat = (self.view.bounds.size.width * 0.5 + self.leftView.center.x) / self.view.bounds.size.width;
        [UIView animateWithDuration:0.3 * timeFloat animations:^{
            [wself.leftView setCenter:CGPointMake(-wself.leftView.bounds.size.width * 0.5, SCREEN_HEIGHT * 0.5)];
        } completion:^(BOOL finished) {
            [wself.maskView1 removeFromSuperview];
        }];
        self.isOpenLeftView = NO;
    }else{
        __weak __typeof(self)wself = self;
        float timefloat = (self.view.bounds.size.width * 0.5 - self.leftView.center.x) / self.view.bounds.size.width;
        [UIView animateWithDuration:0.3 * timefloat animations:^{
            [wself.leftView setCenter:CGPointMake(wself.leftView.bounds.size.width * 0.5, SCREEN_HEIGHT * 0.5)];
        }completion:^(BOOL finished){
        }];
        self.isOpenLeftView = YES;
    }
}

- (void)jumpNewProjectController
{
    NSLog(@"点击了新建按钮");
    XFJOpenGroupViewController *openGroupViewController = [[XFJOpenGroupViewController alloc] init];
    openGroupViewController.delegate = self;
    openGroupViewController.locationWithUser = self.currentCity;
    [self.navigationController pushViewController:openGroupViewController animated:YES];
    __weak __typeof(self)wself = self;
    openGroupViewController.signViewBlock = ^(NSString *strNum,NSString *teamId) {
        //在此处创建底部的签到页面
        [wself setUpTeamNum:strNum teamId:teamId];
    };
}

#pragma mark - 定义一个方法用来接收传递过来的参数
- (void)setUpTeamNum:(NSString *)teamNum1 teamId:(NSString *)teamId
{
    self.teamNumber = teamNum1;
    self.teamId = teamId;
    NSLog(@"在这里获取到的团队数量是 : %@--------团队id是 :%@",self.teamNumber,self.teamId);
}

#pragma makr - 实现开团页面的代理方法(用于传值)
- (void)teamPeopleNumber:(NSString *)peopleNumber teamId:(NSString *)teamId
{
    self.teamNumber = [NSString stringWithFormat:@"%@",peopleNumber];
    self.teamId = [NSString stringWithFormat:@"%@",teamId];
    NSLog(@"====++++++++++++接收到的开团的人数是:%@-------开团id是:%@",self.teamNumber,self.teamId);
    self.sign_view.peopleNumberStr = peopleNumber;
    
}

- (void)loadView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = scrollView;
}

- (XFJSignView *)sign_view
{
    if (_sign_view == nil) {
        _sign_view = [[XFJSignView alloc] initWithFrame:CGRectMake(6, SCREEN_HEIGHT - 150, SCREEN_WIDTH - 12, 78.0)];
        _sign_view.delegate = self;
    }
    return _sign_view;
}

- (UILabel *)title_label
{
    if (_title_label == nil) {
        _title_label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.XFJ_centerX, 6, 100, 44)];
        _title_label.text = @"执行任务";
        _title_label.textColor = kColor6565;
        _title_label.textAlignment = NSTextAlignmentCenter;
    }
    return _title_label;
}

#pragma mark - 懒加载地图
- (MAMapView *)mapView
{
    if (_mapView == nil) {
        _mapView = [[MAMapView alloc] init];
        _mapView.delegate = self;
        [_mapView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        //设置地图的可视范围
        [_mapView setZoomLevel:14 animated:YES];
        //设置地图是否支持旋转
        [_mapView setRotateCameraEnabled:NO];
        //是否显示用户位置
        _mapView.showsUserLocation = YES;
        //追踪用户模式(实时更新)
         _mapView.userTrackingMode = MAUserTrackingModeFollow;
    }
    return _mapView;
}

#pragma mark - 地图的代理方法
#pragma mark - 定位失败后调用此方法
- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    NSString *errorString;
    NSLog(@"Error: %@",[error localizedDescription]);
    switch([error code]) {
        case kCLErrorDenied:
            errorString = @"Access to Location Services denied by user";
        {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请在系统设置中打开定位服务" delegate:self cancelButtonTitle:@"忽略" otherButtonTitles:@"去设置", nil];
            [alertView setTag:100];
            [alertView show];
        }
            break;
        case kCLErrorLocationUnknown:
            errorString = @"Location data unavailable";
            [MBProgressHUD showHudTipStr:@"定位失败" contentColor:HidWithColorContentBlack];
            break;
        default:
            errorString = @"An unknown error has occurred";
            [MBProgressHUD showHudTipStr:@"定位失败" contentColor:HidWithColorContentBlack];
            break;
    }
}

- (void)getUserLocation
{
    self.manager = [[CLLocationManager alloc] init];
    //设置准确度的；
    self.manager.desiredAccuracy = kCLLocationAccuracyBest;
    //设置距离（距离单位是米）
    self.manager.distanceFilter = 10;
    //设置代理
    self.manager.delegate = self;
    //持续定位；
    [self.manager requestAlwaysAuthorization];
    //开始定位
    [self.manager startUpdatingLocation];
    [self.manager stopUpdatingLocation];
    // 判断的手机的定位功能是否开启
    // 开启定位:设置 > 隐私 > 位置 > 定位服务
    if ([CLLocationManager locationServicesEnabled]) {
        // 启动位置更新
        // 开启位置更新需要与服务器进行轮询所以会比较耗电，在不需要时用stopUpdatingLocation方法关闭;
        [self.manager startUpdatingLocation];
    }else {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"“请在设置 > 隐私 > 位置 > 定位服务”中打开定位服务" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:@"设置", nil];
        [alertView setTag:100];
        [alertView show];
    }
    //纬度
    NSString *latitude = [NSString stringWithFormat:@"%.6f",(float)self.manager.location.coordinate.latitude];
    self.latitude = latitude;
    //经度
    NSString *longitude = [NSString stringWithFormat:@"%.6f",(float)self.manager.location.coordinate.longitude];
    self.longitude = longitude;
    NSLog(@"获取到用户的纬度是 : %@---------精度是:%@",latitude,longitude);
    
}

#pragma mark - 获取到用户的精度和纬度转换为具体的位置信息
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    //停止更新定位
    [self.manager stopUpdatingLocation];
    //旧的值
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    __weak __typeof(self)wself = self;
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            wself.currentCity = placeMark.locality;
            wself.currentProvince = placeMark.administrativeArea;
            if (!wself.currentCity) {
                wself.currentCity = @"无法定位当前城市";
            }
        //发送获取当前位置用户周边的景区
            [wself requestAttractionsListWithProvince:self.currentProvince city:wself.currentCity];
        }else if (error == nil && placemarks.count == 0) {
            NSLog(@"No location and error return");
        }else if (error) {
            NSLog(@"location error :%@",error);
        }
    }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 100) {
        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

#pragma mark - 获取当前位置的景区信息
- (void)requestAttractionsListWithProvince:(NSString *)province city:(NSString *)city
{
    NSLog(@"--------定位的当前城市是:%@-------当前省份是:%@",self.currentCity,self.currentProvince);
    NSDictionary *dictParaments = @{
                                    @"province":self.currentProvince,
                                    @"city":self.currentCity
                                    };
    __weak __typeof(self)wself = self;
    [[NetWorkManager shareManager] requestWithType:HttpRequestTypePost withUrlString:FINDATTRACTIONSLISTURL withParaments:dictParaments withSuccessBlock:^(id object) {
        if (object) {
            NSMutableArray *findAttractionArray = [object objectForKey:@"rows"];
            wself.findAttractionsListArray = [XFJFindAttractionsListItem mj_objectArrayWithKeyValuesArray:findAttractionArray];
            NSLog(@"=======++++++++------------获取到的景点列表模型是:%@",object);
            
            //获取周围景点的数据,并用大头针显示出来
            [wself setSceneryInToMapView:wself.findAttractionsListArray];
        }
    } withFailureBlock:^(NSError *error) {
        if (error) {
            NSLog(@"_______------+++++++++++++网络错误,打印错误信息是:%@",error);
            [MBProgressHUD showHudTipStr:@"亲~~网络错误" contentColor:HidWithColorContentBlack];
        }
    } progress:^(float progress) {
    }];
}

#pragma mark - 获取用户周围景点的信息显示在地图上
- (void)setSceneryInToMapView:(NSMutableArray <XFJFindAttractionsListItem *> *)findAttractionsListArray
{
    //遍历所有的景点列表
    for (NSInteger i = 0; i < findAttractionsListArray.count; i++) {
        @autoreleasepool {
            //取出每个景点
            XFJFindAttractionsListItem *findAttractionsListItem = [findAttractionsListArray objectAtIndex:i];
            //定义一个字符串用来接收遍历的景点精度和纬度
            NSString *locationPoint = findAttractionsListItem.locationPoints;
            //获取每个景点的景点类型值
            NSInteger stateType = findAttractionsListItem.typeState;
            //这里获取到了每一个景点的id
            NSInteger attractions_id = findAttractionsListItem.findAttractions_id;
            self.stateType = stateType;
            self.attractions_id = attractions_id;
            NSLog(@"-----------每一个景区的id是:%zd",self.attractions_id);
            //先按分号截取并且装入数组中
            NSArray *strarray = [locationPoint componentsSeparatedByString:@";"];
            NSLog(@"按分号截取的字符串 组成数组是:%@",strarray);
             CLLocationCoordinate2D commonPolylineCoords[strarray.count + 1];//这是第一个折线对象i = 0;i = 1;i = 2
            //这是一个景点的所有坐标
            for (NSInteger i = 0; i < strarray.count; i++) {
                //取出每个景点的坐标
                XFJSceneryAnnotation *sceneryAnnotation = [[XFJSceneryAnnotation alloc] init];
                NSString *str = [strarray objectAtIndex:i];
                NSRange rang = [str rangeOfString:@","];
                NSString *str1 = [str substringToIndex:rang.location];
                NSString *str2 = [str substringFromIndex:rang.location + 1];
                if (i == 0) {
                    self.str1 = [str1 floatValue];
                    self.str2 = [str2 floatValue];
//                    NSLog(@"当为第0个元素的时候纬度是 : %f--------精度是 : %f",self.str2,self.str1);
                }
//                NSLog(@"-------------遍历获取出来景点的坐标信息是 : %@--------%@",str1,str2);
                CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([str2 floatValue], [str1 floatValue]);
//                NSLog(@"截取完毕后的字符串是 :%f--------%f------是第%ld个坐标",[str2 floatValue],[str1 floatValue],i);
                //纬度和精度的赋值
                sceneryAnnotation.coordinate = coordinate;
                sceneryAnnotation.attractionsName = findAttractionsListItem.attractionsName;
                //将景点的大头针数组添加到数组中
                [self.annotationArray addObject:sceneryAnnotation];
//                NSLog(@"添加的大头针数组总共有%zd个",self.annotationArray.count);
                [self.mapView addAnnotation:sceneryAnnotation];
                //获取到景点所有的精度和纬度
                //构造折线对象strarray.count有这么多折线对象(5)
                commonPolylineCoords[i].latitude = [str2 floatValue];//0;1;2折线的纬度
                commonPolylineCoords[i].longitude = [str1 floatValue];//0;1;2折线的精度
                NSLog(@"折线的纬度是:%f-----------折线的精度是:%f------第%zd个坐标",[str2 floatValue],[str1 floatValue],i);
            }
            //构造折线对象
            commonPolylineCoords[strarray.count + 1].latitude = self.str2;//0;1;2折线的纬度
            commonPolylineCoords[strarray.count + 1].longitude = self.str1;
            NSLog(@"这是将数组中第0个纬度%f-----------和精度提取出来了-------------%f",self.str2,self.str1);
            MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:strarray.count];
            [self.mapView addOverlay:commonPolyline];
            //判断是否在范围内
            [self setContains:commonPolylineCoords strarryCount:strarray.count];
            NSLog(@"一个景点的点数数量是:%zd--------",strarray.count);
        }
    }
    [self.mapView showAnnotations:self.annotationArray edgePadding:UIEdgeInsetsMake(80, 80, 80, 80) animated:YES];
    NSLog(@"------------添加的大头针数组是 : %@",self.annotationArray);
}

#pragma mark - 随时更新用户的位子
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    //在这里一直获取用户的时间使用app的时间
    [self setUpUserTimeWithUseApp:YES];
    if (self.isTaskTime) {
        NSDictionary *dict = [self timeStrChangeWithFormatterStr:self.DateStartTime];
        NSString *hourTime = [dict objectForKey:@"hourString"];
        self.signNoPeople_view.hourTeamTime = hourTime;
        NSString *minteTime = [dict objectForKey:@"minuteString"];
        self.signNoPeople_view.minteTeamTime = minteTime;
        NSLog(@"---------------时时获取的差值是 :%@",dict);
    }else {
        NSLog(@"亲~~在这里就不再调用时时获取时间了!!!");
    }
    if (self.isHotelSignTime) {
        NSDictionary *dict = [self timeStrChangeWithFormatterStr:self.DateStartTime];
        NSString *hotelDayTime = [dict objectForKey:@"dayString"];//天数
        NSString *hotelHourTime = [dict objectForKey:@"hourString"];//小时
        NSString *hotelMinteTime = [dict objectForKey:@"minuteString"];//分钟
        //分钟转化为小时
        CGFloat minteToHour = [hotelMinteTime integerValue] / (CGFloat)60;
        //将所有的小时相加得到所有的小时
        CGFloat allHourTime = [hotelHourTime integerValue] + minteToHour;
        //将所有的小时累加为天数
        NSInteger dayTime = [hotelDayTime integerValue] + allHourTime / 24;
        self.signNoHotel_view.hotelStayDay = dayTime;
        self.dayTime = dayTime;
    }
}

#pragma mark - 时时获取用户在景区呆的时间
- (NSDictionary *)timeStrChangeWithFormatterStr:(NSString *)severTimeStr
{
    NSString *dayString = @"0";
    NSString *hourString = @"0";
    NSString *minuteString = @"0";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSDate* date = [formatter dateFromString:severTimeStr];//------------将字符串@"2017-01-01 08:40:00"按formatter转成nsdate
    double severTime = [date timeIntervalSince1970];
    double localSeverTime = [[NSDate date] timeIntervalSince1970];
    double poorTime = localSeverTime - severTime;
    NSNumber *numStage =  [NSNumber numberWithDouble:poorTime];
    NSString *numStr = [NSString stringWithFormat:@"%0.0lf",[numStage doubleValue]];//将double类型数据取整
    NSInteger timeInt = [numStr integerValue];
    if (timeInt >= 86400)
    {
        dayString = [NSString stringWithFormat:@"%d", timeInt / 86400];
        timeInt -= [dayString integerValue] * 86400;
    }
    if (timeInt >= 3600 && timeInt < 86400) {
        hourString = [NSString stringWithFormat:@"%d", timeInt / 3600];
        timeInt -= [hourString integerValue] * 3600;
    }
    if (timeInt < 3600) {
        minuteString = [NSString stringWithFormat:@"%d", timeInt / 60];
    }
    return @{@"dayString":dayString,@"hourString":hourString,@"minuteString":minuteString};
}

#pragma mark - 获取当前的时间
- (void)setUpUserTimeWithUseApp:(BOOL)isTime
{
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    //如果是真
    if (isTime) {//就是当前是间
        NSString *nowDateTime = [formatter stringFromDate:date];
        self.nowDateTime = nowDateTime;
        NSLog(@"%@===当前的时间=========年-月-日  时：分：秒=====================",nowDateTime);
    }else {//开始任务的时间
        NSString *DateStartTime = [formatter stringFromDate:date];
        self.DateStartTime = DateStartTime;
        NSLog(@"%@===开始任务的时间=========年-月-日  时：分：秒=====================",DateStartTime);
    }
}

#pragma mark - 判断是否在折线范围内
- (void)setContains:(CLLocationCoordinate2D *)polygon strarryCount:(NSInteger)strarryCount
{
    //108.924069,34.175223 [self.latitude floatValue], [self.longitude floatValue]
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake([self.latitude floatValue], [self.longitude floatValue]);//30.276601, 119.996597这是海创科技中心的经度和纬度
    BOOL isContains = MAPolygonContainsCoordinate(location, polygon, strarryCount);
    NSLog(@"-----------经纬度是否在多边形内部1 : %d",isContains);//0:标识不在 1:标识在
    //根据判断是否在范围内的值来做事情
    if (isContains) {//该处为YES则表示在
        NSLog(@"-----------经纬度是否在多边形内部2 : %d",isContains);//0:标识不在 1:标识在
        self.isContains = isContains;
        //判断该范围的景点类型
        if (self.stateType == 1) {//1则表示酒店
            //该处加载的是有房间数量的签到页面(也就是酒店)
            NSLog(@"酒店的状态值是 :%zd",self.stateType);
            //此处添加酒店的签到view
            self.isProjectItem == NO ? (self.location_button.frame = CGRectMake(11, SCREEN_HEIGHT - 200, 42, 41)) : (self.location_button.frame = CGRectMake(11, SCREEN_HEIGHT - 290, 42, 41));
            self.isProjectItem == NO ? [self.view addSubview:self.task_view] : [self.view addSubview:self.hotel_view];
        }else {//0则表示是景区
            //该出加载的是没有房间数量的签到页面(也就是景区)
            NSLog(@"景区的状态值是:%zd------景区的id值是:%zd",self.stateType,self.attractions_id);
            self.isProjectItem == NO ? [self.view addSubview:self.task_view] : [self.view addSubview:self.sign_view];
        }
    }else {
        //不在该签到的范围内
        NSLog(@"不在景点范围内景点的状态值是:%zd",self.stateType);
        //提示还没到签到区域,让用户到签到区域进行签到
//        [MBProgressHUD showHudTipStr:@"亲~~您还没有到达签到区域,请考虑是否签到?" contentColor:HidWithColorContentBlack];
    }
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth    = 3.f;
        polylineRenderer.strokeColor  = [UIColor clearColor];
        polylineRenderer.lineJoinType = kMALineJoinMiter;
        return polylineRenderer;
    }
    return nil;
}


#pragma mark - 标注点的代理方法(大头针类型)
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[XFJSceneryAnnotation class]]) {
        //创建用户的自定义大头针
        static NSString *sceneryReuseIdentifier = @"loctionUserAnnotation";
        XFJSceneryAnnotationView *annotationView = (XFJSceneryAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:sceneryReuseIdentifier];
        XFJSceneryAnnotation *sceneryAnnotation = (XFJSceneryAnnotation *)annotation;
        if (annotationView == nil) {
            annotationView = [[XFJSceneryAnnotationView alloc] initWithAnnotation:sceneryAnnotation reuseIdentifier:sceneryReuseIdentifier];
        }
        annotationView.canShowCallout = YES;
        annotationView.draggable = YES;
        annotationView.enabled = YES;
        return annotationView;
    }else {
        //用户的大头针
        static NSString *trackingReuseIndetifier = @"loctionUserAnnotation_1";
        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:trackingReuseIndetifier];
        if (!annotationView) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:trackingReuseIndetifier];
        }
        annotationView.bounds = CGRectMake(0.f, 0.f, 40, 40);
        UIImageView * myLoctionView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 13, 31)];
        [myLoctionView setCenter:CGPointMake(20, 10)];
        [myLoctionView setImage:[UIImage imageNamed:@"dingwei"]];
        [myLoctionView setContentMode:UIViewContentModeScaleAspectFit];
        [annotationView addSubview:myLoctionView];
        return annotationView;
    }
    return nil;
}


@end

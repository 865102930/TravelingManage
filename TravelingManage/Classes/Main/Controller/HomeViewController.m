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
#import "XFJTeamMessageViewController.h"
#import "XFJTaskView.h"
#import <Masonry.h>
#import "XFJHomeTopTaskMessageVeiw.h"
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
#import "AlertView3.h"
#import "XFJAllTaskViewController.h"
#import "JTNavigationController.h"
#import "XFJSignMessageViewController.h"
#import "XFJLaterTeamControlItem.h"
#import "PersonalDataViewController.h"
#import "XFJSignTeamTwoView.h"
#import "XFJChooseScenerySignView.h"
#import "XFJPleaseDoITViewController.h"
#import "XFJPleaseAskingViewController.h"
#import "XFJFindTeamTaskItem.h"
#import "XFJFindTeamTasksItem.h"
#import "XFJTaskRowsItem.h"
#import "XFJFindAttracUserListItem.h"
#import "XFJFindAttracUserListView.h"
#import "XFJChooseHotelSignView.h"

@interface HomeViewController ()<MAMapViewDelegate,XFJLeftViewDelegate,CLLocationManagerDelegate,XFJOpenGroupViewControllerDelegate,XFJSignViewDelegate,AlertViewDelegate,AlertView1Delegate,AlertView3Delegate>
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
@property (nonatomic, assign) NSInteger iscount;
//用一个数组将景点为yes的景点保存起来
@property (nonatomic, strong) NSMutableArray *isYes_array;
//将为0的景区保存起来
@property (nonatomic, strong) NSMutableArray <XFJFindAttractionsListItem *> *scenery_array;
//将为1的酒店保存起来
@property (nonatomic, strong) NSMutableArray <XFJFindAttractionsListItem *> *hotel_array;
@property (nonatomic, strong) XFJSignTeamTwoView *signTeamTwoView;
@property (nonatomic, strong) XFJChooseScenerySignView *chooseScenerySignView;
@property (nonatomic, strong) XFJFindAttractionsListItem *FindAttractionsListItem;
//提供一个BOOL值
@property (nonatomic, assign) BOOL isTeamId;
@property (nonatomic, assign) BOOL isSecondTeamId;
@property (nonatomic, strong) XFJLeftFindTeamInfoItem *leftFindTeamInfoItem;
@property (nonatomic, strong) XFJFindTeamTaskItem *findTeamTaskItem;
@property (nonatomic, strong) NSMutableArray <XFJFindTeamTasksItem *> *findTeamTasksItem;
@property (nonatomic, strong) NSMutableArray <XFJTaskRowsItem *>*TaskRowsItemArray;
@property (nonatomic, strong) NSMutableArray <XFJFindAttracUserListItem *> *findAttracUserListItem_array;
@property (nonatomic, strong) XFJFindAttracUserListView *findAttracUserListView;
//提供一个数组用来装管理员id
@property (nonatomic, strong) NSMutableArray *userArray_id;
//提供一个字符串用来接收数组的转化
@property (nonatomic, strong) NSString *allUserStr;
//提供一个数组,将符合签退范围的加入到数组中
@property (nonatomic, strong) NSMutableArray *canSignOutArray_time;
//提供一个数组,将不符合范围的签到点添加到数组中
@property (nonatomic, strong) NSMutableArray *notCanSignOutArray_time;
//是酒店签到
@property (nonatomic, assign) BOOL isChooseSign;
@property (nonatomic, assign) BOOL isOnlyUserSign;
@property (nonatomic, assign) BOOL isFirestEnterSignTime;
@property (nonatomic, strong) XFJChooseHotelSignView *chooseHotelSignView;
@property (nonatomic, strong) NSThread *thread;
//定义一个可变数组用来接收景区个数
@property (nonatomic, strong) NSMutableArray *scArray;
//定义一个可变数组用来接收酒店个数
@property (nonatomic, strong) NSMutableArray *hotArray;
@property (nonatomic, strong) XFJLaterTeamControlItem *laterTeamControlItem;
@property (nonatomic, assign) BOOL isEnter;
@property (nonatomic, strong) NSMutableArray *allAnnotationArray;
@property (nonatomic, strong) XFJSceneryAnnotation *sceneryAnnotation;
@property (nonatomic, strong) XFJSceneryAnnotationView *annotationView;
@property (nonatomic, strong) CLGeocoder *geocoder;
@property (nonatomic, strong) CLPlacemark *firstPlacemark;

@end

static BOOL over = NO;
@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.mapView];
    
    [self setUpNavigation];
}
- (CLGeocoder *)geocoder
{
    if (_geocoder == nil) {
        _geocoder = [[CLGeocoder alloc] init];
    }
     return _geocoder;
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
    
    //这是添加的公告(如果开始进来的时候没有任务,就显示公告,后面则显示新建任务的标题栏)
    self.isProjectItem == NO ? [self.view addSubview:self.announcementView] : [self addHeaderView];
    
    self.isProjectItem == NO ? @"" : [self.view addSubview:self.signTeamTwoView];//[self.view addSubview:self.task_view]

#warning 当用户一开始进入app的时候,由于不存在任务,那么就显示这个新建任务,如果有任务了,那么此界面就不存在
    [self.maskView1 addSubview:self.leftView];
    //获取当前用户的位置信息
    [self getUserLocation];
    
    //这里调用最近操作的团队信息(用BOOL值来判断)
//    self.isFindTeamList == YES ? [self.view addSubview:self.announcementView] : [self requestLatelyControl];
#warning 一开始是公告栏(此个页面是在后面添加的)
    //这是添加的home顶部的任务
//    [self.view addSubview:self.homeTopTaskMessageVeiw];
    
    [self setUpPanGes];
    
//    [self.view addSubview:self.location_button];
#warning 此处的试图需要判断是否是第一次进来的时候运用(或者任务已经做完了)
    [self.view addSubview:self.location_button];
    
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    keyboardManager.shouldResignOnTouchOutside = YES;
    keyboardManager.keyboardDistanceFromTextField = 100;
    
    [self.thread start];
}

#pragma mark - 添加头部视图
- (void)addHeaderView
{
    [self.announcementView removeFromSuperview];
    [self.view addSubview:self.homeTopTaskMessageVeiw];
}

- (NSThread *)thread
{
    if (_thread == nil) {
        _thread = [[NSThread alloc]initWithTarget:self selector:@selector(threadFunc) object:nil];
    }
    return _thread;
}

- (NSMutableArray *)allAnnotationArray
{
    if (_allAnnotationArray == nil) {
        _allAnnotationArray = [NSMutableArray array];
    }
    return _allAnnotationArray;
}

- (void)threadFunc
{
    __weak __typeof(self)wself = self;
    while (YES) {
        [NSThread sleepForTimeInterval:1];
        if ([NSThread isMultiThreaded]) {
            if (self.isTaskTime == YES) {//开始景区签到的时候调用
                [self setUpUserTimeWithUseApp:YES];
                NSDictionary *dict = [self timeStrChangeWithFormatterStr:self.DateStartTime];
                NSString *hourTime = [dict objectForKey:@"hourString"];
                NSString *minteTime = [dict objectForKey:@"minuteString"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    wself.signNoPeople_view.minteTeamTime = 0;
                    wself.signNoPeople_view.hourTeamTime = 0;
                    wself.signNoPeople_view.minteTeamTime = minteTime;
                    wself.signNoPeople_view.hourTeamTime = hourTime;
                });
            }else if (self.isHotelSignTime == YES) {//开始酒店签到的时候调用
                [self setUpUserTimeWithUseApp:YES];
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
                dispatch_async(dispatch_get_main_queue(), ^{
                    wself.signNoHotel_view.hotelStayDay = 0;
                    wself.signNoHotel_view.hotelStayHour = 0;
                    wself.signNoHotel_view.hotelStayDay = dayTime;
                    wself.signNoHotel_view.hotelStayHour = (int)allHourTime;
                });
            }else if (self.isTeamId == YES) {//点击侧边栏的时候对时间的调用
                [self setUpUserTimeWithUseApp:YES];
                NSDictionary *dict = [self timeStrChangeWithFormatterStr:self.findTeamTaskItem.createtime];
                NSLog(@"签到时间是 :%@",self.findTeamTaskItem.createtime);
                NSString *hourTime = [dict objectForKey:@"hourString"];
                NSString *minteTime = [dict objectForKey:@"minuteString"];
                NSString *hotelDayTime = [dict objectForKey:@"dayString"];//天数
                //分钟转化为小时
                CGFloat minteToHour = [minteTime integerValue] / (CGFloat)60;
                //将所有的小时相加得到所有的小时
                CGFloat allHourTime = [hourTime integerValue] + minteToHour;
                //将所有的小时累加为天数
                NSInteger dayTime = [hotelDayTime integerValue] + allHourTime / 24;
                NSInteger dayTime1 = dayTime * 24;
                dispatch_async(dispatch_get_main_queue(), ^{
                    wself.signNoPeople_view.hourTeamTime = 0;
                    wself.signNoPeople_view.minteTeamTime = 0;
                    wself.signNoHotel_view.hotelStayDay = 0;
                    wself.signNoHotel_view.hotelStayHour = 0;
                    wself.signNoPeople_view.minteTeamTime = minteTime;
                    if (dayTime1 >= 24) {
                        wself.signNoPeople_view.hourTeamTime = [NSString stringWithFormat:@"%zd",dayTime1];
                    }else {
                        wself.signNoPeople_view.hourTeamTime = hourTime;
                    }
                    wself.signNoHotel_view.hotelStayDay = dayTime;
                    wself.signNoHotel_view.hotelStayHour = (int)allHourTime;
                });
            }else if (self.isFirestEnterSignTime == YES) {//app刚开始进入的时候调用
                [self setUpUserTimeWithUseApp:YES];
                NSDictionary *dict = [self timeStrChangeWithFormatterStr:self.laterTeamControlItem.createtime];
                NSString *hourTime = [dict objectForKey:@"hourString"];
                NSString *minteTime = [dict objectForKey:@"minuteString"];
                NSString *hotelDayTime = [dict objectForKey:@"dayString"];//天数
                //分钟转化为小时
                CGFloat minteToHour = [minteTime integerValue] / (CGFloat)60;
                //将所有的小时相加得到所有的小时
                CGFloat allHourTime = [hourTime integerValue] + minteToHour;
                //将所有的小时累加为天数
                NSInteger dayTime = [hotelDayTime integerValue] + allHourTime / 24;
                dispatch_async(dispatch_get_main_queue(), ^{
                    wself.signNoPeople_view.hourTeamTime = 0;
                    wself.signNoPeople_view.minteTeamTime = 0;
                    wself.signNoHotel_view.hotelStayDay = 0;
                    wself.signNoHotel_view.hotelStayHour = 0;
                    wself.signNoPeople_view.hourTeamTime = hourTime;
                    wself.signNoPeople_view.minteTeamTime = minteTime;
                    NSLog(@"------------入住酒店的时间是 :%zd",dayTime);
                    wself.signNoHotel_view.hotelStayDay = dayTime;
                    wself.signNoHotel_view.hotelStayHour = (int)allHourTime;
                });
            }
        }
        if (over) {
            break;
        }
    }
}

- (void)setLaterTeamControlItem:(XFJLaterTeamControlItem *)laterTeamControlItem
{
    _laterTeamControlItem = laterTeamControlItem;
    
}

- (NSMutableArray *)scArray
{
    if (_scArray == nil) {
        _scArray = [NSMutableArray array];
    }
    return _scArray;
}

- (NSMutableArray *)hotArray
{
    if (_hotArray == nil) {
        _hotArray = [NSMutableArray array];
    }
    return _hotArray;
}

- (NSMutableArray <XFJFindTeamTasksItem *> *)findTeamTasksItem
{
    if (_findTeamTasksItem == nil) {
        _findTeamTasksItem = [NSMutableArray array];
    }
    return _findTeamTasksItem;
}

- (NSMutableArray <XFJTaskRowsItem *> *)TaskRowsItemArray
{
    if (_TaskRowsItemArray == nil) {
        _TaskRowsItemArray = [NSMutableArray array];
    }
    return _TaskRowsItemArray;
}

- (NSMutableArray <XFJFindAttracUserListItem *> *)findAttracUserListItem_array
{
    if (_findAttracUserListItem_array == nil) {
        _findAttracUserListItem_array = [NSMutableArray array];
    }
    return _findAttracUserListItem_array;
}

- (NSMutableArray *)userArray_id
{
    if (_userArray_id == nil) {
        _userArray_id = [NSMutableArray array];
    }
    return _userArray_id;
}

- (NSMutableArray *)canSignOutArray_time
{
    if (_canSignOutArray_time == nil) {
        _canSignOutArray_time = [NSMutableArray array];
    }
    return _canSignOutArray_time;
}

- (NSMutableArray *)notCanSignOutArray_time
{
    if (_notCanSignOutArray_time == nil) {
        _notCanSignOutArray_time = [NSMutableArray array];
    }
    return _notCanSignOutArray_time;
}


- (XFJFindAttracUserListView *)findAttracUserListView
{
    if (_findAttracUserListView == nil) {
        _findAttracUserListView = [[XFJFindAttracUserListView alloc] initWithFrame:CGRectMake(50, 150, SCREEN_WIDTH - 2 * 50, SCREEN_HEIGHT - 2 * 150)];
        _findAttracUserListView.layer.cornerRadius = 8.0;
        _findAttracUserListView.layer.borderWidth = 0.5;
        _findAttracUserListView.layer.borderColor = [UIColor whiteColor].CGColor;
        _findAttracUserListView.backgroundColor = [UIColor whiteColor];
    }
    return _findAttracUserListView;
}
#pragma mark - 最近操作的团队
- (void)requestLatelyControl
{
    [self.announcementView removeFromSuperview];
    [MBProgressHUD showLoadHUD];
    NSDictionary *dictParams = @{
                                @"userId":[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"]                                };
    NSLog(@"------->>>>>>>>>>>获取最近团队的参数是 :%@",dictParams);
    __weak __typeof(self)wself = self;
    [GRNetRequestClass POST:FINDNEWTEAMINFOURL params:dictParams success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject) {
            NSLog(@"+++++++++++获取到的最近的操作的团队是:%@",responseObject);
            [MBProgressHUD hidenHud];
            [wself.view addSubview:wself.homeTopTaskMessageVeiw];
            NSDictionary *dict = [responseObject objectForKey:@"object"];
            XFJLaterTeamControlItem *laterTeamControlItem = [XFJLaterTeamControlItem mj_objectWithKeyValues:dict];
            if (laterTeamControlItem.teamNo == nil) {
                [wself.view addSubview:wself.task_view];
                [wself.view addSubview:wself.announcementView];
                [wself.homeTopTaskMessageVeiw removeFromSuperview];
                return ;
            }
            self.laterTeamControlItem = laterTeamControlItem;
            self.homeTopTaskMessageVeiw.laterTeamControlItem = laterTeamControlItem;
            [wself requestAttractionsListWithProvince:self.currentProvince city:wself.currentCity];
            wself.isEnter = YES;
            if (dict != nil) {
                if ([laterTeamControlItem.taskState isEqualToString:@"0"]) {//已经签到过了此时显示签退页面
                    wself.isFirestEnterSignTime = YES;
                    if (laterTeamControlItem.typeState == 0) {
                        [wself.view addSubview:wself.signNoPeople_view];
                        wself.signNoPeople_view.laterTeamControlItem = laterTeamControlItem;
                    }else {
                        [wself.view addSubview:wself.signNoHotel_view];
                        wself.signNoHotel_view.laterTeamControlItem = laterTeamControlItem;
                    }
                }else {
                    [wself requestInfoTasksWithFindNewTeamInfo_Id:laterTeamControlItem.findNewTeamInfo_Id];
                }
            }else {
                [wself requestInfoTasksWithFindNewTeamInfo_Id:laterTeamControlItem.findNewTeamInfo_Id];
            }
            
            NSLog(@"========打印出来的最近团队的参数模型是:%@",laterTeamControlItem);
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"+++++++++++++获取不到的最近的操作的团队打印的错误信息是:%@",error);
            [MBProgressHUD hidenHud];
        }
    }];
}

#pragma mark - 刚进来的时候判断下面的状态
- (void)requestInfoTasksWithFindNewTeamInfo_Id:(NSUInteger)findNewTeamInfo_Id
{
    NSDictionary *dictParaments = @{
                                    @"id":[NSString stringWithFormat:@"%zd",findNewTeamInfo_Id]
                                    };
    NSLog(@"++++++++++++调用29个接口,获取任务信息的参数是:%@",dictParaments);
    __weak __typeof(self)wself = self;
    [GRNetRequestClass POST:FINDTEAMINFOTASKSURL params:dictParaments success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject) {
            NSMutableArray *findArray = [responseObject objectForKey:@"rows"];
            wself.findTeamTasksItem = [XFJFindTeamTasksItem mj_objectArrayWithKeyValuesArray:findArray];
            for (NSInteger i = 0;i < findArray.count ; i++) {
                NSDictionary *dict = [findArray[0] objectForKey:@"tasks"];
                wself.TaskRowsItemArray = [XFJTaskRowsItem mj_objectArrayWithKeyValuesArray:dict];
                if (wself.TaskRowsItemArray.count == 0) {
                    [wself.view addSubview:wself.signTeamTwoView];
                    NSString *str1;
                    wself.homeTopTaskMessageVeiw.isButton1 = str1;
                    return ;
                }
                NSLog(@"wself.TaskRowsItemArray-------%@",wself.TaskRowsItemArray);
            }
            wself.chooseScenerySignView.taskRowsItemArray = wself.TaskRowsItemArray;
            wself.chooseHotelSignView.taskRowsItemArray = wself.TaskRowsItemArray;
            //遍历所有的任务,查看是否正在进行(签到过了或者签退过了)
            //对景点的id遍历并且存起来
            [wself.scArray removeAllObjects];
            [wself.hotArray removeAllObjects];
            for (NSInteger i = 0; i < wself.scenery_array.count; i++) {
                NSInteger findAttractions_id = wself.scenery_array[i].findAttractions_id;
                [wself.scArray addObject:[NSString stringWithFormat:@"%zd",findAttractions_id]];
            }
            for (NSInteger j = 0; j < wself.TaskRowsItemArray.count; j++) {
                NSInteger attractionsId = wself.TaskRowsItemArray[j].attractionsId;
                [wself.scArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    if ([obj isEqualToString:[NSString stringWithFormat:@"%zd",attractionsId]]) {
                        [wself.scArray removeObject:[NSString stringWithFormat:@"%zd",attractionsId]];
                    }
                }];
            }
            if (wself.scArray.count == 0) {
                [wself.view addSubview:wself.signTeamTwoView];
                NSString *str1;
                wself.homeTopTaskMessageVeiw.isButton = str1;
                //直接置灰
                wself.signTeamTwoView.scenery_array = wself.TaskRowsItemArray;
            }else {
                //是原来的样式
                [wself.view addSubview:wself.signTeamTwoView];
                NSString *str;
                wself.homeTopTaskMessageVeiw.isButton = str;
                wself.signTeamTwoView.scenery_array2 = wself.TaskRowsItemArray;
            }
            //对酒店中的景点遍历并且存起来
            for (NSInteger i = 0; i < wself.hotel_array.count; i++) {
                NSInteger findHotelAttractions_id = wself.hotel_array[i].findAttractions_id;
                [wself.hotArray addObject:[NSString stringWithFormat:@"%zd",findHotelAttractions_id]];
            }
            NSLog(@"wself.hotArray :%zd",wself.hotArray.count);
            for (NSInteger i = 0; i < wself.TaskRowsItemArray.count; i++) {
                NSInteger attractionsId = wself.TaskRowsItemArray[i].attractionsId;
                [wself.hotArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    if ([obj isEqualToString:[NSString stringWithFormat:@"%zd",attractionsId]]) {
                        [wself.hotArray removeObject:[NSString stringWithFormat:@"%zd",attractionsId]];
                    }
                }];
            }
            if (wself.hotArray.count == 0) {
                [wself.view addSubview:wself.signTeamTwoView];
                NSString *str2;
                wself.homeTopTaskMessageVeiw.isButton = str2;
                //直接置灰
                wself.signTeamTwoView.hotel_array = wself.TaskRowsItemArray;
            }else {
                //是原来的样式
                [wself.view addSubview:wself.signTeamTwoView];
                NSString *str;
                wself.homeTopTaskMessageVeiw.isButton = str;
                wself.signTeamTwoView.hotel_array2 = wself.TaskRowsItemArray;
            }
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}


#warning view将要现实的时候调用
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    __weak __typeof(self)wself = self;
    self.sign_view.signButtonClickBlock = ^() {
        if (wself.isContains) {//在景区范围内
            //先判断是否在范围内(如果不在就直接返回,否则就直接进行下面的步骤)
            [wself signButtonClick1:wself.teamNumber teamId:wself.teamId userId:wself.allUserStr];
        }else {//不在景区范围内
            [wself isTureScSign];
            return;
        }
    };
    
}

#pragma mark - 判断是否含有除数字以外的字符
- (BOOL) deptNumInputShouldNumber:(NSString *)str
{
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}

#pragma mark - 根据景点id获取管理员的信息
- (void)requestWithAttractions_id:(NSInteger)attractions_id
{
    NSInteger findTeamInfoByState_Id;
    if (self.isEnter == YES) {
        findTeamInfoByState_Id = self.laterTeamControlItem.findNewTeamInfo_Id;
    }else {
        findTeamInfoByState_Id = self.isTeamId == YES ?
        [[NSString stringWithFormat:@"%zd",self.leftFindTeamInfoItem.findTeamInfoItem_id] intValue] :
        [[[NSUserDefaults standardUserDefaults] objectForKey:@"TEAMID"] intValue];
    }
    NSDictionary *dictParams = @{
                                 @"attractionsId":[NSString stringWithFormat:@"%zd",attractions_id],
                                 @"teamId":[NSString stringWithFormat:@"%zd",findTeamInfoByState_Id]
                                 };
    NSLog(@"----------------获取管理员传递的参数是 :%@",dictParams);
    __weak __typeof(self)wself = self;
    [GRNetRequestClass POST:FINDATTRACUSERLISTURL params:dictParams success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject) {
            NSLog(@"++++++++++获取到的管理员的信息是 :%@",responseObject);
            wself.findAttracUserListItem_array = [XFJFindAttracUserListItem mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"rows"]];
            if (wself.findAttracUserListItem_array.count != 0) {
                //弹出选择管理员的视图框
                [wself.chooseScenerySignView removeFromSuperview];
                [[UIApplication sharedApplication].keyWindow addSubview:wself.maskView1];
                if (wself.findAttracUserListItem_array.count == 1) {//如果只有一个管理员(不需要让用户选择,直接传递默认值)
                    wself.allUserStr = wself.findAttracUserListItem_array[0].userId;
                    if (wself.isOnlyUserSign == YES) {//酒店
                        [wself.signTeamTwoView removeFromSuperview];
                        [wself.maskView1 removeFromSuperview];
                        [wself.view addSubview:wself.hotel_view];
                        wself.isOnlyUserSign = NO;
                        wself.isChooseSign = NO;
//                        wself.hotel_view.peopleNumberStr = [NSString stringWithFormat:@"%zd",wself.findTeamTasksItem[0].teamNum];
                    }else {//景区
                        [wself.signTeamTwoView removeFromSuperview];
                        [wself.maskView1 removeFromSuperview];
                        [wself.view addSubview:wself.sign_view];
//                        wself.sign_view.peopleNumberStr = [NSString stringWithFormat:@"%zd",wself.findTeamTasksItem[0].teamNum];
                    }
                }else {//如果存在多个管理员(需要让用户选择)
                    [wself.maskView1 addSubview:wself.findAttracUserListView];
                    wself.findAttracUserListView.findAttracUserListItem = wself.findAttracUserListItem_array;
                }
            }else {//能来到这,就说明没有管理员
                [MBProgressHUD showHudTipStr:@"该景区不存在管理员!" contentColor:HidWithColorContentBlack];
                if (wself.isOnlyUserSign == YES) {//酒店
                    [wself.signTeamTwoView removeFromSuperview];
                    [wself.maskView1 removeFromSuperview];
                    [wself.view addSubview:wself.hotel_view];
                    wself.isOnlyUserSign = NO;
                }else {//景区
                    [wself.signTeamTwoView removeFromSuperview];
                    [wself.maskView1 removeFromSuperview];
                    [wself.view addSubview:wself.sign_view];
                }
            }
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"++++++++++获取不到管理员的信息是 :%@",error);
        }
    }];
}

- (NSMutableArray <XFJFindAttractionsListItem *> *)scenery_array
{
    if (_scenery_array == nil) {
        _scenery_array = [NSMutableArray array];
    }
    return _scenery_array;
}

- (NSMutableArray <XFJFindAttractionsListItem *> *)hotel_array
{
    if (_hotel_array == nil) {
        _hotel_array = [NSMutableArray array];
    }
    return _hotel_array;
}

- (XFJChooseScenerySignView *)chooseScenerySignView
{
    if (_chooseScenerySignView == nil) {
        _chooseScenerySignView = [[XFJChooseScenerySignView alloc] initWithFrame:CGRectMake(50, 150, SCREEN_WIDTH - 2 * 50, SCREEN_HEIGHT - 2 * 150)];
        _chooseScenerySignView.layer.cornerRadius = 8.0;
        _chooseScenerySignView.layer.borderWidth = 0.5;
        _chooseScenerySignView.layer.borderColor = [UIColor whiteColor].CGColor;
        _chooseScenerySignView.backgroundColor = [UIColor whiteColor];
    }
    return _chooseScenerySignView;
}

- (XFJChooseHotelSignView *)chooseHotelSignView
{
    if (_chooseHotelSignView == nil) {
        _chooseHotelSignView = [[XFJChooseHotelSignView alloc] initWithFrame:CGRectMake(50, 150, SCREEN_WIDTH - 2 * 50, SCREEN_HEIGHT - 2 * 150)];
        _chooseHotelSignView.layer.cornerRadius = 8.0;
        _chooseHotelSignView.layer.borderWidth = 0.5;
        _chooseHotelSignView.layer.borderColor = [UIColor whiteColor].CGColor;
        _chooseHotelSignView.backgroundColor = [UIColor whiteColor];
    }
    return _chooseHotelSignView;
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
        announcementController.strNum = 2;
        [wself.navigationController pushViewController:announcementController animated:YES];
    };
    //全部任务
    self.leftView.pushAllTeamTaskBlock = ^() {
        [wself remoSubViews];
        XFJMineTeamViewController *mineTeamController = [[XFJMineTeamViewController alloc] init];
        mineTeamController.currentCity = wself.currentCity;
        [wself.navigationController pushViewController:mineTeamController animated:YES];
    };
    //待完善
    self.leftView.pushMineTeamBlock = ^(NSInteger strNumber) {
        [wself remoSubViews];
        XFJMineTeamViewController *pleaseDoITViewController = [[XFJMineTeamViewController alloc] init];
        pleaseDoITViewController.strNumber = strNumber;
        [wself.navigationController pushViewController:pleaseDoITViewController animated:YES];
    };
    //待审核
    self.leftView.pushCheckTeamBlock = ^(NSInteger strNumber) {
        [wself remoSubViews];
        XFJMineTeamViewController *pleaseCheckTeamViewController = [[XFJMineTeamViewController alloc] init];
        pleaseCheckTeamViewController.strNumber = strNumber;
        [wself.navigationController pushViewController:pleaseCheckTeamViewController animated:YES];
    };
    //待评价
    self.leftView.pushPleaseAskingBlock = ^(NSInteger strNumber) {
        [wself remoSubViews];
        XFJMineTeamViewController *pleaseAskingViewController = [[XFJMineTeamViewController alloc] init];
        pleaseAskingViewController.strNumber = strNumber;
        [wself.navigationController pushViewController:pleaseAskingViewController animated:YES];
    };
    //将左侧的内容传到控制器中
    self.leftView.presentToHomeController = ^(XFJLeftFindTeamInfoItem *leftFindTeamInfoItem,BOOL isTeamId,BOOL isEnter) {
        [wself remoSubViews];
        [wself.sign_view removeFromSuperview];
        [wself.view addSubview:wself.homeTopTaskMessageVeiw];
        [wself.location_button setFrame:CGRectMake(SCREEN_WIDTH - SCREEN_WIDTH * 0.1 - 10, 170, 41, 41)];
        wself.homeTopTaskMessageVeiw.leftFindTeamInfoItem = leftFindTeamInfoItem;
        wself.leftFindTeamInfoItem = leftFindTeamInfoItem;
        wself.isTeamId = isTeamId;
        wself.isSecondTeamId = isTeamId;
        wself.isSecondProjectItem = NO;
        wself.isEnter = isEnter;
        wself.isTaskTime = NO;
        wself.isHotelSignTime = NO;
        wself.isProjectItem = NO;
        //请求获取左侧的接口
        [wself requestWithLeftIndexPathOfRows:leftFindTeamInfoItem];
        [wself.mapView removeAnnotations:wself.annotationArray];
        [wself requestAttractionsListWithProvince:wself.currentProvince city:wself.currentCity];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"INDEXPATHNOTICE" object:nil];
    };
    //退出登
    self.leftView.logoutUserBlock = ^() {
        //移除侧滑页面
        [wself remoSubViews];
        //清空userId
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults removeObjectForKey:@"userId"];
        [userDefaults synchronize];
        //跳转到登录页面
        LoginViewController *loginController = [[LoginViewController alloc] init];
        [wself presentViewController:loginController animated:YES completion:nil];
        [wself.manager stopUpdatingLocation];
    };
    self.homeTopTaskMessageVeiw.jumpWithTeamMessageBlock = ^(NSInteger findTeamInfoByState_Id) {
        //这是点击顶部右侧的箭头按钮跳转的控制器
        if (wself.isSecondProjectItem == YES) {//如果是YES就直接传入刚创建的团队id
            XFJTeamMessageViewController *teamMessageViewController = [[XFJTeamMessageViewController alloc] init];
            teamMessageViewController.findTeamInfoByState_Id = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TEAMID"] intValue];
            [wself.navigationController pushViewController:teamMessageViewController animated:YES];
//            wself.isSecondProjectItem = NO;
        }else if (wself.isSecondTeamId == YES){ //如果是侧滑栏传递过来的id
            XFJTeamMessageViewController *teamMessageViewController = [[XFJTeamMessageViewController alloc] init];
            teamMessageViewController.findTeamInfoByState_Id = wself.leftFindTeamInfoItem.findTeamInfoItem_id;
            [wself.navigationController pushViewController:teamMessageViewController animated:YES];
        }else {//否则就直接加载最近任务的id
            //跳转到签到点信息
            XFJTeamMessageViewController *teamMessageViewController = [[XFJTeamMessageViewController alloc] init];
            teamMessageViewController.findTeamInfoByState_Id = findTeamInfoByState_Id;
            [wself.navigationController pushViewController:teamMessageViewController animated:YES];
        }
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
        //这里先不要调用酒店签到的接口直接调用加载管理员的页面
        if (wself.isContains) {//如果YES就表示在范围内,可以签到
            //在这里调用酒店签到的接口
            [wself hotelSignButtonWithPeopleAllUserId:wself.allUserStr];
        }else {//表示不在范围内,是否任然签到?
            [wself isTrueHotelSign];
            return ;
        }
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
        //弹出提示框
        UIAlertController *alertVc =[UIAlertController alertControllerWithTitle:@"提示" message:@"该操作不可撤销,是否确认完成?" preferredStyle:UIAlertControllerStyleAlert];
        [alertVc addAction:[UIAlertAction actionWithTitle:@"取消" style: UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
        }]];
        [alertVc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [wself statusHomeTopButtonClickRequest];
        }]];
        [wself presentViewController:alertVc animated:NO completion:nil];
    };
    //点击景区的选择按钮
    self.signTeamTwoView.scenerySign_Block = ^() {
      //添加遮盖
        [[UIApplication sharedApplication].keyWindow addSubview:wself.maskView1];
        NSLog(@"<<<<<<<<--------------可签到的景区是 %@",wself.scenery_array);
        //添加选择景点框
        [wself.maskView1 addSubview:wself.chooseScenerySignView];
    };
    //点击了酒店的选择按钮
    self.signTeamTwoView.hotelSign_block = ^() {
        //添加遮盖
        [[UIApplication sharedApplication].keyWindow addSubview:wself.maskView1];
        NSLog(@"<<<<<<<<--------------可签到的酒店是 %@",wself.hotel_array);
        //添加选择景点框
        [wself.maskView1 addSubview:wself.chooseHotelSignView];
    };
    self.maskView1.maskBlock = ^() {
        [wself.maskView1 removeFromSuperview];
    };
#warning 点击了景区签到的确定按钮
    self.chooseScenerySignView.chooseBlockButtonWithSure = ^(XFJFindAttractionsListItem *FindAttractionsListItem) {
        NSLog(@"------------获取到的值是 :%@",FindAttractionsListItem);
        wself.FindAttractionsListItem = FindAttractionsListItem;
        //点击签到的时候请求这个获取管理员的接口
        [wself requestWithAttractions_id:FindAttractionsListItem.findAttractions_id];
    };
#warning 点击了酒店签到的确定按钮
    self.chooseHotelSignView.chooseBlockButtonWithSure = ^(XFJFindAttractionsListItem *findAttractionsListItem){
        //接收用户选择的酒店中景区的id
        wself.FindAttractionsListItem = findAttractionsListItem;
        wself.isChooseSign = YES;
        wself.isOnlyUserSign = YES;
        //这里先不要调用酒店签到的接口直接调用加载管理员的页面
        [wself requestWithAttractions_id:wself.FindAttractionsListItem.findAttractions_id];
    };
    //跳转到通知页面
    self.leftView.pushNoticeWithHeaderBlock = ^() {
        [wself remoSubViews];
        MessageListViewController *announcementController = [[MessageListViewController alloc] init];
        [wself.navigationController pushViewController:announcementController animated:YES];
    };
    //用来接收传过来的管理员id
    self.findAttracUserListView.sureUserButtonClickBlock = ^(NSMutableArray <XFJFindAttracUserListItem *> *indexPathArray_id) {
        if (wself.isChooseSign == YES) {
            NSLog(@"+++++++++++++这里点击的是酒店的管理员值");
            //移除之前的管理员id
            [wself.userArray_id removeAllObjects];
            //遍历所有的管理员,取出选择的管理员id
            for (NSInteger i = 0; i < indexPathArray_id.count; i++) {
                //将遍历出来的管理员id加入到数组中
                [wself.userArray_id addObject:indexPathArray_id[i].userId];
            }
            //将数组转化为字符串
            wself.allUserStr = [wself.userArray_id componentsJoinedByString:@","];
            [wself.signTeamTwoView removeFromSuperview];
            [wself.maskView1 removeFromSuperview];
            [wself.view addSubview:wself.hotel_view];
            wself.isChooseSign = NO;
        }else {
            //遍历所有的管理员,取出选择的管理员id
            //移除之前的管理员id
            [wself.userArray_id removeAllObjects];
            for (NSInteger i = 0; i < indexPathArray_id.count; i++) {
                //将遍历出来的管理员id加入到数组中
                [wself.userArray_id addObject:indexPathArray_id[i].userId];
            }
            //将数组转化为字符串
            wself.allUserStr = [wself.userArray_id componentsJoinedByString:@","];
            NSLog(@"+++++++++++++++接收到的管理员id数组是 :%@",wself.allUserStr);
            [wself.signTeamTwoView removeFromSuperview];
            [wself.maskView1 removeFromSuperview];
            [wself.view addSubview:wself.sign_view];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FRESHENOTIFICATION" object:nil];
    };
    self.chooseScenerySignView.chooseBlockButtonWithCancel= ^() {
        [wself.maskView1 removeFromSuperview];
    };
    self.findAttracUserListView.cancelUserButtonClickBlock = ^() {
        [wself.maskView1 removeFromSuperview];
    };
    self.chooseHotelSignView.chooseBlockButtonWithCancel = ^() {
        [wself.maskView1 removeFromSuperview];
    };
}

#pragma mark - 请求获取左侧栏的接口
- (void)requestWithLeftIndexPathOfRows:(XFJLeftFindTeamInfoItem *)leftFindTeamInfoItem
{
    self.leftFindTeamInfoItem = leftFindTeamInfoItem;
    __weak __typeof(self)wself = self;
    [GRNetRequestClass POST:FINDTEAMTASKURL params:@{@"teamId":[NSString stringWithFormat:@"%zd",leftFindTeamInfoItem.findTeamInfoItem_id]} success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject) {
            if ([[responseObject objectForKey:@"msg"] isEqualToString:@"success"]) {
                XFJFindTeamTaskItem *findTeamTaskItem = [XFJFindTeamTaskItem mj_objectWithKeyValues:[responseObject objectForKey:@"object"]];
                wself.findTeamTaskItem = findTeamTaskItem;
                //如果获取到的object值是nil下面就显示景点选择页面
                if ([[responseObject objectForKey:@"object"] isKindOfClass:[NSNull class]]) {
                    //来到这里需要判断是否有任务,
                    [wself reuqestButtonWithFindTeamInfoItem_id:leftFindTeamInfoItem.findTeamInfoItem_id];
                }else {//来到这说明签到了此时应该显示的是签退页面
                    if (findTeamTaskItem.typeState == 0) {//如果状态值是0表示景点,就显示景点的签退页面
                        //先移除创建任务界面
                        [wself.task_view removeFromSuperview];
                        //移除用户选择界面
                        [wself.signTeamTwoView removeFromSuperview];
                        //移除酒店签退页面
                        [wself.signNoHotel_view removeFromSuperview];
                        //移除景点签到页面
                        [wself.sign_view removeFromSuperview];
                        //添加景点签退页面
                        [wself.view addSubview:wself.signNoPeople_view];
                        wself.signNoPeople_view.findTeamTaskItem = findTeamTaskItem;
                    }else {//来到这表示是酒店就显示酒店的签退页面
                        //先移除创建任务界面
                        [wself.task_view removeFromSuperview];
                        //移除用户选择界面
                        [wself.signTeamTwoView removeFromSuperview];
                        //移除酒店签到页面
                        [wself.hotel_view removeFromSuperview];
                        //移除景区签退页面
                        [wself.signNoPeople_view removeFromSuperview];
                        //添加酒店签退页面
                        [wself.view addSubview:wself.signNoHotel_view];
                        wself.signNoHotel_view.findTeamTaskItem = findTeamTaskItem;
                    }
                }
            }
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"+++++++++请求到的错误信息是 :%@",error);
        }
    }];
}

#pragma mark - 调用判断按钮状态的接口
- (void)reuqestButtonWithFindTeamInfoItem_id:(NSUInteger)findTeamInfoItem_id
{
    [MBProgressHUD showLoadHUD];
    __weak __typeof(self)wself = self;
    [GRNetRequestClass POST:FINDTEAMINFOTASKSURL params:@{@"id":[NSString stringWithFormat:@"%zd",findTeamInfoItem_id]} success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject) {
            [MBProgressHUD hidenHud];
            NSLog(@"+++++++++++++获取到的团队信息查看任务是 :%@",responseObject);
            NSMutableArray *findArray = [responseObject objectForKey:@"rows"];
            wself.findTeamTasksItem = [XFJFindTeamTasksItem mj_objectArrayWithKeyValuesArray:findArray];
            for (NSInteger i = 0;i < findArray.count ; i++) {
                NSDictionary *dict = [findArray[0] objectForKey:@"tasks"];
                wself.TaskRowsItemArray = [XFJTaskRowsItem mj_objectArrayWithKeyValuesArray:dict];
                NSLog(@"wself.TaskRowsItemArray-------%@",wself.TaskRowsItemArray);
            }
            //如果没有任务,就代表用户连签到都没有签,此时显示让用户选择的签到任务点,并且完成按钮不可点击
            [wself.task_view removeFromSuperview];
            [wself.signNoPeople_view removeFromSuperview];
            [wself.hotel_view removeFromSuperview];
            //添加酒店签退页面
            [wself.signNoHotel_view removeFromSuperview];
            //然后添加让用户选择的签到页面
            [wself requestWithInfoTasks];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"--------------获取不到的团队信息查看任务是 :%@",error);
            [MBProgressHUD hidenHud];
        }
    }];
}


#pragma mark - 改变按钮的状态
- (void)statusHomeTopButtonClickRequest
{
    NSLog(@"------teamID:%zd",[NSString stringWithFormat:@"%zd",self.leftFindTeamInfoItem.findTeamInfoItem_id]);
    NSUInteger findTeamInfoByState_Id;
    NSLog(@"-----------wself.isEnter的值是 :%zd",self.isEnter);
    if (self.isEnter == YES) {
        findTeamInfoByState_Id = self.laterTeamControlItem.findNewTeamInfo_Id;
    }else {
        findTeamInfoByState_Id = self.isTeamId == YES ?
        [[NSString stringWithFormat:@"%zd",self.leftFindTeamInfoItem.findTeamInfoItem_id] intValue] :
        [[[NSUserDefaults standardUserDefaults] objectForKey:@"TEAMID"] intValue];
    }
    //参数
    NSDictionary *dictParaments = @{
                                    @"id":[NSString stringWithFormat:@"%zd",findTeamInfoByState_Id],
                                    @"teamState":@1
                                    };
    __weak __typeof(self)wself = self;
    [[NetWorkManager shareManager] requestWithType:HttpRequestTypeGet withUrlString:STATUSTEAMINFOURL withParaments:dictParaments withSuccessBlock:^(id object) {
        if (object) {
            NSLog(@"-------+++++++++点击完成后的后台返回的结果是:%@",object);
            //移除任务栏
            [wself.homeTopTaskMessageVeiw removeFromSuperview];
            [wself.location_button setFrame:CGRectMake(SCREEN_WIDTH - SCREEN_WIDTH * 0.1 - 10, 120, SCREEN_WIDTH * 0.1, SCREEN_WIDTH * 0.1)];
            [wself.view addSubview:wself.announcementView];
            [wself.signTeamTwoView removeFromSuperview];
            [wself.view addSubview:wself.task_view];
            NSUInteger findTeamInfoByState_Id;
            NSLog(@"-----------wself.isEnter的值是 :%zd",wself.isEnter);
            if (wself.isEnter == YES) {
                findTeamInfoByState_Id = wself.laterTeamControlItem.findNewTeamInfo_Id;
            }else {
                findTeamInfoByState_Id = self.isTeamId == YES ?
                [[NSString stringWithFormat:@"%zd",self.leftFindTeamInfoItem.findTeamInfoItem_id] intValue] :
                [[[NSUserDefaults standardUserDefaults] objectForKey:@"TEAMID"] intValue];
            }
            XFJTeamMessageViewController *teamMessageViewController = [[XFJTeamMessageViewController alloc] init];
            teamMessageViewController.findTeamInfoByState_Id = findTeamInfoByState_Id;
            [wself.navigationController pushViewController:teamMessageViewController animated:YES];
            //发送通知,刷新侧边栏
            [[NSNotificationCenter defaultCenter] postNotificationName:@"FRESHENLEFTREQUEST" object:nil];
        }
    } withFailureBlock:^(NSError *error) {
        if (error) {
            NSLog(@"=========+++++++=主人~~点击任务状态按钮的点击事件失败,可能是网络问题%@",error);
        }
    } progress:^(float progress) {
    }];
}

#pragma mark - 在view即将消失的时候调用销毁通知
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"FRESHENLEFTREQUEST" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"INDEXPATHNOTICE" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"FRESHENOTIFICATION" object:nil];
    self.isProjectItem = NO;
    self.isSecondProjectItem = NO;
    self.isFindTeamList = NO;
    self.isHotelSignTime = NO;
    self.isTaskTime = NO;
    self.isTeamId = NO;
    self.isFirestEnterSignTime = NO;
}

#pragma mark - 初始化签到view
- (XFJSignTeamTwoView *)signTeamTwoView
{
    if (_signTeamTwoView == nil) {
        _signTeamTwoView = [[XFJSignTeamTwoView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 76.0, SCREEN_WIDTH, 76.0)];
        _signTeamTwoView.backgroundColor = [UIColor whiteColor];
    }
    return _signTeamTwoView;
}


#pragma mark - 签退
- (void)signNoPeopleButtonClick1
{
    NSLog(@"-----------------++++++=是否在签退的范围内:%d",self.isContains);
    NSLog(@"-------侧滑页面中过来的teamId是:%zd",self.findTeamTaskItem.teamId);
    NSInteger findTeamInfoByState_Id;
    if (self.isEnter == YES) {
        findTeamInfoByState_Id = self.laterTeamControlItem.findNewTeamInfo_Id;
    }else {
        findTeamInfoByState_Id = self.isTeamId == YES ?
        [[NSString stringWithFormat:@"%zd",self.leftFindTeamInfoItem.findTeamInfoItem_id] intValue] :
        [[[NSUserDefaults standardUserDefaults] objectForKey:@"TEAMID"] intValue];
    }
    //签到的时候判断是否在景区内
    if (self.isContains) {//在景区范围内,可以签退
        //时间没有达到规定的时间(NO)
        NSDictionary *dictParaments = @{
                                        @"teamId":[NSString stringWithFormat:@"%zd",findTeamInfoByState_Id],
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
                CGFloat restult = 0.0f;
                if (wself.isSignButtonClick) {//酒店签退
                    [wself signNoPeopleVeiwButtonClick];
                    wself.isSignButtonClick = NO;
                }else{//景点签退
                    restult = [wself.signNoPeople_view.hourTeamTime intValue] + (CGFloat)[wself.signNoPeople_view.minteTeamTime integerValue] / 60;
                    NSLog(@"在这里打印的小时是 :%d--------分钟是 :%f",[wself.signNoPeople_view.hourTeamTime intValue],(CGFloat)[wself.signNoPeople_view.minteTeamTime integerValue] / 60);
                    for (NSInteger i = 0; i < wself.signNoPeople_array.count; i++) {
                        NSString *signNoPeopleItem = wself.signNoPeople_array[i].attractionsTime;
                        NSLog(@"显示每个景点的必须的签退时间:%@",signNoPeopleItem);
                        if ((restult > [signNoPeopleItem floatValue]) || signNoPeopleItem.length == 0) {//如果时间大于景点的时间或者为空的时候显示正确的签退框
                            NSLog(@"如果时间大于景点的时间显示正确的签退框");
                            //提供一个数组,将符合签退范围的加入到数组中
                            [wself.canSignOutArray_time addObject:wself.signNoPeople_array[i]];
                        }else {
                            //这里表示时间小于景点签退的时间显示错误的签退框
                            NSLog(@"这里表示时间小于景点签退的时间显示错误的签退框");
                            //提供一个数组,将不符合范围的签到点添加到数组中
                            [wself.notCanSignOutArray_time addObject:wself.signNoPeople_array[i]];
                        }
                    }
                    //在这里显示是否正常签退的提示框
                    if (wself.canSignOutArray_time.count != 0) {//这里是弹出正常的弹框
                        [wself signNoPeopleVeiwButtonClick];
                    }else if (wself.notCanSignOutArray_time.count != 0) {//这里是弹出的异常弹框
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
        //不在景区范围内是否签退
        [self isTrueSignOutButtonClick];
    }
}

#pragma mark - 不在范围内的签退
//- (void)isTrueSignOutButtonClick
//{
//    //弹出提示框
//    __weak __typeof(self)wself = self;
//    UIAlertController *alertVc =[UIAlertController alertControllerWithTitle:@"提示" message:@"您未在该景点签到区域内签退，是否签退?" preferredStyle:UIAlertControllerStyleAlert];
//    [alertVc addAction:[UIAlertAction actionWithTitle:@"取消" style: UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
//    }]];
//    [alertVc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [wself signOutButtonClick];
//    }]];
//    [wself presentViewController:alertVc animated:NO completion:nil];
//}

#warning 这里表示未在该景区内签到
- (void)isTrueSignOutButtonClick
{
    [CoverView show];
    //显示popView
    AlertView3 *popV =  [AlertView3 showInPoint:self.view.center];
    popV.delegate = self;
}

#pragma mark - 确定
- (void)presentViewClickBtn3:(AlertView3 *)alertView3
{
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
#pragma mark - 取消
- (void)popViewClickBtn3:(AlertView3 *)alertView3
{
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

- (NSMutableArray *)isYes_array
{
    if (_isYes_array == nil) {
        _isYes_array = [NSMutableArray array];
    }
    return _isYes_array;
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
    NSInteger findTeamInfoByState_Id;
    if (self.isEnter == YES) {
        findTeamInfoByState_Id = self.laterTeamControlItem.findNewTeamInfo_Id;
    }else {
        findTeamInfoByState_Id = self.isTeamId == YES ?
        [[NSString stringWithFormat:@"%zd",self.leftFindTeamInfoItem.findTeamInfoItem_id] intValue] :
        [[[NSUserDefaults standardUserDefaults] objectForKey:@"TEAMID"] intValue];
    }
    //取消 线程
    [self.thread cancel];
    NSDictionary *dictParaments = @{
                                    @"teamId":[NSString stringWithFormat:@"%zd",findTeamInfoByState_Id],
                                    @"attractionsId":[NSString stringWithFormat:@"%zd",self.attractions_id]
                                    };
    NSLog(@">>>>>>提交的参数是:%@",dictParaments);
    __weak __typeof(self)wself = self;
    [GRNetRequestClass POST:TEAMSIGNOUTURL params:dictParaments success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"msg"] isEqual:@"success"]) {
            //如果返回的是1,则成功,在这创建新建任务的view
            [wself.signTeamTwoView removeFromSuperview];
            [wself.signNoHotel_view removeFromSuperview];
            [wself.sign_view removeFromSuperview];
            [wself.signNoPeople_view removeFromSuperview];
            //这里先不要添加创建任务的弹窗(直接调用请求的任务的29个接口,判断任务是否存在)
            [wself requestWithInfoTasks];
            //只要签退成功,就按钮的状态改为完成
            NSString *str;
            wself.homeTopTaskMessageVeiw.isButton = str;
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"主人,您签退异常---打印后台返回的错误消息是 :%@",error);
            [MBProgressHUD showHudTipStr:@"签退失败,可能是网络问题" contentColor:HidWithColorContentBlack];
        }
    }];
}

#pragma mark - 调用29个接口,获取任务信息
- (void)requestWithInfoTasks
{
    NSInteger findTeamInfoByState_Id;
    if (self.isEnter == YES) {
        findTeamInfoByState_Id = self.laterTeamControlItem.findNewTeamInfo_Id;
    }else {
        findTeamInfoByState_Id = self.isTeamId == YES ?
        [[NSString stringWithFormat:@"%zd",self.leftFindTeamInfoItem.findTeamInfoItem_id] intValue] :
        [[[NSUserDefaults standardUserDefaults] objectForKey:@"TEAMID"] intValue];
    }
    NSDictionary *dictParaments = @{
                                    @"id":[NSString stringWithFormat:@"%zd",findTeamInfoByState_Id],
                                    };
    NSLog(@"<<<<<<<<<<<<参数是 :%@",dictParaments);
    __weak __typeof(self)wself = self;
    [GRNetRequestClass POST:FINDTEAMINFOTASKSURL params:dictParaments success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject) {
            NSMutableArray *findArray = [responseObject objectForKey:@"rows"];
            wself.findTeamTasksItem = [XFJFindTeamTasksItem mj_objectArrayWithKeyValuesArray:findArray];
            for (NSInteger i = 0;i < findArray.count ; i++) {
                NSDictionary *dict = [findArray[0] objectForKey:@"tasks"];
                wself.TaskRowsItemArray = [XFJTaskRowsItem mj_objectArrayWithKeyValuesArray:dict];
            }
            wself.chooseScenerySignView.taskRowsItemArray = wself.TaskRowsItemArray;
            wself.chooseHotelSignView.taskRowsItemArray = wself.TaskRowsItemArray;
            //遍历所有的任务,查看是否正在进行(签到过了或者签退过了)
            //对景点的id遍历并且存起来
            [wself.scArray removeAllObjects];
            [wself.hotArray removeAllObjects];
            for (NSInteger i = 0; i < wself.scenery_array.count; i++) {
                NSInteger findAttractions_id = wself.scenery_array[i].findAttractions_id;
                [wself.scArray addObject:[NSString stringWithFormat:@"%zd",findAttractions_id]];
            }
            //对酒店中的景点遍历并且存起来
            for (NSInteger i = 0; i < wself.hotel_array.count; i++) {
                NSInteger findHotelAttractions_id = wself.hotel_array[i].findAttractions_id;
                [wself.hotArray addObject:[NSString stringWithFormat:@"%zd",findHotelAttractions_id]];
            }
            for (NSInteger j = 0; j < wself.TaskRowsItemArray.count; j++) {
                NSInteger attractionsId = wself.TaskRowsItemArray[j].attractionsId;
                [wself.scArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    if ([obj isEqualToString:[NSString stringWithFormat:@"%zd",attractionsId]]) {
                        [wself.scArray removeObject:[NSString stringWithFormat:@"%zd",attractionsId]];
                    }
                }];
            }
            if (wself.scArray.count == 0) {
                [wself.view addSubview:wself.signTeamTwoView];
                if (wself.TaskRowsItemArray.count == 0) {
                    NSString *str;
                    wself.homeTopTaskMessageVeiw.isButton1 = str;
                }else {
                    NSString *str;
                    wself.homeTopTaskMessageVeiw.isButton = str;
                }
                //直接置灰
                wself.signTeamTwoView.scenery_array = wself.TaskRowsItemArray;
            }else {
                //是原来的样式
                [wself.view addSubview:wself.signTeamTwoView];
                wself.signTeamTwoView.scenery_array2 = wself.TaskRowsItemArray;
                    if (wself.TaskRowsItemArray.count == 0) {
                        NSString *str;
                        wself.homeTopTaskMessageVeiw.isButton1 = str;
                    }else {
                        NSString *str;
                        wself.homeTopTaskMessageVeiw.isButton = str;
                    }
            }
            for (NSInteger i = 0; i < wself.TaskRowsItemArray.count; i++) {
                NSInteger attractionsId = wself.TaskRowsItemArray[i].attractionsId;
                [wself.hotArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    if ([obj isEqualToString:[NSString stringWithFormat:@"%zd",attractionsId]]) {
                        [wself.hotArray removeObject:[NSString stringWithFormat:@"%zd",attractionsId]];
                    }
                }];
            }
            if (wself.hotArray.count == 0) {
                [wself.view addSubview:wself.signTeamTwoView];
                if (wself.TaskRowsItemArray.count == 0) {
                    NSString *str;
                    wself.homeTopTaskMessageVeiw.isButton1 = str;
                }else {
                    NSString *str;
                    wself.homeTopTaskMessageVeiw.isButton = str;
                }
                //直接置灰
                wself.signTeamTwoView.hotel_array = wself.TaskRowsItemArray;
            }else {
                //是原来的样式
                [wself.view addSubview:wself.signTeamTwoView];
                wself.signTeamTwoView.hotel_array2 = wself.TaskRowsItemArray;
                    if (wself.TaskRowsItemArray.count == 0) {
                        NSString *str;
                        wself.homeTopTaskMessageVeiw.isButton1 = str;
                    }else {
                        NSString *str;
                        wself.homeTopTaskMessageVeiw.isButton = str;
                    }
            }
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
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
- (void)hotelSignButtonWithPeopleAllUserId:(NSString *)userId
{
    if ([self.signRoomCount intValue] == 0) {
        [MBProgressHUD showHudTipStr:@"请输入正确的房间数" contentColor:HidWithColorContentBlack];
        return;
    }
    [self hotelSignRequest:userId];
}


- (void)isTrueHotelSign
{
    //弹出提示框
    [MBProgressHUD showHudTipStr:@"不在酒店范围内,无法签到!" contentColor:HidWithColorContentBlack];
}

#pragma mark - 酒店签到接口
- (void)hotelSignRequest:(NSString *)userId
{
    NSLog(@"---------->>>>>>>>>签到的房间数是:%zd",[self.signRoomCount intValue]);
    self.isHotelSignTime = YES;
    NSInteger findTeamInfoByState_Id;
    if (self.isEnter == YES) {
        findTeamInfoByState_Id = self.laterTeamControlItem.findNewTeamInfo_Id;
    }else {
        findTeamInfoByState_Id = self.isTeamId == YES ?
        [[NSString stringWithFormat:@"%zd",self.leftFindTeamInfoItem.findTeamInfoItem_id] intValue] :
        [[[NSUserDefaults standardUserDefaults] objectForKey:@"TEAMID"] intValue];
    }
    //[[NSUserDefaults standardUserDefaults] objectForKey:@"TEAMPEOPLENUMBER"]
    NSString *checkinNumber = self.isHotelSign ? self.hotelSignPeople : [[NSUserDefaults standardUserDefaults] objectForKey:@"TEAMPEOPLENUMBER"];
    //刚创建完团队,直接拿
    NSLog(@"<<<<<<<<=========刚进来的酒店的创建团队的人数是1:%zd",self.laterTeamControlItem.checkinNumber);
    NSLog(@"<<<<<<<<=========刚进来的酒店的创建团队的人数是2:%@",self.leftFindTeamInfoItem.teamNum);
    NSString *teamNumber;
    if (self.isEnter == YES) {//如果是刚进来就显示此刻的团队人数
        teamNumber = [NSString stringWithFormat:@"%zd",self.laterTeamControlItem.checkinNumber];
    }else {
        teamNumber = self.isTeamId == YES ? [NSString stringWithFormat:@"%d",[self.leftFindTeamInfoItem.teamNum intValue]] : [[NSUserDefaults standardUserDefaults] objectForKey:@"TEAMPEOPLENUMBER"];
    }
    //对参数的判断
    if ([checkinNumber intValue] == 0) {
        [MBProgressHUD showHudTipStr:@"请填写正确的签到人数" contentColor:HidWithColorContentBlack];
        return;
    }
    if ([checkinNumber intValue] > [teamNumber intValue]) {
        [MBProgressHUD showHudTipStr:@"签到人数不能大于开团人数" contentColor:HidWithColorContentBlack];
        return;
    }
    NSLog(@"=====+++++++-------->>>>>管理员的值是 :%@",userId);
    NSDictionary *dictParaments = @{
                                    @"teamId": [NSString stringWithFormat:@"%zd",findTeamInfoByState_Id],//团队
                                    @"attractionsId":[NSString stringWithFormat:@"%zd",self.FindAttractionsListItem.findAttractions_id],//景区id
                                    @"userIdList":[NSString stringWithFormat:@"%@",userId],//管理员id(可能是多个)
                                    @"checkinNumber":checkinNumber,//签到人数
                                    @"rooms":[NSString stringWithFormat:@"%@",self.signRoomCount]//房间数(可以不传)
                                    };
    NSLog(@"+++++++++++++提交的酒店签到的参数是 :%@",dictParaments);
    __weak __typeof(self)wself = self;
    [[NetWorkManager shareManager] requestWithType:HttpRequestTypeGet withUrlString:TEAMSIGNURL withParaments:dictParaments withSuccessBlock:^(id object) {
        if (object) {
            [wself setUpUserTimeWithUseApp:NO];
            [MBProgressHUD showHudTipStr:@"签到成功" contentColor:HidWithColorContentBlack];
            //将景区的BOOL值置为NO
            wself.isTaskTime = NO;
            [wself.hotel_view removeFromSuperview];
            [wself.maskView1 removeFromSuperview];
            [wself.view addSubview:self.signNoHotel_view];
            wself.signNoHotel_view.hotelSignPeopleCount = self.isHotelSign ? self.hotelSignPeople : [[NSUserDefaults standardUserDefaults] objectForKey:@"TEAMPEOPLENUMBER"];
            wself.signNoHotel_view.hotelSignRoomCount = self.signRoomCount;
        }
    } withFailureBlock:^(NSError *error) {
        if (error) {
            [MBProgressHUD showHudTipStr:@"网络问题,签到失败" contentColor:HidWithColorContentBlack];
        }
    } progress:^(float progress) {
        
    }];
}

- (XFJSignNoHotelView *)signNoHotel_view
{
    if (_signNoHotel_view == nil) {
        _signNoHotel_view = [[XFJSignNoHotelView alloc] initWithFrame:CGRectMake(6, SCREEN_HEIGHT - 130, SCREEN_WIDTH - 12, 125)];
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

- (void)isTureScSign
{
    //弹出提示框
    [MBProgressHUD showHudTipStr:@"不在景区范围内,无法签到!" contentColor:HidWithColorContentBlack];
}

- (void)signButtonClick1:(NSString *)teamNumber teamId:(NSString *)teamId userId:(NSString *)userId
{
    self.isTaskTime = YES;
    NSInteger findTeamInfoByState_Id;
    if (self.isEnter == YES) {
        findTeamInfoByState_Id = self.laterTeamControlItem.findNewTeamInfo_Id;
    }else {
        findTeamInfoByState_Id = self.isTeamId == YES ?
        [[NSString stringWithFormat:@"%zd",self.leftFindTeamInfoItem.findTeamInfoItem_id] intValue] :
        [[[NSUserDefaults standardUserDefaults] objectForKey:@"TEAMID"] intValue];
    }
    //用户的签到人数
    NSString *checkinNumber = self.isSignModify ? self.signModifyCount : [[NSUserDefaults standardUserDefaults] objectForKey:@"TEAMPEOPLENUMBER"];
    
    NSString *teamNumber1;
    if (self.isEnter == YES) {//如果是刚进来就显示此刻的团队人数
        teamNumber1 = [NSString stringWithFormat:@"%zd",self.laterTeamControlItem.checkinNumber];
    }else {
        teamNumber1 = self.isTeamId == YES ? [NSString stringWithFormat:@"%d",[self.leftFindTeamInfoItem.teamNum intValue]] : [[NSUserDefaults standardUserDefaults] objectForKey:@"TEAMPEOPLENUMBER"];
    }
    //对参数的判断
    if ([checkinNumber intValue] == 0) {
        [MBProgressHUD showHudTipStr:@"请填写正确的签到人数" contentColor:HidWithColorContentBlack];
        return;
    }
    if ([checkinNumber intValue] > [teamNumber1 intValue]) {
        [MBProgressHUD showHudTipStr:@"签到人数不能大于开团人数" contentColor:HidWithColorContentBlack];
        return;
    }
    NSDictionary *dictParaments = @{
                                    @"teamId":[NSString stringWithFormat:@"%zd",findTeamInfoByState_Id],//团队
                                    @"attractionsId":[NSString stringWithFormat:@"%zd",self.FindAttractionsListItem.findAttractions_id],//景区id
                                    @"userIdList":[NSString stringWithFormat:@"%@",userId],//管理员id(可能是多个)
                                    @"checkinNumber":checkinNumber,//签到人数
                                    @"rooms":@0//房间数
                                    };
    NSLog(@"接入的签到参数是:%@",dictParaments);
    __weak __typeof(self)wself = self;
    [[NetWorkManager shareManager] requestWithType:HttpRequestTypeGet withUrlString:TEAMSIGNURL withParaments:dictParaments withSuccessBlock:^(id object) {
        if ([[object objectForKey:@"msg"] isEqualToString:@"success"]) {//如果是这就表示签到成功
            [wself requestTeamSignList];
            //这里调用获取创建任务的当前时间
            [wself setUpUserTimeWithUseApp:NO];
            [wself setUpSignNoWithPeople];
            [MBProgressHUD showHudTipStr:@"签到成功!" contentColor:HidWithColorContentBlack];
        }else {
            [MBProgressHUD showHudTipStr:@"景区重复签到!" contentColor:HidWithColorContentBlack];
            self.isTaskTime = NO;
        }
    } withFailureBlock:^(NSError *error) {
        if (error) {
            [MBProgressHUD showHudTipStr:@"网络问题,签到失败!" contentColor:HidWithColorContentBlack];
        }
    } progress:^(float progress) {
        
    }];
}

#pragma mark - 获取团队任务列表
- (void)requestTeamSignList
{
    NSDictionary *dictParaments = @{
                                    @"teamId": self.isTeamId == YES ? [NSString stringWithFormat:@"%zd",self.leftFindTeamInfoItem.findTeamInfoItem_id] : [[NSUserDefaults standardUserDefaults] objectForKey:@"TEAMID"],
                                    @"taskState":@0
                                    };
    __weak __typeof(self)wself = self;
    [[NetWorkManager shareManager] requestWithType:HttpRequestTypeGet withUrlString:TEAMSIGNLISTURL withParaments:dictParaments withSuccessBlock:^(id object) {
        if (object) {
            NSDictionary *dictObject = [object objectForKey:@"rows"];
            wself.teamSignListArray = [XFJTeamSignListItem mj_objectArrayWithKeyValuesArray:dictObject];
            wself.signNoPeople_view.signNoPeopleArray = wself.teamSignListArray;
        }
    } withFailureBlock:^(NSError *error) {
        if (error) {
            [MBProgressHUD showHudTipStr:@"网络君错误!" contentColor:HidWithColorContentBlack];
        }
    } progress:^(float progress) {
    }];
}


- (XFJSignNoPeopleView *)signNoPeople_view
{
    if (_signNoPeople_view == nil) {
        _signNoPeople_view = [[XFJSignNoPeopleView alloc] initWithFrame:CGRectMake(6, SCREEN_HEIGHT - 85, SCREEN_WIDTH - 12, 78.0)];
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
    NSString *checkinNumber = self.isSignModify ? self.signModifyCount : [[NSUserDefaults standardUserDefaults] objectForKey:@"TEAMPEOPLENUMBER"];
    self.signNoPeople_view.teamNum = [checkinNumber integerValue];
}

- (void)panHandle:(UIPanGestureRecognizer *)panGesture
{
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
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:person];
    [self presentViewController:navVC animated:YES completion:nil];
}

- (void)remoSubViews
{
    [self openLeftView:NO];
    [self.maskView1 removeFromSuperview];
}

- (XFJAnnouncementView *)announcementView
{
    if (_announcementView == nil) {
        _announcementView = [[XFJAnnouncementView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 53)];
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
        [_location_button setFrame:CGRectMake(SCREEN_WIDTH - SCREEN_WIDTH * 0.1 - 10, 170, 41, 41)];
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
        _hotel_view.frame = CGRectMake(6, SCREEN_HEIGHT - 170, SCREEN_WIDTH - 12, 164);
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
        _task_view = [[XFJTaskView alloc] initWithFrame:CGRectMake(9, SCREEN_HEIGHT - 100, SCREEN_WIDTH - 15, 98.0)];
    }
    return _task_view;
}

- (XFJHomeTopTaskMessageVeiw *)homeTopTaskMessageVeiw
{
    if (_homeTopTaskMessageVeiw == nil) {
        _homeTopTaskMessageVeiw = [[XFJHomeTopTaskMessageVeiw alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 98.0)];
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
        [self.chooseScenerySignView removeFromSuperview];
        [self.chooseHotelSignView removeFromSuperview];
        [self.findAttracUserListView removeFromSuperview];
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
}

#pragma makr - 实现开团页面的代理方法(用于传值)
- (void)teamPeopleNumber:(NSString *)peopleNumber teamId:(NSString *)teamId
{
    self.teamNumber = [NSString stringWithFormat:@"%@",peopleNumber];
    self.teamId = [NSString stringWithFormat:@"%@",teamId];
    self.sign_view.peopleNumberStr = peopleNumber;
    
}

- (XFJSignView *)sign_view
{
    if (_sign_view == nil) {
        _sign_view = [[XFJSignView alloc] initWithFrame:CGRectMake(6, SCREEN_HEIGHT - 85, SCREEN_WIDTH - 12, 78.0)];
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
        [_mapView setZoomLevel:16.1 animated:YES];
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
            __weak __typeof(self)wself = self;
            UIAlertController *alertVc =[UIAlertController alertControllerWithTitle:@"提示" message:@"请在系统设置中打开定位服务" preferredStyle:UIAlertControllerStyleAlert];
            [alertVc addAction:[UIAlertAction actionWithTitle:@"忽略" style: UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
            }]];
            [alertVc addAction:[UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }]];
            [wself presentViewController:alertVc animated:NO completion:nil];
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
//    [self.manager stopUpdatingLocation];
    // 判断的手机的定位功能是否开启
    // 开启定位:设置 > 隐私 > 位置 > 定位服务
    if ([CLLocationManager locationServicesEnabled]) {
        // 启动位置更新
        // 开启位置更新需要与服务器进行轮询所以会比较耗电，在不需要时用stopUpdatingLocation方法关闭;
        [self.manager startUpdatingLocation];
    }else {
        __weak __typeof(self)wself = self;
        UIAlertController *alertVc =[UIAlertController alertControllerWithTitle:@"提示" message:@"请在设置 > 隐私 > 位置 > 定位服务”中打开定位服务" preferredStyle:UIAlertControllerStyleAlert];
        [alertVc addAction:[UIAlertAction actionWithTitle:@"知道了" style: UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
        }]];
        [alertVc addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }]];
        [wself presentViewController:alertVc animated:NO completion:nil];
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
            wself.leftView.currentCity = placeMark.locality;
            wself.currentProvince = placeMark.administrativeArea;
            if (!wself.currentCity) {
                wself.currentCity = @"无法定位当前城市";
            }
            wself.isFindTeamList == YES ? @"" : [wself requestLatelyControl];
            //发送获取当前位置用户周边的景区
            self.isProjectItem == NO ? @"" :
            [wself requestAttractionsListWithProvince:self.currentProvince city:wself.currentCity];
        }else if (error == nil && placemarks.count == 0) {
            NSLog(@"No location and error return");
        }else if (error) {
            NSLog(@"location error :%@",error);
        }
    }];
}

#pragma mark - 获取当前位置的景区信息
- (void)requestAttractionsListWithProvince:(NSString *)province city:(NSString *)city
{
    __weak __typeof(self)wself = self;
    NSLog(@"--------定位的当前城市是:%@-------当前省份是:%@",wself.currentCity,wself.currentProvince);
    NSInteger findTeamInfoByState_Id;
    if (self.isEnter == YES) {
        findTeamInfoByState_Id = wself.laterTeamControlItem.findNewTeamInfo_Id;
    }else {
        findTeamInfoByState_Id = self.isTeamId == YES ?
        [[NSString stringWithFormat:@"%zd",self.leftFindTeamInfoItem.findTeamInfoItem_id] intValue] :
        [[[NSUserDefaults standardUserDefaults] objectForKey:@"TEAMID"] intValue];
    }
    NSDictionary *dictParaments = @{
                                    @"teamId":[NSString stringWithFormat:@"%zd",findTeamInfoByState_Id]
                                    };
    NSLog(@"----------------根据景点获取到的额团队id是 :%@",[NSString stringWithFormat:@"%zd",findTeamInfoByState_Id]);
    [GRNetRequestClass POST:FINDATTRACTIONSLISTURL params:dictParaments success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject) {
            NSMutableArray *findAttractionArray = [responseObject objectForKey:@"rows"];
            wself.findAttractionsListArray = [XFJFindAttractionsListItem mj_objectArrayWithKeyValuesArray:findAttractionArray];
            NSLog(@"=======++++++++------------获取到的景点列表模型是:%zd",responseObject);
            //获取周围景点的数据,并用大头针显示出来
            [wself setSceneryInToMapView:wself.findAttractionsListArray];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"_______------+++++++++++++网络错误,打印错误信息是:%@",error);
            [MBProgressHUD showHudTipStr:@"网络错误" contentColor:HidWithColorContentBlack];
        }
    }];
}

#pragma mark - 获取用户周围景点的信息显示在地图上
- (void)setSceneryInToMapView:(NSMutableArray <XFJFindAttractionsListItem *> *)findAttractionsListArray
{
    [self.isYes_array removeAllObjects];
    //遍历所有的景点列表
    for (NSInteger i = 0; i < findAttractionsListArray.count; i++) {
        @autoreleasepool {
            //取出每个景点
            XFJFindAttractionsListItem *findAttractionsListItem = findAttractionsListArray[i];
            //定义一个字符串用来接收遍历的景点精度和纬度
            NSString *locationPoint = findAttractionsListItem.locationPoints;
            if (locationPoint.length == 0) {
                NSLog(@"景点坐标错误!");
                return;
            }
            //获取每个景点的景点类型值
            NSInteger stateType = findAttractionsListItem.typeState;
            //这里获取到了每一个景点的id
            NSInteger attractions_id = findAttractionsListItem.findAttractions_id;
            self.stateType = stateType;
            self.attractions_id = attractions_id;
            //先按分号截取并且装入数组中
            NSArray *strarray = [locationPoint componentsSeparatedByString:@";"];
             CLLocationCoordinate2D commonPolylineCoords[strarray.count + 1];//这是第一个折线对象i = 0;i = 1;i = 2
            //这是一个景点的所有坐标
            for (NSInteger i = 0; i < strarray.count; i++) {
                //取出每个景点的坐标
                XFJSceneryAnnotation *sceneryAnnotation = [[XFJSceneryAnnotation alloc] init];
                self.sceneryAnnotation = sceneryAnnotation;
                NSString *str = [strarray objectAtIndex:i];
                NSRange rang = [str rangeOfString:@","];
                NSString *str1 = [str substringToIndex:rang.location];
                NSString *str2 = [str substringFromIndex:rang.location + 1];
                if (i == 0) {
                    self.str1 = [str1 floatValue];
                    self.str2 = [str2 floatValue];
                }
                CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([str2 floatValue], [str1 floatValue]);
                //纬度和精度的赋值
                sceneryAnnotation.coordinate = coordinate;
                sceneryAnnotation.attractionsName = findAttractionsListItem.attractionsName;
                //将景点的大头针数组添加到数组中
                [self.annotationArray addObject:sceneryAnnotation];
                [self.mapView addAnnotation:sceneryAnnotation];
                //获取到景点所有的精度和纬度
                //构造折线对象strarray.count有这么多折线对象(5)
                commonPolylineCoords[i].latitude = [str2 floatValue];//0;1;2折线的纬度
                commonPolylineCoords[i].longitude = [str1 floatValue];//0;1;2折线的精度
            }
            //构造折线对象
            commonPolylineCoords[strarray.count + 1].latitude = self.str2;//0;1;2折线的纬度
            commonPolylineCoords[strarray.count + 1].longitude = self.str1;
            MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:strarray.count];
            [self.mapView addOverlay:commonPolyline];
            //判断是否在范围内
            BOOL isYes = [self setContains:commonPolylineCoords strarryCount:strarray.count];
            //如果是yes直接保存起来
            if (isYes) {//这里表示在范围内
                self.isContains = isYes;
                [self.isYes_array addObject:findAttractionsListItem];
                NSLog(@"r:%zd",self.isYes_array.count);
            }else {
                NSLog(@"-----------这里表示不在范围内,可以直接给用户提示框");
            }
        }
    }
    [self.scenery_array removeAllObjects];
    [self.hotel_array removeAllObjects];
    //这里遍历所有在范围内的点数
    for (NSInteger i = 0; i < self.isYes_array.count; i++) {
        XFJFindAttractionsListItem *findAttractionsListItem = [self.isYes_array objectAtIndex:i];
        NSInteger typeState = findAttractionsListItem.typeState;
        if (typeState == 0) {//景区
            [self.scenery_array addObject:findAttractionsListItem];
        }else {//这里表示酒店
            [self.hotel_array addObject:findAttractionsListItem];
            self.FindAttractionsListItem = findAttractionsListItem;
        }
    }
        self.chooseScenerySignView.scenery_array = self.scenery_array;
        self.chooseHotelSignView.hotel_array = self.hotel_array;
        self.isProjectItem == NO ? @"": [self requestWithInfoTasks];
}

#pragma mark - 随时更新用户的位子
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    //在这里一直获取用户的时间使用app的时间
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
    return @{
             @"dayString":dayString,
             @"hourString":hourString,
             @"minuteString":minuteString
             };
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
    }else {//开始任务的时间
        NSString *DateStartTime = [formatter stringFromDate:date];
        self.DateStartTime = DateStartTime;
    }
}

#pragma mark - 判断是否在折线范围内
- (BOOL)setContains:(CLLocationCoordinate2D *)polygon strarryCount:(NSInteger)strarryCount
{
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake([self.latitude floatValue], [self.longitude floatValue]);
    BOOL isContains = MAPolygonContainsCoordinate(location, polygon, strarryCount);
    return isContains;
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]]){
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] init];
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
        NSLog(@">>>>>>------------打印出大头针的地址是 :%@",sceneryAnnotation);
        if (annotationView == nil) {
            annotationView = [[XFJSceneryAnnotationView alloc] initWithAnnotation:sceneryAnnotation reuseIdentifier:sceneryReuseIdentifier];
        }
        //设置为NO,就是加载自己定义的calloutView
        annotationView.canShowCallout = NO;
        annotationView.draggable = YES;
        annotationView.enabled = YES;
        annotationView.sceneryAnnotation = sceneryAnnotation;
        return annotationView;
    }else {
        //用户的大头针
        static NSString *trackingReuseIndetifier = @"loctionUserAnnotation_1";
        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:trackingReuseIndetifier];
        if (!annotationView) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:trackingReuseIndetifier];
        }
        annotationView.draggable = YES;
        annotationView.enabled = YES;
        NSLog(@"打印出来可签到的景区和酒店是 :%@",self.isYes_array);
        NSLog(@">>>>>>>>>>>用户的经度是:%@-------纬度是:%@",self.longitude,self.latitude);
//        annotationView.annotation.title = [NSString stringWithFormat:@"%@",self.firstPlacemark];
//        NSLog(@"<<<<<<------------地理位置是 :%@",longLat);
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

- (void)latitudeStr:(NSString *)Latitude LongitudeStr:(NSString *)Longitude
{
    CLLocationDegrees latitude = [Latitude doubleValue];
    CLLocationDegrees longitude = [Longitude doubleValue];
    CLLocation *location = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    //2.反地理编码
    __weak __typeof(self)wself = self;
     [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
         if (error || placemarks.count == 0) {
             [MBProgressHUD showHudTipStr:@"您所在的位置不确定" contentColor:HidWithColorContentBlack];
             }else{
                //显示最前面的地标信息
                CLPlacemark *firstPlacemark = [placemarks firstObject];
                 wself.firstPlacemark = firstPlacemark;
                NSLog(@">>>>>>>>地点名称是 :%@",firstPlacemark.locality);
        }
    }];
}




@end

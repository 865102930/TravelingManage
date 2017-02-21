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


@interface HomeViewController ()<MAMapViewDelegate,XFJLeftViewDelegate,CLLocationManagerDelegate>

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
    //这是添加的公告
//    [self.view addSubview:self.announcementView];
    [self.view addSubview:self.task_view];
    [self.maskView1 addSubview:self.leftView];
    //这是添加的home顶部的任务
    [self.view addSubview:self.homeTopTaskMessageVeiw];
    [self setUpPanGes];
    
    //获取当前用户的位置信息
    [self getUserLocation];
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
    self.task_view.openGroupBlock = ^(){
        [wself jumpNewProjectController];
    };
    self.leftView.pushMineTeamBlock = ^() {
        [wself remoSubViews];
        XFJMineTeamViewController *mineTeamController = [[XFJMineTeamViewController alloc] init];
        [wself.navigationController pushViewController:mineTeamController animated:YES];
    };
    self.homeTopTaskMessageVeiw.jumpWithTeamMessageBlock = ^() {
        XFJTeamMessageViewController *teamMessageViewController = [[XFJTeamMessageViewController alloc] init];
        [wself.navigationController pushViewController:teamMessageViewController animated:YES];
    };
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

- (void)remoSubViews
{
    [self openLeftView:NO];
    [self.maskView1 removeFromSuperview];
}

- (XFJAnnouncementView *)announcementView
{
    if (_announcementView == nil) {
        _announcementView = [[XFJAnnouncementView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 49)];
    }
    return _announcementView;
}

- (XFJTaskView *)task_view
{
    if (_task_view == nil) {
        _task_view = [[XFJTaskView alloc] initWithFrame:CGRectMake(9, SCREEN_HEIGHT - 98, SCREEN_WIDTH - 15, 98.0)];
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
    openGroupViewController.locationWithUser = self.currentCity;
    [self.navigationController pushViewController:openGroupViewController animated:YES];
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
    self.manager.desiredAccuracy=kCLLocationAccuracyBest;
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
}

#pragma mark - 获取到用户的精度和纬度转换为具体的位置信息
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    //停止更新定位
    [self.manager stopUpdatingLocation];
    //旧的值
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            self.currentCity = placeMark.locality;
            if (!self.currentCity) {
                self.currentCity = @"无法定位当前城市";
            }
            NSLog(@"--------定位的当前城市是:%@",self.currentCity);
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


@end

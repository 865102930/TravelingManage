//
//  XFJOpenGroupViewController.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/10.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJOpenGroupViewController.h"
#import "XFJConventionMessageTableViewCell.h"
#import "XFJCarNameTableViewCell.h"
#import "XFJGuestSourceInformationTableViewCell.h"
#import "XFJTeamInformationTableViewCell.h"
#import <IQKeyboardManager.h>
#import "XFJOtherInformationTableViewCell.h"
#import "XFJUploadPhotosTableViewCell.h"
#import "XFJStarTaskTableViewCell.h"
#import "HomeViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "TZImagePickerController.h"
#import "WSImagePickerView.h"
#import "WSPhotosBroseVC.h"
#import "XFJMinusCarNumTableViewCell.h"
#import "XFJVoucherPhotosView.h"
#import "JTNavigationController.h"
#import "XFJHeaderView.h"
#import "XFJCarNumberItem.h"

@interface XFJOpenGroupViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate,XFJUploadPhotosTableViewCellDelegate,UIScrollViewDelegate,XFJVoucherPhotosViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIBarButtonItem *pushToLeftViewButton;
@property (nonatomic, strong) UILabel *title_label;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, assign) NSInteger maxImageCount;
@property (nonatomic, assign) NSInteger maxImageToCount;
@property (nonatomic, strong) NSMutableArray *indexPaths;
@property (nonatomic, assign) NSInteger totalCount;
@property (nonatomic, strong) UIScrollView *scroll_view;
@property (nonatomic, strong) XFJConventionMessageTableViewCell *conventionMessage_view;
@property (nonatomic, strong) XFJCarNameTableViewCell *carName_view;
@property (nonatomic, strong) XFJGuestSourceInformationTableViewCell *guestSourceInformation_view;
@property (nonatomic, strong) XFJTeamInformationTableViewCell *teamInformation_view;
@property (nonatomic, strong) XFJOtherInformationTableViewCell *otherInformation_view;
@property (nonatomic, strong) XFJUploadPhotosTableViewCell *uploadPhotos_view;
@property (nonatomic, strong) XFJStarTaskTableViewCell *starTask_view;
@property (nonatomic, strong) XFJVoucherPhotosView *voucherPhotos_view;
@property (nonatomic, strong) XFJMinusCarNumTableViewCell *minusCarNum_view;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIView *backGroundView;
@property (nonatomic, assign) NSInteger remberButtonClick;//用来记住按钮的点击次数
@property (nonatomic, strong) NSMutableArray *allRootImage;
@property (nonatomic, strong) NSString *root;
@property (nonatomic, strong) NSString *voucherPicRoot;
@property (nonatomic, strong) NSString *carNumber;
@property (nonatomic, strong) UITableView *carNumber_tableView;
@property (nonatomic, strong) XFJHeaderView *header_view;
@property (nonatomic, strong) NSMutableArray *addArray;
@property (nonatomic, strong) NSMutableArray<XFJCarNumberItem *> *carNumberArray;
@property (nonatomic, strong) NSString *strNum;
@property (nonatomic, strong) NSString *dict1;

@end

@implementation XFJOpenGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpLeftBarButtonItem];
    
    [self setUpOpenGroup];
}

- (UILabel *)title_label
{
    if (_title_label == nil) {
        _title_label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.XFJ_centerX, 6, 100, 44)];
        _title_label.text = @"开团";
        _title_label.textColor = kColor6565;
        _title_label.textAlignment = NSTextAlignmentCenter;
    }
    return _title_label;
}

- (NSMutableArray <XFJCarNumberItem *> *)carNumberArray
{
    if (_carNumberArray == nil) {
        _carNumberArray = [NSMutableArray array];
    }
    return _carNumberArray;
}

- (NSMutableArray *)addArray
{
    if (_addArray == nil) {
        _addArray = [NSMutableArray array];
    }
    return _addArray;
}

- (NSMutableArray *)allRootImage
{
    if (_allRootImage == nil) {
        _allRootImage = [NSMutableArray array];
    }
    return _allRootImage;
}

- (UIScrollView *)scroll_view
{
    if (_scroll_view == nil) {
        _scroll_view = [[UIScrollView alloc] init];
        _scroll_view.frame = CGRectMake(0, 64, self.view.bounds.size.width, 1.2 * self.view.XFJ_Height);
        _scroll_view.delegate = self;
        _scroll_view.contentSize = CGSizeMake(0, self.view.XFJ_Height * 2.5);
        _scroll_view.backgroundColor = [UIColor whiteColor];
        _scroll_view.showsHorizontalScrollIndicator = NO;
        _scroll_view.scrollEnabled = YES;
    }
    return _scroll_view;
}

- (XFJHeaderView *)header_view
{
    if (_header_view == nil) {
        _header_view = [[XFJHeaderView alloc] initWithFrame:CGRectMake(0, 195, SCREEN_WIDTH, 270.0)];
    }
    return _header_view;
}

- (XFJConventionMessageTableViewCell *)conventionMessage_view
{
    if (_conventionMessage_view == nil) {
        _conventionMessage_view = [[XFJConventionMessageTableViewCell alloc] init];
    }
    return _conventionMessage_view;
}

- (XFJCarNameTableViewCell *)carName_view
{
    if (_carName_view == nil) {
        _carName_view = [[XFJCarNameTableViewCell alloc] initWithFrame:CGRectMake(0, 195, SCREEN_WIDTH, 50.0)];
    }
    return _carName_view;
}

- (XFJGuestSourceInformationTableViewCell *)guestSourceInformation_view
{
    if (_guestSourceInformation_view == nil) {
        _guestSourceInformation_view = [[XFJGuestSourceInformationTableViewCell alloc] init];
    }
    return _guestSourceInformation_view;
}

- (XFJTeamInformationTableViewCell *)teamInformation_view
{
    if (_teamInformation_view == nil) {
        _teamInformation_view = [[XFJTeamInformationTableViewCell alloc] init];
    }
    return _teamInformation_view;
}

- (XFJOtherInformationTableViewCell *)otherInformation_view
{
    if (_otherInformation_view == nil) {
        _otherInformation_view = [[XFJOtherInformationTableViewCell alloc] init];
    }
    return _otherInformation_view;
}

- (XFJUploadPhotosTableViewCell *)uploadPhotos_view
{
    if (_uploadPhotos_view == nil) {
        _uploadPhotos_view = [[XFJUploadPhotosTableViewCell alloc] initWithFrame:CGRectMake(0, 390, SCREEN_WIDTH, 200)];
        _uploadPhotos_view.delegate = self;
    }
    return _uploadPhotos_view;
}

- (XFJStarTaskTableViewCell *)starTask_view
{
    if (_starTask_view == nil) {
        _starTask_view = [[XFJStarTaskTableViewCell alloc] init];
    }
    return _starTask_view;
}

- (XFJVoucherPhotosView *)voucherPhotos_view
{
    if (_voucherPhotos_view == nil) {
        _voucherPhotos_view = [[XFJVoucherPhotosView alloc] init];
        _voucherPhotos_view.delegate = self;
    }
    return _voucherPhotos_view;
}
- (XFJMinusCarNumTableViewCell *)minusCarNum_view
{
    if (_minusCarNum_view == nil) {
        _minusCarNum_view = [[XFJMinusCarNumTableViewCell alloc] init];
    }
    return _minusCarNum_view;
}

- (UITableView *)carNumber_tableView
{
    if (_carNumber_tableView == nil) {
        _carNumber_tableView = [[UITableView alloc] init];
        _carNumber_tableView.delegate = self;
        _carNumber_tableView.dataSource = self;
        _carNumber_tableView.bounces = NO;
        _carNumber_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _carNumber_tableView.tag = 10004;
    }
    return _carNumber_tableView;
}



- (UIView *)backGroundView
{
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 250, SCREEN_WIDTH, SCREEN_HEIGHT * 2)];
        _backGroundView.backgroundColor = [UIColor whiteColor];
    }
    return _backGroundView;
}

#pragma mark - 处理左侧导航栏
- (void)setUpLeftBarButtonItem
{
    //    self.navigationItem.leftBarButtonItem = self.pushToLeftViewButton;
    self.navigationItem.titleView = self.title_label;
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    keyboardManager.shouldResignOnTouchOutside = YES;
    keyboardManager.keyboardDistanceFromTextField = 50;
}

- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)datas
{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}


#pragma mark - 添加主内容
- (void)setUpOpenGroup
{
    [self.carNumber_tableView registerClass:[XFJCarNameTableViewCell class] forCellReuseIdentifier:kReuseIdentifier_XFJCarNameTableViewCell];
    [self.carNumber_tableView registerClass:[XFJMinusCarNumTableViewCell class] forCellReuseIdentifier:kReuseIdentifier_XFJMinusCarNumTableViewCell];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.scroll_view];
    [self.scroll_view addSubview:self.header_view];
    [self.scroll_view addSubview:self.backGroundView];
    [self.scroll_view addSubview:self.conventionMessage_view];
    [self.header_view addSubview:self.carNumber_tableView];
//    [self.backGroundView addSubview:self.otherInformation_view];
    [self.backGroundView addSubview:self.uploadPhotos_view];
    [self.backGroundView addSubview:self.teamInformation_view];
    [self.backGroundView addSubview:self.guestSourceInformation_view];
    [self.backGroundView addSubview:self.voucherPhotos_view];
    [self.backGroundView addSubview:self.starTask_view];
    [self.conventionMessage_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(195);
    }];
    [self.guestSourceInformation_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backGroundView.mas_top);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(170.0);
    }];
    [self.teamInformation_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.guestSourceInformation_view.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(208.0);
    }];
//    [self.otherInformation_view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.teamInformation_view.mas_bottom);
//        make.width.mas_equalTo(SCREEN_WIDTH);
//        make.height.mas_equalTo(110);
//    }];
    [self.voucherPhotos_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.uploadPhotos_view.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(170.0);
        make.left.mas_equalTo(self.uploadPhotos_view.mas_left);
    }];
    [self.starTask_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.voucherPhotos_view.mas_bottom).mas_offset(0);
        make.height.mas_equalTo(110);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    [self.carNumber_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.header_view.mas_top);
        make.left.mas_equalTo(self.header_view.mas_left);
        make.right.mas_equalTo(self.header_view.mas_right);
        make.height.mas_equalTo(45.0);
    }];
    __weak __typeof(self)wself = self;
    self.starTask_view.startTaskButtonBlock = ^() {
        //该处提交用户填写的创建团队时候的参数
        [wself requestWithOpenTeam];
    };
    [self requestFindCarNumberWithUserlocation:self.locationWithUser];
    self.carName_view.userLocation = self.locationWithUser;
}

//- (void)setFindTeamInfoByStateItem:(XFJFindTeamInfoByStateItem *)findTeamInfoByStateItem
//{
//    _findTeamInfoByStateItem = findTeamInfoByStateItem;
//    self.conventionMessage_view.findTeamInfoByStateItem = findTeamInfoByStateItem;
//    self.teamInformation_view.findTeamInfoByStateItem = findTeamInfoByStateItem;
//}

- (void)requestFindCarNumberWithUserlocation:(NSString *)userLocation;
{
    if (userLocation.length == 0) {
        return;
    }
    NSDictionary *dictParaments = @{
                                    @"city": userLocation
                                    };
    
    __weak __typeof(self)wself = self;
    [[NetWorkManager shareManager] requestWithType:HttpRequestTypeGet withUrlString:FINDCARNUMBERURL withParaments:dictParaments withSuccessBlock:^(id object) {
        if (object) {
            NSMutableArray *carArray = [object objectForKey:@"rows"];
            self.carNumberArray = [XFJCarNumberItem mj_objectArrayWithKeyValuesArray:carArray];
            NSLog(@"wself.carName_field.text的值是 :%@",wself.carNumberArray);
        }
    } withFailureBlock:^(NSError *error) {
        if (error) {
            [MBProgressHUD showHudTipStr:@"网络错误" contentColor:HidWithColorContentBlack];
        }
    } progress:^(float progress) {
    }];
}

#pragma mark - 发送请求
- (void)requestWithOpenTeam
{
    //上传图片
    [self upLoadPic];
    [self upLoadVoucherPic];
}

#pragma mark - 图片上传车辆照片
- (void)upLoadPic
{
    if (self.dataArr.count == 0) {
        NSLog(@"图片上传失败------");
        [MBProgressHUD showHudTipStr:@"请上传车辆图片" contentColor:HidWithColorContentBlack];
    }else {
        for (int i = 0; i < _dataArr.count; i++) {
            UIImage *image = _dataArr[i];
            NSData *imageData = [UIImage compressImage:image maxSize:300];
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            __weak __typeof(self)wself = self;
            [manager POST:UPLOADIMAGE parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                [formData appendPartWithFileData:imageData name:@"file" fileName:@"image.jpg" mimeType:@"image/jpg"];
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSString *root = dict[@"object"];
                [wself.allRootImage addObject:root];
                wself.root = [wself.allRootImage componentsJoinedByString:@","];
                NSLog(@"上传图片成功后的信息-------%@+++++++%@",root,wself.root);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"上传图片失败--------%@",error);
            }];
        }
    }
}

#pragma mark - 上传凭证
- (void)upLoadVoucherPic
{
    if (self.dataArray.count == 0) {
        [MBProgressHUD showHudTipStr:@"请上传凭证照片" contentColor:HidWithColorContentBlack];
    }else {
        UIImage *image = self.dataArray[0];
        NSData *imageData = [UIImage compressImage:image maxSize:300];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        __weak __typeof(self)wself = self;
        [manager POST:UPLOADIMAGE parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:imageData name:@"file" fileName:@"image.jpg" mimeType:@"image/jpg"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSString *root = dict[@"object"];
            wself.voucherPicRoot = root;
            NSLog(@"上传图片成功后的信息-------%@",root);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (wself.root.length == 0) {
                    [MBProgressHUD showHudTipStr:@"图片上传失败~~" contentColor:HidWithColorContentBlack];
                    return ;
                }
                //开始任务的请求
                [wself startTaskButtonClick];
            });
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"上传图片失败--------%@",error);
        }];
    }
}

#pragma mark - 开始任务
- (void)startTaskButtonClick
{
    NSNumber *traveName = [NSNumber numberWithInteger:self.conventionMessage_view.travelName];
    NSNumber *paramName1 = [NSNumber numberWithInteger:self.guestSourceInformation_view.paramName1];
    NSNumber *teamNature = [NSNumber numberWithInteger:self.teamInformation_view.teamNature];
    if (self.conventionMessage_view.groupName_text == nil || self.conventionMessage_view.groupTime_text == nil || traveName == nil || self.strNum == nil || self.guestSourceInformation_view.selectedProvince == nil || self.guestSourceInformation_view.selectedCity == nil || self.guestSourceInformation_view.selectedArea == nil || paramName1 == nil || teamNature == nil || self.teamInformation_view.teamPeople_number == nil || self.teamInformation_view.teamDay == nil) {
        self.voucherPicRoot = nil;
        self.root = nil;
        [MBProgressHUD showHudTipStr:@"主人~~请完善必填信息" contentColor:HidWithColorContentBlack];
        return;
    }
    NSDictionary *dictParaments = @{
                                    @"teamNo":self.conventionMessage_view.groupName_text,//团队编号
                                    @"teamDate":self.conventionMessage_view.groupTime_text,//出团日期
                                    @"travelAgencyId":traveName,//旅行社id
                                    @"teamVehicles":self.strNum,//车牌
                                    @"province":self.guestSourceInformation_view.selectedProvince,//用户所在省
                                    @"city":self.guestSourceInformation_view.selectedCity,//用户所在市
                                    @"area":self.guestSourceInformation_view.selectedArea,//用户所在区
                                    @"teamAttr":paramName1,//团队目的属性
                                    @"teamNature":teamNature,//团队性质
                                    @"teamNum":self.teamInformation_view.teamPeople_number,//团队人数
                                    @"teamDay":self.teamInformation_view.teamDay,//团队天数
                                    @"createuser":@7,//创建记录的用户id
                                    @"certificateImg":self.voucherPicRoot,//凭证图片路径
                                    @"teamVehicleImages":self.root,//车辆图片集合用,分割
                                    @"userId":[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"]//导游id
                                    };
    NSLog(@"参数集合-----%@----%@---%@---%zd---%@----%@---%@----%@----%zd----%zd---%@---%@---%@---%@---%@",@7,self.conventionMessage_view.groupName_text,self.conventionMessage_view.groupTime_text,traveName,self.strNum,self.guestSourceInformation_view.selectedProvince,self.guestSourceInformation_view.selectedCity,self.guestSourceInformation_view.selectedArea,paramName1,teamNature,self.teamInformation_view.teamPeople_number,self.teamInformation_view.teamDay,@7,self.voucherPicRoot,self.root);
    __weak __typeof(self)wself = self;
    [[NetWorkManager shareManager] requestWithType:HttpRequestTypeGet withUrlString:MODIFYTEAMINFOURL withParaments:dictParaments withSuccessBlock:^(id object) {
        if (object) {
            NSLog(@"+++++======---------团队创建成功,成功信息是:%@",object);
            NSDictionary *dict = [object objectForKey:@"object"];
            self.dict1 = [dict objectForKey:@"id"];
            NSLog(@"+++++===========提取到的id是:%@",self.dict1);
            HomeViewController *homeController = [[HomeViewController alloc] init];
            JTNavigationController *navVC = [[JTNavigationController alloc] initWithRootViewController:homeController];
            //将用户填写的信息保存起来
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:[NSString stringWithFormat:@"%@",self.conventionMessage_view.groupName_text] forKey:@"CARNUMBERSTR"];
            [userDefaults setObject:[NSString stringWithFormat:@"%@%@%@",wself.guestSourceInformation_view.selectedProvince,wself.guestSourceInformation_view.selectedCity,wself.guestSourceInformation_view.selectedArea] forKey:@"PEOPLEWHEREFROMSTR"];
            [userDefaults setObject:[NSString stringWithFormat:@"%@",wself.conventionMessage_view.groupTime_text] forKey:@"OPENTEAMTIMESTR"];
            [userDefaults setObject:[NSString stringWithFormat:@"%@",wself.teamInformation_view.teamPeople_number] forKey:@"TEAMPEOPLENUMBER"];
            [userDefaults setObject:[NSString stringWithFormat:@"%@",self.dict1]forKey:@"TEAMID"];
            [userDefaults synchronize];
            //将值传到home控制器中
            //            if (wself.signViewBlock) {
            //                wself.signViewBlock(wself.teamInformation_view.teamPeople_number,self.dict1);
            //            }
            homeController.isProjectItem = YES;
            homeController.isFindTeamList = YES;
            [wself presentViewController:navVC animated:YES completion:nil];
        }
    } withFailureBlock:^(NSError *error) {
        if (error) {
            NSLog(@"+++++++++++++++++++++_______团队创建失败,失败信息是:%@",error);
            [MBProgressHUD showHudTipStr:@"网络请求失败~~" contentColor:HidWithColorContentBlack];
        }
    } progress:^(float progress) {
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    if (self.signViewBlock != nil) {
        self.signViewBlock(self.teamInformation_view.teamPeople_number,self.dict1);
    }
}


- (UIBarButtonItem *)pushToLeftViewButton
{
    if (_pushToLeftViewButton == nil) {
        _pushToLeftViewButton = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"yonghu"] hightImage:nil target:self action:@selector(pushToUserController)];
    }
    return _pushToLeftViewButton;
}
- (void)pushToUserController
{
    NSLog(@"主人,您push到了侧滑栏~~");
}

#pragma makr - 访问照相机
- (void)chooseImage:(XFJUploadPhotosTableViewCell *)SerPhotoCell
{
    self.maxImageCount = 6;
    UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:@"请选择相机或者相册" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择",nil];
    [action showInView:self.view];
    
}

- (void)chooseVoucherPhotosImage:(XFJVoucherPhotosView *)voucherPhotos
{
    self.maxImageCount = 1;
    UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:@"请选择相机或者相册" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择",nil];
    [action showInView:self.view];
}



- (void)jumpCell:(XFJUploadPhotosTableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    if(indexPath.row < _dataArr.count) {
        for (UIImage *image in _dataArr) {
            WSImageModel *model = [[WSImageModel alloc] init];
            model.image = image;
            [tmpArray addObject:model];
        }
        WSPhotosBroseVC *vc = [[WSPhotosBroseVC alloc] init];;
        vc.imageArray = tmpArray;
        vc.showIndex = indexPath.row;
        __weak typeof (self)weakself = self;
        vc.completion = ^ (NSArray *array){
            dispatch_async(dispatch_get_main_queue(), ^{
                [_dataArr removeAllObjects];
                [_dataArr addObjectsFromArray:array];
                weakself.uploadPhotos_view.dataArr = _dataArr;
                if (_dataArr.count <= 4) {
                    self.uploadPhotos_view.frame = CGRectMake(0, 390, SCREEN_WIDTH, 200);
                }
            });
        };
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)jumpToCell:(XFJVoucherPhotosView *)cell indexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    if(indexPath.row < _dataArray.count) {
        for (UIImage *image in _dataArray) {
            WSImageModel *model = [[WSImageModel alloc] init];
            model.image = image;
            [tmpArray addObject:model];
        }
        WSPhotosBroseVC *vc = [[WSPhotosBroseVC alloc] init];;
        vc.imageArray = tmpArray;
        vc.showIndex = indexPath.row;
        __weak typeof (self)weakself = self;
        vc.completion = ^ (NSArray *array){
            dispatch_async(dispatch_get_main_queue(), ^{
                [_dataArray removeAllObjects];
                [_dataArray addObjectsFromArray:array];
                weakself.voucherPhotos_view.dataArr = _dataArray;
                //                if (_dataArr.count <= 4) {
                //                    self.uploadPhotos_view.frame = CGRectMake(0, 728, SCREEN_WIDTH, 200);
                //                }
            });
        };
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self openCamera];
            break;
        case 1:
            [self openAlbum];
            break;
        default:
            break;
    }
}

- (void)openCamera
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        ipc.delegate = self;
        [self presentViewController:ipc animated:YES completion:nil];
    } else {
        //        [MBProgressHUD showHUDMsg: @"请打开允许访问相机权限"];
        NSLog(@"请打开允许访问相机权限");
    }
}

- (void)openAlbum
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxImageCount - (self.maxImageCount == 6 ? self.dataArr.count : self.dataArray.count) delegate:self];
        
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }else{
        //        [MBProgressHUD showHUDMsg: @"请打开允许访问相册权限" ];
    }
}

//相机选的图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    if (self.maxImageCount == 6) {
        UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self.dataArr addObject:image];
        [picker dismissViewControllerAnimated:YES completion:nil];
        self.uploadPhotos_view.dataArr = self.dataArr;
        self.uploadPhotos_view.maxImageCount = 6;
    }else {
        NSLog(@"self.maxImageCount == 1");
        UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self.dataArray addObject:image];
        [picker dismissViewControllerAnimated:YES completion:nil];
        self.voucherPhotos_view.dataArr = self.dataArray;
        self.voucherPhotos_view.maxImageCount = 1;
    }
}

//取消按钮
- (void)imagePickerControllerDidCancel:(TZImagePickerController *)picke{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 相册选的图片
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    if (self.maxImageCount == 6) {
        [self.dataArr addObjectsFromArray:photos];
        self.uploadPhotos_view.dataArr = self.dataArr;
        self.uploadPhotos_view.maxImageCount = 6;
        if (self.dataArr.count < 4) {
        }else {
            self.uploadPhotos_view.frame = CGRectMake(0, 390, SCREEN_WIDTH, 290);
        }
    }else {
        NSLog(@"self.maxImageCount == 1----------");
        [self.dataArray addObjectsFromArray:photos];
        self.voucherPhotos_view.dataArr = self.dataArray;
        self.voucherPhotos_view.maxImageCount = 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"能到这的cell个数是:%zd",1 + [self.addArray count]);
    return 1 + [self.addArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        XFJCarNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier_XFJCarNameTableViewCell forIndexPath:indexPath];
        cell.carNumberItemArray = self.carNumberArray;
        NSLog(@"self.carNumberArray的值是:%@",self.carNumberArray);
        __weak typeof(self) weakself = self;
        cell.addCellBlock = ^(NSInteger srt,NSString *str1) {
            [weakself addButtonClick];
        };
        cell.carNumberBlock = ^(NSString *carNum) {
            NSLog(@"接收到的车牌号码是:%@",carNum);
            weakself.strNum = carNum;
        };
        return cell;
    }else {
        XFJMinusCarNumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier_XFJMinusCarNumTableViewCell forIndexPath:indexPath];
        __weak typeof(self) weakself = self;
        cell.minusCarNumBlock = ^() {
            [weakself add];
        };
        return cell;
    }
    return nil;
}

- (void)add
{
    NSArray *visibleCells = [self.carNumber_tableView visibleCells];
    self.carNumber_tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.addArray.count * 45);
    self.backGroundView.frame = CGRectMake(0, 210 + self.addArray.count * 45, SCREEN_WIDTH, SCREEN_HEIGHT * 2);
    for (XFJMinusCarNumTableViewCell *cell in visibleCells) {
        [self.addArray removeObjectAtIndex:cell.tag];
        NSLog(@"cell的tag值是 :%zd",cell.tag);
        [self.carNumber_tableView reloadData];
        break;
    }
}


- (void)addButtonClick
{
    NSArray *visibleCells = [self.carNumber_tableView visibleCells];
    if (visibleCells.count > 5) {
        return;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    [self.addArray addObject: indexPath];
    NSLog(@"后面添加的数组个数是 :%zd",self.addArray.count);
    self.carNumber_tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, (self.addArray.count + 1) * 45);
    self.backGroundView.frame = CGRectMake(0, 210 + (self.addArray.count + 1) * 45, SCREEN_WIDTH, SCREEN_HEIGHT * 2);
    [self.carNumber_tableView insertRowsAtIndexPaths:self.addArray withRowAnimation:UITableViewRowAnimationLeft];
    [self.carNumber_tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 45;
    }else {
        return 45;
    }
}

- (void)dealloc
{
    NSLog(@"该控制器被销毁了~~~~~%s",__func__);
}








@end
